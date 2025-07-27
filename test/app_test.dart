import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/model/habo_model.dart';

void main() {
  // Initialize Flutter binding for tests
  TestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    test('service locator initializes correctly', () async {
      // Create test dependencies
      final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
      final haboModel = HaboModel();
      
      // Initialize service locator
      ServiceLocator.instance.initialize(scaffoldKey, haboModel);
      
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
      final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
      final haboModel = HaboModel();
      
      ServiceLocator.instance.initialize(scaffoldKey, haboModel);
      
      // Verify repository factory provides repositories
      expect(ServiceLocator.instance.repositoryFactory.habitRepository, isNotNull);
      expect(ServiceLocator.instance.repositoryFactory.eventRepository, isNotNull);
    });

    test('service locator can be reinitialized', () async {
      // Verify service locator can handle reinitialization
      final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
      final haboModel = HaboModel();
      
      expect(() => ServiceLocator.instance.initialize(scaffoldKey, haboModel), returnsNormally);
    });
  });
}
