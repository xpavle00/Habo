import 'package:flutter_test/flutter_test.dart';
import 'package:habo/services/subscription_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SubscriptionService - self-hosted mode', () {
    late SubscriptionService service;

    setUp(() {
      service = SubscriptionService(isSelfHosted: true);
    });

    test('isSubscribed returns true immediately when self-hosted', () async {
      final result = await service.isSubscribed();
      expect(result, isTrue);
    });

    test(
      'showPaywall returns true without showing UI when self-hosted',
      () async {
        final result = await service.showPaywall();
        expect(result, isTrue);
      },
    );

    test('restorePurchases returns true when self-hosted', () async {
      final result = await service.restorePurchases();
      expect(result, isTrue);
    });

    test('getSubscriptionInfo returns null when self-hosted', () async {
      final result = await service.getSubscriptionInfo();
      expect(result, isNull);
    });

    test('initialize is a no-op when self-hosted', () async {
      // Should not throw, should not try to call RevenueCat
      await service.initialize();
      // If we get here without error, the test passes
    });

    test('logout is a no-op when self-hosted', () async {
      await service.logout();
      // If we get here without error, the test passes
    });

    test('updateSelfHostedMode changes behavior', () async {
      final cloudService = SubscriptionService(isSelfHosted: false);
      // In cloud mode without RevenueCat initialized, isSubscribed falls
      // back to Supabase query which will fail in test -> returns false
      // We just verify the flag can be toggled
      expect(cloudService.isSelfHosted, isFalse);

      cloudService.updateSelfHostedMode(true);
      expect(cloudService.isSelfHosted, isTrue);

      final result = await cloudService.isSubscribed();
      expect(result, isTrue);
    });
  });
}
