library purchases_ui_flutter;

enum PaywallResult { purchased, restored, notPresented, cancelled, error }

class RevenueCatUI {
  static Future<PaywallResult> presentPaywallIfNeeded(
    String entitlementIdentifier,
  ) async {
    return PaywallResult.notPresented;
  }
}
