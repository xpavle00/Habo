import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/services/biometric_auth_service.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';

class BiometricAuthWrapper extends StatefulWidget {
  final Widget child;

  const BiometricAuthWrapper({
    super.key,
    required this.child,
  });

  @override
  State<BiometricAuthWrapper> createState() => _BiometricAuthWrapperState();
}

class _BiometricAuthWrapperState extends State<BiometricAuthWrapper>
    with WidgetsBindingObserver {
  final BiometricAuthService _biometricService = BiometricAuthService();
  bool _isAuthenticated = false;
  bool _isAuthenticating = false;
  bool _hasAuthenticationMethods = false;
  String _authDescription = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAuth();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Only re-authenticate when app comes back to foreground after being paused
    if (state == AppLifecycleState.paused) {
      // Mark as needing re-authentication when app is paused
      if (_shouldRequireAuthentication() && _isAuthenticated) {
        setState(() {
          _isAuthenticated = false;
        });
      }
    }
  }

  bool _shouldRequireAuthentication() {
    final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);
    return settingsManager.getBiometricLock && _hasAuthenticationMethods;
  }

  Future<void> _initializeAuth() async {
    final available = await _biometricService.hasDeviceAuthentication();
    if (!mounted) return;
    final description =
        await _biometricService.getAuthenticationDescription(context);
    if (!mounted) return;

    setState(() {
      _hasAuthenticationMethods = available;
      _authDescription = description;
    });

    // Only require authentication if biometric lock is enabled
    if (_shouldRequireAuthentication()) {
      // Don't auto-authenticate, let user trigger it manually
      setState(() {
        _isAuthenticated = false;
      });
    } else {
      setState(() {
        _isAuthenticated = true;
      });
    }
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    debugPrint('BiometricAuthWrapper: Starting authentication');

    setState(() {
      _isAuthenticating = true;
    });

    try {
      final bool authenticated = await _biometricService.authenticate(
        context: context,
        localizedReason: S.of(context).authenticateToAccess,
      );

      if (!mounted) return;
      debugPrint('BiometricAuthWrapper: Authentication result: $authenticated');

      setState(() {
        _isAuthenticated = authenticated;
        _isAuthenticating = false;
      });

      if (!authenticated) {
        debugPrint(
            'BiometricAuthWrapper: Authentication failed, showing retry dialog');
        _showAuthenticationFailedDialog();
      } else {
        debugPrint(
            'BiometricAuthWrapper: Authentication successful, user authenticated');
      }
    } catch (e) {
      if (!mounted) return;
      debugPrint('BiometricAuthWrapper: Authentication error: $e');
      setState(() {
        _isAuthenticating = false;
      });
      _showAuthenticationFailedDialog();
    }
  }

  void _showAuthenticationFailedDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).authenticationRequired),
          content:
              Text(S.of(context).authenticationFailedMessage(_authDescription)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _authenticate();
              },
              child: Text(S.of(context).tryAgain),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'BiometricAuthWrapper: build() called - shouldRequire: ${_shouldRequireAuthentication()}, isAuthenticated: $_isAuthenticated, isAuthenticating: $_isAuthenticating');

    if (!_shouldRequireAuthentication() || _isAuthenticated) {
      return widget.child;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // App name
            Text(
              S.of(context).habo,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: HaboColors.primary,
                  ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              S.of(context).buildingBetterHabits,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 60),

            // Authentication prompt
            if (_isAuthenticating)
              Column(
                children: [
                  const CircularProgressIndicator(
                    color: HaboColors.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).authenticating,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              )
            else
              Column(
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 48,
                    color: Theme.of(context)
                        .iconTheme
                        .color
                        ?.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).authenticationRequired,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      S.of(context).authenticationPrompt(_authDescription),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withValues(alpha: 0.7),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Authenticate button
                  ElevatedButton.icon(
                    onPressed: _authenticate,
                    icon: const Icon(Icons.fingerprint),
                    label: Text(S.of(context).authenticate),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HaboColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
