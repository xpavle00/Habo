import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:habo/generated/l10n.dart';

class BiometricAuthService {
  static final BiometricAuthService _instance = BiometricAuthService._internal();
  factory BiometricAuthService() => _instance;
  BiometricAuthService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  
  // Cache for expensive operations
  List<BiometricType>? _cachedAvailableBiometrics;
  String? _cachedAuthDescription;

  /// Check if biometric authentication is available on the device
  Future<bool> isBiometricAvailable() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  /// Get available biometric types on the device (cached)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    if (_cachedAvailableBiometrics == null) {
      try {
        _cachedAvailableBiometrics = await _localAuth.getAvailableBiometrics();
      } catch (e) {
        _cachedAvailableBiometrics = [];
      }
    }
    return _cachedAvailableBiometrics!;
  }

  /// Authenticate using biometrics or device credentials
  Future<bool> authenticate({
    required BuildContext context,
    required String localizedReason,
    bool biometricOnly = false,
  }) async {
    try {
      // First check if authentication is available based on the requested mode
      final bool isAvailable = biometricOnly
          ? await isBiometricAvailable()
          : await hasDeviceAuthentication();
      if (!isAvailable) {
        debugPrint('BiometricAuthService: Authentication not available');
        return false;
      }

      // Check if device has authentication methods enrolled
      final List<BiometricType> availableBiometrics = await getAvailableBiometrics();
      debugPrint('BiometricAuthService: Available biometrics: $availableBiometrics');

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: localizedReason,
        authMessages: [
          AndroidAuthMessages(
            signInTitle: S.of(context).biometricAuthenticationRequired,
            cancelButton: S.of(context).cancel,
            goToSettingsButton: S.of(context).settings,
            goToSettingsDescription: S.of(context).setupFingerprintFaceUnlock,
            biometricHint: S.of(context).touchSensor,
            biometricNotRecognized: S.of(context).biometricNotRecognized,
            biometricRequiredTitle: S.of(context).biometricRequired,
            biometricSuccess: S.of(context).biometricAuthenticationSucceeded,
            deviceCredentialsRequiredTitle: S.of(context).deviceCredentialsRequired,
            deviceCredentialsSetupDescription: S.of(context).setupDeviceCredentials,
          ),
          IOSAuthMessages(
            cancelButton: S.of(context).cancel,
            goToSettingsButton: S.of(context).settings,
            goToSettingsDescription: S.of(context).setupTouchIdFaceId,
            lockOut: S.of(context).reenableTouchIdFaceId,
          ),
        ],
        options: AuthenticationOptions(
          biometricOnly: biometricOnly,
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );
      debugPrint('BiometricAuthService: Authentication result: $didAuthenticate');
      return didAuthenticate;
    } on PlatformException catch (e) {
      debugPrint('BiometricAuthService: PlatformException - ${e.code}: ${e.message}');
      // Handle specific error cases
      switch (e.code) {
        case 'NotAvailable':
          debugPrint('BiometricAuthService: Biometric authentication not available');
          return false;
        case 'NotEnrolled':
          debugPrint('BiometricAuthService: No biometric credentials enrolled');
          return false;
        case 'LockedOut':
          debugPrint('BiometricAuthService: Authentication locked out temporarily');
          return false;
        case 'PermanentlyLockedOut':
          debugPrint('BiometricAuthService: Authentication permanently locked out');
          return false;
        case 'UserCancel':
          debugPrint('BiometricAuthService: User cancelled authentication');
          return false;
        default:
          debugPrint('BiometricAuthService: Unknown error: ${e.code}');
          return false;
      }
    } catch (e) {
      debugPrint('BiometricAuthService: General error: $e');
      return false;
    }
  }

  /// Get a user-friendly description of available authentication methods (cached)
  Future<String> getAuthenticationDescription(BuildContext context) async {
    if (_cachedAuthDescription == null) {
      final List<BiometricType> availableBiometrics = await getAvailableBiometrics();
      
      if (availableBiometrics.isEmpty) {
        _cachedAuthDescription = S.of(context).devicePinPatternPassword;
      } else {
        List<String> methods = [];
        
        if (availableBiometrics.contains(BiometricType.face)) {
          methods.add("Face ID");
        }
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          methods.add(S.of(context).fingerprint);
        }
        if (availableBiometrics.contains(BiometricType.iris)) {
          methods.add(S.of(context).iris);
        }
        if (availableBiometrics.contains(BiometricType.strong) || 
            availableBiometrics.contains(BiometricType.weak)) {
          methods.add(S.of(context).biometric);
        }
        
        // Add device credentials as fallback
        methods.add(S.of(context).devicePinPatternPassword);
        
        if (methods.length == 1) {
          _cachedAuthDescription = methods.first;
        } else if (methods.length == 2) {
          _cachedAuthDescription = '${methods[0]} or ${methods[1]}';
        } else {
          _cachedAuthDescription = '${methods.sublist(0, methods.length - 1).join(', ')}, or ${methods.last}';
        }
      }
    }
    return _cachedAuthDescription!;
  }

  /// Check if the device has any form of authentication set up
  Future<bool> hasDeviceAuthentication() async {
    try {
      // Consider the device supported if the platform reports support for
      // authentication. This allows device credential fallback on platforms
      // that support it (e.g., Android PIN/Pattern/Password) even when no
      // biometrics are enrolled.
      final bool isSupported = await _localAuth.isDeviceSupported();
      return isSupported;
    } catch (e) {
      return false;
    }
  }
}
