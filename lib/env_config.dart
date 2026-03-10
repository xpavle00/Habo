/// Environment configuration loaded from `.env` file at runtime.
///
/// Uses `flutter_dotenv` — no special build flags needed.
/// Just place your `.env` file in the project root and run normally.
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  // Supabase (production)
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  // Google Sign In
  static String get googleWebClientId =>
      dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
  static String get googleIosClientId =>
      dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? '';

  // RevenueCat
  static String get revenueCatApiKeyIos =>
      dotenv.env['REVENUECAT_API_KEY_IOS'] ?? '';
  static String get revenueCatApiKeyAndroid =>
      dotenv.env['REVENUECAT_API_KEY_ANDROID'] ?? '';
}
