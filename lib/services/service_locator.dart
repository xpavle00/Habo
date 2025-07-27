import 'package:flutter/material.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/ui_feedback_service.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/repositories/repository_factory.dart';

/// Service locator for dependency injection
/// 
/// Provides centralized access to service and repository instances throughout the app.
/// Services and repositories are initialized once and reused across the application.
class ServiceLocator {
  static ServiceLocator? _instance;
  static ServiceLocator get instance => _instance ??= ServiceLocator._();
  
  ServiceLocator._();
  
  // Service instances
  BackupService? _backupService;
  NotificationService? _notificationService;
  UIFeedbackService? _uiFeedbackService;
  RepositoryFactory? _repositoryFactory;
  HaboModel? _haboModel;
  
  /// Initialize services and repositories with required dependencies
  void initialize(GlobalKey<ScaffoldMessengerState> scaffoldKey, HaboModel haboModel) {
    _haboModel = haboModel;
    _repositoryFactory = RepositoryFactory(haboModel);
    _uiFeedbackService = UIFeedbackService(scaffoldKey);
    _backupService = BackupService(_uiFeedbackService!, _repositoryFactory!.backupRepository);
    _notificationService = NotificationService();
  }
  
  /// Ensures ServiceLocator is initialized, throws StateError if not
  void _ensureInitialized() {
    if (!isInitialized) {
      throw StateError('ServiceLocator not initialized. Call ServiceLocator.instance.initialize() first.');
    }
  }

  /// Get BackupService instance
  BackupService get backupService {
    _ensureInitialized();
    return _backupService!;
  }
  
  /// Get NotificationService instance
  NotificationService get notificationService {
    _ensureInitialized();
    return _notificationService!;
  }
  
  /// Get UIFeedbackService instance
  UIFeedbackService get uiFeedbackService {
    _ensureInitialized();
    return _uiFeedbackService!;
  }
  
  /// Get RepositoryFactory instance
  RepositoryFactory get repositoryFactory {
    _ensureInitialized();
    return _repositoryFactory!;
  }

  /// Get HaboModel instance
  HaboModel get haboModel {
    _ensureInitialized();
    return _haboModel!;
  }

  /// Check if services are initialized
  bool get isInitialized => 
      _backupService != null && 
      _notificationService != null && 
      _uiFeedbackService != null &&
      _repositoryFactory != null;
  
  /// Reset all services (useful for testing)
  void reset() {
    _backupService = null;
    _notificationService = null;
    _uiFeedbackService = null;
    _repositoryFactory = null;
    _haboModel = null;
  }
}
