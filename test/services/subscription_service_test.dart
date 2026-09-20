import 'package:flutter_test/flutter_test.dart';
import 'package:habo/services/subscription_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SubscriptionService', () {
    late SubscriptionService service;

    setUp(() {
      service = SubscriptionService(isSelfHosted: true);
    });

    test('isSubscribed returns true immediately when self-hosted', () async {
      final result = await service.isSubscribed();
      expect(result, isTrue);
    });

    test('does not support purchases', () {
      expect(SubscriptionService.supportsPurchases, isFalse);
    });

    test('updateSelfHostedMode changes behavior', () async {
      final cloudService = SubscriptionService(isSelfHosted: false);
      expect(cloudService.isSelfHosted, isFalse);

      cloudService.updateSelfHostedMode(true);
      expect(cloudService.isSelfHosted, isTrue);

      final result = await cloudService.isSubscribed();
      expect(result, isTrue);
    });
  });
}
