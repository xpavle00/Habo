import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:habo/env_config.dart';
import 'package:habo/services/sync_error.dart';
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
  static const _logName = 'SubscriptionService';

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
  ///
  /// Throws [SubscriptionException] with code `SUB_INIT_FAILED` if
  /// initialization fails on a supported platform.
  Future<void> initialize() async {
    // If an initialization is already in progress, await it.
    if (_initCompleter != null) {
      return _initCompleter!.future;
    }

    if (_isSelfHosted) {
      dev.log('Self-hosted mode — skipping RevenueCat', name: _logName);
      return;
    }

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      dev.log('Cannot initialize — no user logged in', name: _logName);
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
        dev.log('Platform not supported for subscriptions', name: _logName);
        _initCompleter!.complete();
        _initCompleter = null;
        return;
      }

      if (apiKey.isEmpty) {
        dev.log('API key not set — skipping initialization', name: _logName);
        _initCompleter!.complete();
        _initCompleter = null;
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
      dev.log('Initialized for user ${user.id}', name: _logName);
      _initCompleter!.complete();
    } catch (e) {
      dev.log('Initialization failed', name: _logName, error: e);
      final exception = SubscriptionException.initFailed(e);
      _initCompleter!.completeError(exception);
      _initCompleter = null;
      throw exception;
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
      dev.log('Logged out from RevenueCat', name: _logName);
    } catch (e) {
      dev.log('Error logging out', name: _logName, error: e);
    }
  }

  /// Check if user has an active subscription.
  ///
  /// Tries RevenueCat first (source of truth), falls back to Supabase
  /// (updated via webhooks). Returns `false` if both checks fail.
  Future<bool> isSubscribed() async {
    if (_isSelfHosted) return true;

    // First try RevenueCat (source of truth)
    if (_isInitialized) {
      try {
        final customerInfo = await Purchases.getCustomerInfo();
        final isActive = customerInfo.entitlements.active.containsKey(
          _entitlementId,
        );
        return isActive;
      } catch (e) {
        dev.log(
          'RevenueCat check failed, falling back to Supabase',
          name: _logName,
          error: e,
        );
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
      dev.log('Supabase subscription check failed', name: _logName, error: e);
      return false;
    }
  }

  /// Show the paywall to the user.
  /// Returns true if purchase was successful.
  ///
  /// Throws [SubscriptionException] with code `SUB_PAYWALL_FAILED` if
  /// the paywall cannot be displayed.
  Future<bool> showPaywall() async {
    if (_isSelfHosted) return true;

    if (!_isInitialized) {
      dev.log('Cannot show paywall — not initialized', name: _logName);
      return false;
    }

    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(_entitlementId);

      switch (result) {
        case PaywallResult.purchased:
        case PaywallResult.restored:
          dev.log('Paywall result: success', name: _logName);
          return true;
        case PaywallResult.notPresented:
          // User already has entitlement
          dev.log('Paywall not presented — already subscribed', name: _logName);
          return true;
        case PaywallResult.cancelled:
          dev.log('Paywall cancelled by user', name: _logName);
          return false;
        case PaywallResult.error:
          dev.log('Paywall returned error', name: _logName);
          return false;
      }
    } catch (e) {
      dev.log('Paywall display failed', name: _logName, error: e);
      throw SubscriptionException.paywallFailed(e);
    }
  }

  /// Restore previous purchases.
  ///
  /// Returns `true` if purchases were restored and the user has an active
  /// entitlement, `false` otherwise.
  ///
  /// Throws [SubscriptionException] with code `SUB_RESTORE_FAILED` if
  /// the restore operation fails.
  Future<bool> restorePurchases() async {
    if (_isSelfHosted || !_isInitialized) return _isSelfHosted;

    try {
      final customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.active.containsKey(_entitlementId);
    } catch (e) {
      dev.log('Restore purchases failed', name: _logName, error: e);
      throw SubscriptionException.restoreFailed(e);
    }
  }

  /// Get subscription info for display.
  ///
  /// Returns `null` if the service is not initialized or self-hosted.
  /// Throws [SubscriptionException] with code `SUB_CHECK_FAILED` if
  /// the info retrieval fails.
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
      dev.log('Failed to get subscription info', name: _logName, error: e);
      throw SubscriptionException.checkFailed(e);
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
