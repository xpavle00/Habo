import 'package:flutter/material.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/ui_feedback_service.dart';

/// Simple service locator for dependency injection
/// 
/// Provides centralized access to service instances throughout the app.
/// Services are initialized once and reused across the application.
class ServiceLocator {
  static ServiceLocator? _instance;
  static ServiceLocator get instance => _instance ??= ServiceLocator._();
  
  ServiceLocator._();
  
  // Service instances
  BackupService? _backupService;
  NotificationService? _notificationService;
  UIFeedbackService? _uiFeedbackService;
  
  /// Initialize services with required dependencies
  void initialize(GlobalKey<ScaffoldMessengerState> scaffoldKey) {
    _uiFeedbackService = UIFeedbackService(scaffoldKey);
    _backupService = BackupService(_uiFeedbackService!);
    _notificationService = NotificationService();
  }
  
  /// Get BackupService instance
  BackupService get backupService {
    if (_backupService == null) {
      throw StateError('ServiceLocator not initialized. Call initialize() first.');
    }
    return _backupService!;
  }
  
  /// Get NotificationService instance
  NotificationService get notificationService {
    if (_notificationService == null) {
      throw StateError('ServiceLocator not initialized. Call initialize() first.');
    }
    return _notificationService!;
  }
  
  /// Get UIFeedbackService instance
  UIFeedbackService get uiFeedbackService {
    if (_uiFeedbackService == null) {
      throw StateError('ServiceLocator not initialized. Call initialize() first.');
    }
    return _uiFeedbackService!;
  }
  
  /// Check if services are initialized
  bool get isInitialized => 
      _backupService != null && 
      _notificationService != null && 
      _uiFeedbackService != null;
  
  /// Reset all services (useful for testing)
  void reset() {
    _backupService = null;
    _notificationService = null;
    _uiFeedbackService = null;
  }
}
