library purchases_flutter;

class PurchasesConfiguration {
  final String apiKey;
  String? appUserID;

  PurchasesConfiguration(this.apiKey);
}

class EntitlementInfo {
  final String productIdentifier;
  final String? expirationDate;
  final bool willRenew;

  EntitlementInfo({
    this.productIdentifier = '',
    this.expirationDate,
    this.willRenew = false,
  });
}

class EntitlementInfos {
  final Map<String, EntitlementInfo> active;

  EntitlementInfos({Map<String, EntitlementInfo>? active})
      : active = active ?? <String, EntitlementInfo>{};
}

class CustomerInfo {
  final EntitlementInfos entitlements;
  final String? managementURL;

  CustomerInfo({EntitlementInfos? entitlements, this.managementURL})
      : entitlements = entitlements ?? EntitlementInfos();
}

class Purchases {
  static Future<void> configure(PurchasesConfiguration configuration) async {}

  static Future<void> logIn(String appUserId) async {}

  static Future<void> logOut() async {}

  static Future<CustomerInfo> getCustomerInfo() async {
    return CustomerInfo();
  }

  static Future<CustomerInfo> restorePurchases() async {
    return CustomerInfo();
  }
}
