import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:habo/env_config.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service for managing subscriptions via RevenueCat.
///
/// Handles:
/// - RevenueCat SDK initialization
/// - Subscription status checks
/// - Showing paywalls
/// - Syncing status with Supabase (via webhooks)
class SubscriptionService {
  static const String _entitlementId = 'Habo Sync';

  bool _isSelfHosted;
  bool _isInitialized = false;
  String? _currentUserId;
  Completer<void>? _initCompleter;

  SubscriptionService({bool isSelfHosted = false})
      : _isSelfHosted = isSelfHosted;

  bool get isSelfHosted => _isSelfHosted;

  void updateSelfHostedMode(bool value) {
    _isSelfHosted = value;
  }

  /// Initialize RevenueCat SDK.
  /// Should be called early in app lifecycle, after user logs in.
  Future<void> initialize() async {
    // If an initialization is already in progress, await it.
    if (_initCompleter != null) {
      return _initCompleter!.future;
    }

    if (_isSelfHosted) {
      debugPrint(
        'SubscriptionService: Self-hosted mode - skipping RevenueCat',
      );
      return;
    }

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      debugPrint('SubscriptionService: Cannot initialize - no user logged in');
      return;
    }

    // If already initialized with the same user, skip
    if (_isInitialized && _currentUserId == user.id) {
      return;
    }

    _initCompleter = Completer<void>();
    try {
      String apiKey;
      if (Platform.isIOS || Platform.isMacOS) {
        apiKey = EnvConfig.revenueCatApiKeyIos;
      } else if (Platform.isAndroid) {
        apiKey = EnvConfig.revenueCatApiKeyAndroid;
      } else {
        debugPrint('SubscriptionService: Platform not supported');
        return;
      }

      if (apiKey.isEmpty) {
        debugPrint(
          'SubscriptionService: API key not set - skipping initialization',
        );
        return;
      }

      if (!_isInitialized) {
        // First time initialization
        await Purchases.configure(
          PurchasesConfiguration(apiKey)..appUserID = user.id,
        );
        _isInitialized = true;
      } else {
        // Already initialized but different user - login as new user
        await Purchases.logIn(user.id);
      }

      _currentUserId = user.id;
      debugPrint('SubscriptionService: Initialized for user ${user.id}');
      _initCompleter!.complete();
    } catch (e) {
      debugPrint('SubscriptionService: Failed to initialize - $e');
      _initCompleter!.completeError(e);
    } finally {
      _initCompleter = null;
    }
  }

  /// Logout from RevenueCat. Call this when user signs out.
  Future<void> logout() async {
    if (_isSelfHosted || !_isInitialized) return;

    try {
      await Purchases.logOut();
      _currentUserId = null;
      debugPrint('SubscriptionService: Logged out from RevenueCat');
    } catch (e) {
      debugPrint('SubscriptionService: Error logging out - $e');
    }
  }

  /// Check if user has an active subscription.
  Future<bool> isSubscribed() async {
    if (_isSelfHosted) return true;

    // First try RevenueCat (source of truth)
    if (_isInitialized) {
      try {
        final customerInfo = await Purchases.getCustomerInfo();
        final isActive = customerInfo.entitlements.active.containsKey(
          _entitlementId,
        );
        debugPrint(
          'SubscriptionService: RevenueCat check - subscribed: $isActive',
        );
        return isActive;
      } catch (e) {
        debugPrint('SubscriptionService: Error checking RevenueCat - $e');
      }
    }

    // Fallback to Supabase (updated via webhooks)
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return false;

      final response = await Supabase.instance.client
          .from('profiles')
          .select('subscription_status, subscription_expires_at')
          .eq('id', user.id)
          .single();

      final status = response['subscription_status'] as String?;
      final expiresAt = response['subscription_expires_at'] as String?;

      if (status == 'active') {
        // Check if not expired
        if (expiresAt != null) {
          final expiry = DateTime.parse(expiresAt);
          if (expiry.isAfter(DateTime.now().toUtc())) {
            return true;
          }
        } else {
          return true; // No expiry set, assume active
        }
      }

      return false;
    } catch (e) {
      debugPrint('SubscriptionService: Error checking Supabase - $e');
      return false;
    }
  }

  /// Show the paywall to the user.
  /// Returns true if purchase was successful.
  Future<bool> showPaywall() async {
    if (_isSelfHosted) return true;

    if (!_isInitialized) {
      debugPrint('SubscriptionService: Cannot show paywall - not initialized');
      return false;
    }

    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(_entitlementId);

      switch (result) {
        case PaywallResult.purchased:
        case PaywallResult.restored:
          debugPrint('SubscriptionService: Paywall result - success');
          return true;
        case PaywallResult.notPresented:
          // User already has entitlement
          debugPrint(
            'SubscriptionService: Paywall not presented - already subscribed',
          );
          return true;
        case PaywallResult.cancelled:
        case PaywallResult.error:
          debugPrint('SubscriptionService: Paywall result - $result');
          return false;
      }
    } catch (e) {
      debugPrint('SubscriptionService: Error showing paywall - $e');
      return false;
    }
  }

  /// Restore previous purchases.
  Future<bool> restorePurchases() async {
    if (_isSelfHosted || !_isInitialized) return _isSelfHosted;

    try {
      final customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.active.containsKey(_entitlementId);
    } catch (e) {
      debugPrint('SubscriptionService: Error restoring purchases - $e');
      return false;
    }
  }

  /// Get subscription info for display.
  Future<SubscriptionInfo?> getSubscriptionInfo() async {
    if (_isSelfHosted) return null;
    if (!_isInitialized) return null;

    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final entitlement = customerInfo.entitlements.active[_entitlementId];

      if (entitlement != null) {
        return SubscriptionInfo(
          isActive: true,
          productIdentifier: entitlement.productIdentifier,
          expirationDate: entitlement.expirationDate != null
              ? DateTime.parse(entitlement.expirationDate!)
              : null,
          willRenew: entitlement.willRenew,
          managementUrl: customerInfo.managementURL,
        );
      }

      return SubscriptionInfo(isActive: false);
    } catch (e) {
      debugPrint('SubscriptionService: Error getting subscription info - $e');
      return null;
    }
  }
}

/// Subscription information for display.
class SubscriptionInfo {
  final bool isActive;
  final String? productIdentifier;
  final DateTime? expirationDate;
  final bool willRenew;
  final String? managementUrl;

  SubscriptionInfo({
    required this.isActive,
    this.productIdentifier,
    this.expirationDate,
    this.willRenew = false,
    this.managementUrl,
  });
}
