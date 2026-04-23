import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:habo/services/sync_service.dart';
import 'package:habo/services/sync_error.dart';
import 'package:habo/services/encryption_service.dart';
import 'package:habo/services/service_locator.dart';

import 'package:habo/settings/settings_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Sync status states for UI display
enum SyncStatus {
  /// No sync in progress, no pending changes
  idle,

  /// Sync is currently in progress
  syncing,

  /// Last sync completed successfully
  synced,

  /// Last sync failed
  error,

  /// No network or not logged in
  offline,

  /// User not authenticated or no encryption key
  notConfigured,

  /// No active subscription
  noSubscription,
}

/// Manages automatic synchronization with debounce and lifecycle awareness.
///
/// Implements [WidgetsBindingObserver] to sync on app lifecycle changes:
/// - Pushes data when app goes to background
/// - Pulls data when app returns to foreground
class SyncManager with WidgetsBindingObserver {
  static const _logName = 'SyncManager';

  final SyncService _syncService;
  final EncryptionService _encryptionService;
  final SettingsManager _settingsManager;
  final SupabaseClient _supabaseClient;

  Timer? _debounceTimer;
  bool _isSyncing = false;
  SyncStatus _status = SyncStatus.idle;
  DateTime? _lastSyncTime;
  RealtimeChannel? _realtimeSubscription;
  StreamSubscription<AuthState>? _authSubscription;

  /// Detected clock drift in seconds (positive = local ahead).
  /// `null` means not yet measured.
  int? _clockDriftSeconds;

  /// Last error that occurred during sync, if any.
  /// Cleared on successful sync.
  HaboSyncException? _lastError;

  final _statusController = StreamController<SyncStatus>.broadcast();
  final _dataChangedController = StreamController<void>.broadcast();

  /// Stream of sync status changes for UI binding
  Stream<SyncStatus> get statusStream => _statusController.stream;

  /// Stream that emits when data has been changed by a pull sync.
  /// Listeners should reload their data from the local database.
  Stream<void> get onDataChanged => _dataChangedController.stream;

  /// Current sync status
  SyncStatus get status => _status;

  /// Last successful sync time
  DateTime? get lastSyncTime => _lastSyncTime;

  /// The last error that occurred, or `null` if the last operation succeeded.
  HaboSyncException? get lastError => _lastError;

  /// Detected clock drift in seconds (positive = local ahead).
  /// `null` means not yet measured. Absolute value > 60 is considered risky
  /// for LWW conflict resolution.
  int? get clockDriftSeconds => _clockDriftSeconds;

  /// Whether the user is configured for sync (has encryption key)
  bool _isConfigured = false;

  SyncManager(
    this._syncService,
    this._encryptionService,
    this._settingsManager, {
    SupabaseClient? client,
  }) : _supabaseClient = client ?? Supabase.instance.client {
    _checkConfiguration();
  }

  /// Initialize the manager and register lifecycle observer
  void initialize() {
    WidgetsBinding.instance.addObserver(this);

    _authSubscription = _supabaseClient.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn ||
          (data.event == AuthChangeEvent.initialSession &&
              data.session != null)) {
        // If we get a session and were not configured, refresh.
        // We delay slightly to let other auth-dependent services catch up.
        Future.microtask(() => refreshConfiguration());
      } else if (data.event == AuthChangeEvent.signedOut) {
        onSignOut();
      }
    });

    _checkConfiguration().then((_) {
      if (_isConfigured) {
        // Initial sync on app start
        pullSync();
      }
    });
  }

  /// Cleanup when no longer needed
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription?.cancel();
    _unsubscribeRealtime();
    _debounceTimer?.cancel();
    _statusController.close();
    _dataChangedController.close();
  }

  /// Check if user is configured for sync.
  ///
  /// Evaluates auth → subscription → encryption key in order and emits the
  /// appropriate [SyncStatus] so the UI indicator stays accurate without
  /// needing its own duplicate checks.
  Future<void> _checkConfiguration() async {
    // 1. Auth check
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      _isConfigured = false;
      _updateStatus(SyncStatus.notConfigured);
      return;
    }

    // 2. Subscription check — ensure RevenueCat is initialized first so we
    //    get the real subscription status instead of relying on the Supabase
    //    webhook fallback (which may be stale or absent).
    try {
      final subscriptionService = ServiceLocator.instance.subscriptionService;
      await subscriptionService.initialize();
      final isSubscribed = await subscriptionService.isSubscribed();
      if (!isSubscribed) {
        _isConfigured = false;
        _updateStatus(SyncStatus.noSubscription);
        return;
      }
    } on SubscriptionException catch (e) {
      dev.log(
        'Subscription check failed (${e.code}), falling through to key check',
        name: _logName,
        error: e,
      );
      // On error, don't block — fall through to key check
    } catch (e) {
      dev.log(
        'Unexpected error checking subscription',
        name: _logName,
        error: e,
      );
    }

    // 3. Encryption key check
    try {
      final keyData = await _encryptionService.loadKey();
      _isConfigured = keyData != null;
    } on EncryptionException catch (e) {
      dev.log(
        'Encryption key check failed (${e.code})',
        name: _logName,
        error: e,
      );
      _isConfigured = false;
    }

    if (!_isConfigured) {
      _updateStatus(SyncStatus.notConfigured);
    } else {
      if (_status == SyncStatus.notConfigured ||
          _status == SyncStatus.noSubscription) {
        _updateStatus(SyncStatus.idle);
      }
      _subscribeToRealtime();
    }
  }

  /// Schedule a sync with debounce.
  /// Call this after any data change (habit created/edited/deleted, event marked).
  void scheduleSync() {
    if (!_isConfigured || _settingsManager.isSyncPaused) return;

    // Mark data as changed
    _settingsManager.setHasUnsyncedChanges(true);

    dev.log(
      'scheduleSync: debounce timer (re)started, push in 7s',
      name: _logName,
    );

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 7), () async {
      await _performPushSync();
    });
  }

  /// Perform immediate sync (for manual trigger or lifecycle events)
  Future<void> syncNow() async {
    _debounceTimer?.cancel();
    if (_isSyncing) return;

    // Always check for remote updates first
    await pullSync();

    // Only push if we have local changes
    if (_settingsManager.hasUnsyncedChanges) {
      await _performPushSync();
    }
  }

  /// Pull latest data from remote
  Future<void> pullSync({bool force = false}) async {
    if (!_isConfigured || _isSyncing || _settingsManager.isSyncPaused) return;

    // Set the guard immediately, before any await, to prevent concurrent syncs.
    _isSyncing = true;

    // Cancel any pending debounce push - we'll reschedule after pull with fresh data
    _debounceTimer?.cancel();
    _debounceTimer = null;

    // Check subscription before syncing
    final isSubscribed = await ServiceLocator.instance.subscriptionService
        .isSubscribed();
    if (!isSubscribed) {
      dev.log('Pull blocked: no active subscription', name: _logName);
      _updateStatus(SyncStatus.noSubscription);
      _isSyncing = false;
      return;
    }

    _updateStatus(SyncStatus.syncing);

    try {
      final currentVersion = force ? 0 : _settingsManager.syncVersion;

      // Safety net: create a backup before the first-ever pull sync.
      // If the user has local habits on a new device, this preserves them
      // in case the merge produces unexpected results.
      if (currentVersion == 0) {
        try {
          await _syncService.createPreSyncBackup();
        } catch (e) {
          // Backup failure must never block the sync itself
          dev.log(
            'Pre-sync backup failed (non-fatal)',
            name: _logName,
            error: e,
          );
        }
      }

      final newVersion = await _syncService.pullSync(currentVersion);

      _lastSyncTime = DateTime.now();
      _lastError = null;

      if (newVersion != null) {
        if (newVersion > currentVersion) {
          _settingsManager.setSyncVersion(newVersion);
          _dataChangedController.add(null);
          dev.log(
            'Pull completed: $currentVersion → $newVersion',
            name: _logName,
          );
        } else {
          dev.log(
            'Pull completed: force pull at version $newVersion',
            name: _logName,
          );
          _dataChangedController.add(null);
        }
      } else {
        dev.log(
          'Pull skipped: up to date at version $currentVersion',
          name: _logName,
        );

        // First-time setup: no remote data exists yet.
        // Mark local data as unsynced so the next syncNow/scheduleSync
        // pushes the existing habits to the cloud.
        if (currentVersion == 0) {
          await _settingsManager.setHasUnsyncedChanges(true);
          dev.log(
            'First sync setup: marked local data for initial push',
            name: _logName,
          );
        }
      }

      _updateStatus(SyncStatus.synced);

      // Check clock drift once per session, after a successful network round-trip.
      if (_clockDriftSeconds == null) {
        _clockDriftSeconds = await _syncService.getClockDriftSeconds();
        if (_clockDriftSeconds != null) {
          final absDrift = _clockDriftSeconds!.abs();
          if (absDrift > SyncService.clockDriftThresholdSeconds) {
            dev.log(
              'WARNING: Clock drift ${_clockDriftSeconds}s exceeds threshold '
              '${SyncService.clockDriftThresholdSeconds}s',
              name: _logName,
              level: 900,
            );
          }
        }
      }
    } on HaboSyncException catch (e) {
      dev.log(
        'Pull failed (${e.code}): ${e.message}',
        name: _logName,
        error: e.cause,
      );
      _lastError = e;

      // If the vault key doesn't match the remote data, the local key is
      // invalid (e.g. user created a new master password but old encrypted
      // data still exists on the server, or vice-versa).  Clear the stale
      // key so the UI falls back to the master-password screen.
      if (e.code == 'ENC_DECRYPTION_FAILED') {
        dev.log(
          'Clearing invalid local key — will re-prompt for master password',
          name: _logName,
        );
        await _encryptionService.clearKey();
        _isConfigured = false;
        _updateStatus(SyncStatus.notConfigured);
      } else {
        _updateStatus(SyncStatus.error);
      }
    } catch (e) {
      dev.log('Pull failed (unexpected)', name: _logName, error: e);
      _lastError = SyncException.pullFailed(e);
      _updateStatus(SyncStatus.error);
    } finally {
      _isSyncing = false;
    }

    // If local changes were pending while we pulled, schedule a fresh push.
    // Use fresh debounce timer so we push with POST-MERGE data, not stale pre-merge data.
    if (_settingsManager.hasUnsyncedChanges) {
      scheduleSync();
    }
  }

  Future<void> _performPushSync() async {
    if (!_isConfigured || _isSyncing || _settingsManager.isSyncPaused) return;

    // Set the guard immediately, before any await, to prevent concurrent syncs.
    _isSyncing = true;

    // Check subscription before syncing
    final isSubscribed = await ServiceLocator.instance.subscriptionService
        .isSubscribed();
    if (!isSubscribed) {
      dev.log('Push blocked: no active subscription', name: _logName);
      _updateStatus(SyncStatus.noSubscription);
      _isSyncing = false;
      return;
    }

    _updateStatus(SyncStatus.syncing);

    const maxRetries = 3;
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final expectedVersion = _settingsManager.syncVersion;
        dev.log(
          'Push attempt $attempt/$maxRetries '
          '(expectedVersion=$expectedVersion)',
          name: _logName,
        );
        final newVersion = await _syncService.pushSync(
          expectedVersion: expectedVersion,
        );
        await _settingsManager.setSyncVersion(newVersion);
        await _settingsManager.setHasUnsyncedChanges(false);

        _lastSyncTime = DateTime.now();
        _lastError = null;
        _updateStatus(SyncStatus.synced);
        dev.log(
          'Push SUCCEEDED: version $expectedVersion → $newVersion',
          name: _logName,
        );
        _isSyncing = false;
        return; // Success — exit
      } on SyncException catch (e) {
        if (e.code == 'SYNC_VERSION_CONFLICT') {
          // Another device pushed since our last pull.
          // Pull their changes (merge via LWW), then retry push.
          dev.log(
            'Push: version conflict on attempt $attempt/$maxRetries',
            name: _logName,
          );
          try {
            final localVersion = _settingsManager.syncVersion;
            final newVersion = await _syncService.pullSync(localVersion);
            if (newVersion != null) {
              await _settingsManager.setSyncVersion(newVersion);
              _dataChangedController.add(null);
            }
          } on HaboSyncException catch (pullError) {
            dev.log(
              'Pull during conflict resolution failed (${pullError.code})',
              name: _logName,
              error: pullError,
            );
          } catch (pullError) {
            dev.log(
              'Pull during conflict resolution failed',
              name: _logName,
              error: pullError,
            );
          }
          if (attempt < maxRetries) {
            await Future.delayed(Duration(seconds: attempt));
          } else {
            dev.log(
              'Push failed after $maxRetries conflict retries',
              name: _logName,
            );
            _lastError = SyncException.pushFailed(e);
            _updateStatus(SyncStatus.error);
          }
        } else {
          // Non-conflict SyncException
          dev.log(
            'Push attempt $attempt/$maxRetries failed (${e.code})',
            name: _logName,
            error: e,
          );
          if (attempt < maxRetries) {
            final delay = Duration(seconds: 2 * attempt);
            dev.log('Retrying push in ${delay.inSeconds}s', name: _logName);
            await Future.delayed(delay);
          } else {
            dev.log('Push failed after $maxRetries attempts', name: _logName);
            _lastError = e;
            _updateStatus(SyncStatus.error);
          }
        }
      } on HaboSyncException catch (e) {
        dev.log(
          'Push attempt $attempt/$maxRetries failed (${e.code})',
          name: _logName,
          error: e,
        );
        if (attempt < maxRetries) {
          final delay = Duration(seconds: 2 * attempt);
          dev.log('Retrying push in ${delay.inSeconds}s', name: _logName);
          await Future.delayed(delay);
        } else {
          dev.log('Push failed after $maxRetries attempts', name: _logName);
          _lastError = e;
          _updateStatus(SyncStatus.error);
        }
      } catch (e) {
        dev.log(
          'Push attempt $attempt/$maxRetries failed (unexpected)',
          name: _logName,
          error: e,
        );
        if (attempt < maxRetries) {
          final delay = Duration(seconds: 2 * attempt);
          await Future.delayed(delay);
        } else {
          _lastError = SyncException.pushFailed(e);
          _updateStatus(SyncStatus.error);
        }
      }
    }

    _isSyncing = false;
  }

  void _updateStatus(SyncStatus newStatus) {
    _status = newStatus;
    _statusController.add(newStatus);
  }

  /// Called when the user completes master password setup/unlock
  void onConfigurationComplete() {
    _isConfigured = true;
    _updateStatus(SyncStatus.idle);
    _subscribeToRealtime();
    pullSync(); // Pull immediately after unlocking
  }

  void _subscribeToRealtime() {
    if (_realtimeSubscription != null) return;

    final user = _supabaseClient.auth.currentUser;
    if (user == null) return;

    dev.log('Subscribing to realtime updates', name: _logName);

    _realtimeSubscription = _supabaseClient
        .channel('public:profiles:${user.id}')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'profiles',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: user.id,
          ),
          callback: (payload) {
            final newRecord = payload.newRecord;
            if (newRecord.containsKey('sync_version')) {
              final remoteVersion = newRecord['sync_version'] as int?;
              final localVersion = _settingsManager.syncVersion;

              if (remoteVersion != null && remoteVersion > localVersion) {
                dev.log(
                  'Realtime: remote=$remoteVersion > local=$localVersion, pulling',
                  name: _logName,
                );
                pullSync();
              }
            }
          },
        )
        .subscribe();
  }

  void _unsubscribeRealtime() {
    if (_realtimeSubscription != null) {
      dev.log('Unsubscribing from realtime', name: _logName);
      _supabaseClient.removeChannel(_realtimeSubscription!);
      _realtimeSubscription = null;
    }
  }

  /// Re-check configuration after login or master password setup
  Future<void> refreshConfiguration() async {
    dev.log('Refreshing configuration', name: _logName);
    await _checkConfiguration();
    if (_isConfigured) {
      dev.log('Configured, triggering initial pull', name: _logName);
      await pullSync();
    }
  }

  /// Called after a local backup has been restored.
  /// Pushes restored data to cloud to make local the source of truth.
  /// This prevents cloud data from overwriting the restored backup on next sync.
  Future<void> onLocalBackupRestored() async {
    if (!_isConfigured) {
      dev.log('Not configured, skipping post-restore sync', name: _logName);
      return;
    }

    dev.log('Local backup restored, pushing to cloud', name: _logName);

    await _settingsManager.setHasUnsyncedChanges(true);

    // Push to make local data the new source of truth.
    // _performPushSync reads the local sync version and uses the atomic RPC
    // to increment it; conflict resolution is handled automatically.
    await _performPushSync();

    dev.log('Post-restore push completed', name: _logName);
  }

  /// Called when user signs out.
  /// Resets all sync state and clears key material so a fresh login starts clean.
  Future<void> onSignOut() async {
    _isConfigured = false;
    _debounceTimer?.cancel();
    _unsubscribeRealtime();
    _updateStatus(SyncStatus.notConfigured);
    _lastError = null;

    // Clear encryption key material from secure storage
    await _encryptionService.clearKey();

    // Reset persistent sync state so next login starts fresh
    await _settingsManager.setSyncVersion(0);
    await _settingsManager.setHasUnsyncedChanges(false);
    await _settingsManager.setIsSyncPaused(false);
  }

  // --- WidgetsBindingObserver ---

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // App going to background - push any pending changes immediately
        if (_debounceTimer?.isActive ?? false) {
          syncNow();
        }
        break;
      case AppLifecycleState.resumed:
        // App returning to foreground - pull latest data
        _checkConfiguration().then((_) {
          if (_isConfigured) {
            pullSync();
          }
        });
        break;
      default:
        break;
    }
  }
}
