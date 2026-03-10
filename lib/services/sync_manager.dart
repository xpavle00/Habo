import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:habo/services/sync_service.dart';
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
  final SyncService _syncService;
  final EncryptionService _encryptionService;
  final SettingsManager _settingsManager;
  final SupabaseClient _supabaseClient;

  Timer? _debounceTimer;
  bool _isSyncing = false;
  SyncStatus _status = SyncStatus.idle;
  DateTime? _lastSyncTime;
  RealtimeChannel? _realtimeSubscription;

  /// Detected clock drift in seconds (positive = local ahead).
  /// `null` means not yet measured.
  int? _clockDriftSeconds;

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
    _unsubscribeRealtime();
    _debounceTimer?.cancel();
    _statusController.close();
    _dataChangedController.close();
  }

  /// Check if user is configured for sync
  Future<void> _checkConfiguration() async {
    final keyData = await _encryptionService.loadKey();
    _isConfigured = keyData != null;
    if (!_isConfigured) {
      _updateStatus(SyncStatus.notConfigured);
    } else {
      if (_status == SyncStatus.notConfigured) {
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
      debugPrint('Pull sync blocked: no active subscription');
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
          debugPrint('Pre-sync backup failed (non-fatal): $e');
        }
      }

      final newVersion = await _syncService.pullSync(currentVersion);

      _lastSyncTime = DateTime.now();

      if (newVersion != null) {
        if (newVersion > currentVersion) {
          _settingsManager.setSyncVersion(newVersion);
          _dataChangedController.add(null);
          debugPrint(
            'Pull sync completed: updated from $currentVersion to $newVersion',
          );
        } else {
          debugPrint('Pull sync completed: force pull at version $newVersion');
          _dataChangedController.add(null);
        }
      } else {
        debugPrint('Pull sync skipped: up to date at version $currentVersion');

        // First-time setup: no remote data exists yet.
        // Mark local data as unsynced so the next syncNow/scheduleSync
        // pushes the existing habits to the cloud.
        if (currentVersion == 0) {
          await _settingsManager.setHasUnsyncedChanges(true);
          debugPrint('First sync setup: marked local data for initial push');
        }
      }

      _updateStatus(SyncStatus.synced);

      // Check clock drift once per session, after a successful network round-trip.
      if (_clockDriftSeconds == null) {
        _clockDriftSeconds = await _syncService.getClockDriftSeconds();
        if (_clockDriftSeconds != null) {
          final absDrift = _clockDriftSeconds!.abs();
          if (absDrift > SyncService.clockDriftThresholdSeconds) {
            debugPrint(
              'WARNING: Device clock is off by ${_clockDriftSeconds}s '
              '(threshold: ${SyncService.clockDriftThresholdSeconds}s). '
              'LWW conflict resolution may produce incorrect results.',
            );
          } else {
            debugPrint('Clock drift check OK: ${_clockDriftSeconds}s');
          }
        }
      }
    } catch (e) {
      debugPrint('Pull sync failed: $e');
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
      debugPrint('Push sync blocked: no active subscription');
      _updateStatus(SyncStatus.noSubscription);
      _isSyncing = false;
      return;
    }

    _updateStatus(SyncStatus.syncing);

    const maxRetries = 3;
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final expectedVersion = _settingsManager.syncVersion;
        final newVersion = await _syncService.pushSync(
          expectedVersion: expectedVersion,
        );
        await _settingsManager.setSyncVersion(newVersion);
        await _settingsManager.setHasUnsyncedChanges(false);

        _lastSyncTime = DateTime.now();
        _updateStatus(SyncStatus.synced);
        debugPrint('Push sync completed: updated to version $newVersion');
        _isSyncing = false;
        return; // Success — exit
      } on SyncVersionConflictException {
        // Another device pushed since our last pull.
        // Pull their changes (merge via LWW), then retry push.
        debugPrint(
          'Push sync: version conflict on attempt $attempt/$maxRetries, '
          'pulling remote changes...',
        );
        try {
          final localVersion = _settingsManager.syncVersion;
          final newVersion = await _syncService.pullSync(localVersion);
          if (newVersion != null) {
            await _settingsManager.setSyncVersion(newVersion);
            _dataChangedController.add(null);
          }
        } catch (pullError) {
          debugPrint('Pull during conflict resolution failed: $pullError');
        }
        if (attempt < maxRetries) {
          await Future.delayed(Duration(seconds: attempt));
        } else {
          debugPrint('Push sync failed after $maxRetries conflict retries');
          _updateStatus(SyncStatus.error);
        }
      } catch (e) {
        debugPrint('Push sync attempt $attempt/$maxRetries failed: $e');
        if (attempt < maxRetries) {
          // Exponential backoff: 2s, 4s
          final delay = Duration(seconds: 2 * attempt);
          debugPrint('Retrying push sync in ${delay.inSeconds}s...');
          await Future.delayed(delay);
        } else {
          debugPrint('Push sync failed after $maxRetries attempts');
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

    debugPrint('Realtime: Subscribing to profiles changes for user ${user.id}');

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

              debugPrint(
                'Realtime: Update detected. Remote=$remoteVersion, Local=$localVersion',
              );

              if (remoteVersion != null && remoteVersion > localVersion) {
                pullSync();
              }
            }
          },
        )
        .subscribe();
  }

  void _unsubscribeRealtime() {
    if (_realtimeSubscription != null) {
      debugPrint('Realtime: Unsubscribing');
      _supabaseClient.removeChannel(_realtimeSubscription!);
      _realtimeSubscription = null;
    }
  }

  /// Re-check configuration after login or master password setup
  Future<void> refreshConfiguration() async {
    debugPrint('SyncManager: Refreshing configuration...');
    await _checkConfiguration();
    if (_isConfigured) {
      debugPrint('SyncManager: Configured, triggering initial pull');
      await pullSync();
    }
  }

  /// Called after a local backup has been restored.
  /// Pushes restored data to cloud to make local the source of truth.
  /// This prevents cloud data from overwriting the restored backup on next sync.
  Future<void> onLocalBackupRestored() async {
    if (!_isConfigured) {
      debugPrint('SyncManager: Not configured, skipping post-restore sync');
      return;
    }

    debugPrint('SyncManager: Local backup restored, pushing to cloud...');

    await _settingsManager.setHasUnsyncedChanges(true);

    // Push to make local data the new source of truth.
    // _performPushSync reads the local sync version and uses the atomic RPC
    // to increment it; conflict resolution is handled automatically.
    await _performPushSync();

    debugPrint('SyncManager: Post-restore push completed');
  }

  /// Called when user signs out.
  /// Resets all sync state and clears key material so a fresh login starts clean.
  Future<void> onSignOut() async {
    _isConfigured = false;
    _debounceTimer?.cancel();
    _unsubscribeRealtime();
    _updateStatus(SyncStatus.notConfigured);

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
