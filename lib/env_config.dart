import 'dart:convert';

/// Environment configuration loaded from `.env` file at runtime.
///
/// Uses `flutter_dotenv` — no special build flags needed.
/// Just place your `.env` file in the project root and run normally.
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String _readEnv(String key) {
    final plainValue = dotenv.env[key];
    if (plainValue != null && plainValue.isNotEmpty) {
      return plainValue;
    }

    final encodedValue = dotenv.env['${key}_B64'];
    if (encodedValue == null || encodedValue.isEmpty) {
      return '';
    }

    try {
      return utf8.decode(base64Decode(encodedValue));
    } on FormatException {
      return '';
    }
  }

  // Supabase (production)
  static String get supabaseUrl => _readEnv('SUPABASE_URL');
  static String get supabaseAnonKey => _readEnv('SUPABASE_ANON_KEY');

  // Google Sign In
  static String get googleWebClientId => _readEnv('GOOGLE_WEB_CLIENT_ID');
  static String get googleIosClientId => _readEnv('GOOGLE_IOS_CLIENT_ID');

  // RevenueCat
  static String get revenueCatApiKeyIos => _readEnv('REVENUECAT_API_KEY_IOS');
  static String get revenueCatApiKeyAndroid =>
      _readEnv('REVENUECAT_API_KEY_ANDROID');

  // Build-time switch. Use --dart-define=ENABLE_REVENUECAT=false for Izzy.
  static const bool enableRevenueCat = bool.fromEnvironment(
    'ENABLE_REVENUECAT',
    defaultValue: true,
  );
}
