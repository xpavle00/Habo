import 'package:flutter/material.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/sync_service.dart';
import 'package:habo/services/sync_manager.dart';
import 'package:habo/services/ui_feedback_service.dart';
import 'package:habo/services/encryption_service.dart';
import 'package:habo/services/subscription_service.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/repositories/repository_factory.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service locator for dependency injection
///
/// Provides centralized access to service and repository instances throughout the app.
/// Services and repositories are initialized once and reused across the application.
class ServiceLocator {
  static ServiceLocator? _instance;
  static ServiceLocator get instance => _instance ??= ServiceLocator._();

  ServiceLocator._();

  // Service instances
  late BackupService _backupService;
  late final NotificationService _notificationService;
  late final UIFeedbackService _uiFeedbackService;
  late final EncryptionService _encryptionService;
  late final SyncService _syncService;
  SyncManager? _syncManager; // Optional - only initialized if user configured
  late final SubscriptionService _subscriptionService;
  late final RepositoryFactory _repositoryFactory;
  late final HaboModel _haboModel;
  late final SettingsManager _settingsManager;

  bool _isInitialized = false; // Added initialization flag

  /// Initializes all services. Must be called before accessing any service.
  void initialize({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required HaboModel haboModel,
    required SettingsManager settingsManager,
    SupabaseClient? client,
    bool isSelfHosted = false,
  }) {
    if (_isInitialized) return;

    _haboModel = haboModel;
    _settingsManager = settingsManager;

    final supabaseClient = client ?? Supabase.instance.client;

    _repositoryFactory = RepositoryFactory(haboModel);
    _uiFeedbackService = UIFeedbackService(scaffoldKey);
    _notificationService = NotificationService();
    _encryptionService = EncryptionService();
    _subscriptionService = SubscriptionService(isSelfHosted: isSelfHosted);
    _syncService = SyncService(
      _repositoryFactory.backupRepository,
      _encryptionService,
    );

    // Initialize SyncManager first so we can pass it to BackupService
    _syncManager = SyncManager(
      _syncService,
      _encryptionService,
      _settingsManager,
      client: supabaseClient,
    );
    _syncManager!.initialize();

    // Initialize BackupService with SyncManager for post-restore sync
    _backupService = BackupService(
      _uiFeedbackService,
      _repositoryFactory.backupRepository,
      _syncManager,
    );

    _isInitialized = true;
  }

  /// Recreates SyncManager after a server switch.
  /// SyncManager holds a reference to SupabaseClient which becomes stale
  /// after Supabase.instance.dispose() + re-initialize.
  /// SyncService is safe because it reads Supabase.instance.client on each call.
  void reinitializeForServerSwitch() {
    _ensureInitialized();

    final supabaseClient = Supabase.instance.client;

    // Dispose old sync manager
    _syncManager?.dispose();

    // Create new SyncManager with fresh client
    _syncManager = SyncManager(
      _syncService,
      _encryptionService,
      _settingsManager,
      client: supabaseClient,
    );
    _syncManager!.initialize();

    // Update BackupService reference
    _backupService = BackupService(
      _uiFeedbackService,
      _repositoryFactory.backupRepository,
      _syncManager,
    );
  }

  /// Ensures ServiceLocator is initialized, throws StateError if not
  void _ensureInitialized() {
    if (!isInitialized) {
      throw StateError(
        'ServiceLocator not initialized. Call ServiceLocator.instance.initialize() first.',
      );
    }
  }

  /// Get BackupService instance
  BackupService get backupService {
    _ensureInitialized();
    return _backupService;
  }

  /// Get NotificationService instance
  NotificationService get notificationService {
    _ensureInitialized();
    return _notificationService;
  }

  /// Get EncryptionService instance
  EncryptionService get encryptionService {
    _ensureInitialized();
    return _encryptionService;
  }

  /// Get SyncService instance
  SyncService get syncService {
    _ensureInitialized();
    return _syncService;
  }

  /// Get SyncManager instance (may be null if not configured)
  SyncManager? get syncManager {
    _ensureInitialized();
    return _syncManager;
  }

  /// Get UIFeedbackService instance
  UIFeedbackService get uiFeedbackService {
    _ensureInitialized();
    return _uiFeedbackService;
  }

  /// Get RepositoryFactory instance
  RepositoryFactory get repositoryFactory {
    _ensureInitialized();
    return _repositoryFactory;
  }

  /// Get HaboModel instance
  HaboModel get haboModel {
    _ensureInitialized();
    return _haboModel;
  }

  /// Get SubscriptionService instance
  SubscriptionService get subscriptionService {
    _ensureInitialized();
    return _subscriptionService;
  }

  /// Get SettingsManager instance
  SettingsManager get settingsManager {
    _ensureInitialized();
    return _settingsManager;
  }

  /// Check if services are initialized
  bool get isInitialized => _isInitialized;

  /// Reset all services (useful for testing)
  @visibleForTesting
  void reset() {
    _instance = null;
    _isInitialized = false;
  }

  @visibleForTesting
  void setSyncManagerForTesting(SyncManager syncManager) {
    _syncManager = syncManager;
    // We treat setting a mock as 'initialized' for the scope of tests checking this
    _isInitialized = true;
  }

  @visibleForTesting
  void setSubscriptionServiceForTesting(
    SubscriptionService subscriptionService,
  ) {
    _subscriptionService = subscriptionService;
    _isInitialized = true;
  }
}
