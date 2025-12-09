import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/settings/settings_manager.dart';

void main() {
  // Initialize Flutter binding for tests
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up mock shared preferences for testing
  setUp(() {
    TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/shared_preferences'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getAll') {
          return <String, dynamic>{}; // Return empty preferences
        }
        return null;
      },
    );
  });

  group('App Integration Tests', () {
    test('service locator initializes correctly', () async {
      // Reset service locator to ensure clean state
      ServiceLocator.instance.reset();

      // Create test dependencies
      final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
      final haboModel = HaboModel();
      final settingsManager = SettingsManager();

      // Initialize service locator
      ServiceLocator.instance
          .initialize(scaffoldKey, haboModel, settingsManager);

      // Verify services are accessible
      expect(ServiceLocator.instance.backupService, isNotNull);
      expect(ServiceLocator.instance.notificationService, isNotNull);
      expect(ServiceLocator.instance.uiFeedbackService, isNotNull);
      expect(ServiceLocator.instance.repositoryFactory, isNotNull);
    });

    test('habo model can be instantiated', () async {
      // Verify HaboModel can be created without exceptions
      expect(() => HaboModel(), returnsNormally);
    });

    test('service locator provides repository factory', () async {
      // Reset service locator to ensure clean state
      ServiceLocator.instance.reset();

      final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
      final haboModel = HaboModel();
      final settingsManager = SettingsManager();

      ServiceLocator.instance
          .initialize(scaffoldKey, haboModel, settingsManager);

      // Verify repository factory provides repositories
      expect(
          ServiceLocator.instance.repositoryFactory.habitRepository, isNotNull);
      expect(
          ServiceLocator.instance.repositoryFactory.eventRepository, isNotNull);
    });

    test('service locator can be reinitialized', () async {
      // Reset service locator to ensure clean state
      ServiceLocator.instance.reset();

      // Verify service locator can handle reinitialization
      final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
      final haboModel = HaboModel();
      final settingsManager = SettingsManager();

      expect(
          () => ServiceLocator.instance
              .initialize(scaffoldKey, haboModel, settingsManager),
          returnsNormally);
    });
  });
}
