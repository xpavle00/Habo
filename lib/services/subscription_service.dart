import 'dart:developer' as dev;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Checks whether cloud sync is available for the current account.
class SubscriptionService {
  static const bool supportsPurchases = false;
  static const _logName = 'SubscriptionService';

  bool _isSelfHosted;

  SubscriptionService({bool isSelfHosted = false})
    : _isSelfHosted = isSelfHosted;

  bool get isSelfHosted => _isSelfHosted;

  void updateSelfHostedMode(bool value) {
    _isSelfHosted = value;
  }

  /// Returns true for self-hosted instances or active hosted subscriptions.
  Future<bool> isSubscribed() async {
    if (_isSelfHosted) return true;

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
}
