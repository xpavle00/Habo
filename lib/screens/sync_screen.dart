import 'package:flutter/material.dart';
import 'package:habo/screens/sync_login_view.dart';
import 'package:habo/screens/sync_master_password_view.dart';
import 'package:habo/screens/sync_onboarding_view.dart';
import 'package:habo/screens/sync_profile_view.dart';
import 'package:habo/screens/verify_email_view.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  static MaterialPage page() {
    return const MaterialPage(
      name: '/sync',
      key: ValueKey('/sync'),
      child: SyncScreen(),
    );
  }

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  bool _isLoading = true;
  bool _hasLocalKey = false;
  bool _hasCheckedProfile = false;
  Map<String, dynamic>? _remoteProfile;
  String? _pendingVerificationEmail;

  @override
  void initState() {
    super.initState();
    _checkState();
  }

  /// Checks both local key state and remote profile state
  Future<void> _checkState() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    // 1. Check Auth
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasCheckedProfile = false;
        });
      }
      return;
    }

    // 2. Check Local Key
    final keyData = await ServiceLocator.instance.encryptionService.loadKey();
    _hasLocalKey = keyData != null;

    if (_hasLocalKey) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    // 3. If no local key, check Remote Profile to determine if it's SETUP or UNLOCK mode
    _remoteProfile = await ServiceLocator.instance.syncService.fetchProfile();
    _hasCheckedProfile = true;

    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _onKeySet() async {
    await _checkState();
  }

  Future<void> _onSignOut() async {
    // Logout from RevenueCat first to reset user ID
    await ServiceLocator.instance.subscriptionService.logout();
    // Reset sync state, clear key material (syncVersion, unsynced changes, etc.)
    await ServiceLocator.instance.syncManager?.onSignOut();
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      // Reset state for next login
      setState(() {
        _hasLocalKey = false;
        _remoteProfile = null;
        _hasCheckedProfile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            tooltip: 'About Sync',
            onPressed: () async {
              final settingsManager = Provider.of<SettingsManager>(
                context,
                listen: false,
              );
              await settingsManager.setHasSeenSyncOnboarding(false);
            },
          ),
        ],
      ),
      body: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _isLoading) {
            // Initial load
            return const Center(child: CircularProgressIndicator());
          }

          // Trigger a check state when user logs in and we are in "loading" state essentially
          // or just whenever data changes.
          // Since this builder runs on auth change:
          if (snapshot.hasData &&
              snapshot.data!.session != null &&
              !_hasLocalKey &&
              !_hasCheckedProfile &&
              !_isLoading) {
            // We detected a login but we haven't checked profile yet
            // Schedule a check
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _checkState();
            });
            return const Center(child: CircularProgressIndicator());
          }

          final session =
              snapshot.data?.session ??
              Supabase.instance.client.auth.currentSession;

          final settingsManager = Provider.of<SettingsManager>(context);

          if (!settingsManager.hasSeenSyncOnboarding) {
            return SyncOnboardingView(
              onComplete: () {
                // Settings handler already triggers notifyListeners
              },
            );
          }

          if (session == null) {
            if (_pendingVerificationEmail != null) {
              return VerifyEmailView(
                email: _pendingVerificationEmail!,
                onBack: () {
                  setState(() => _pendingVerificationEmail = null);
                },
              );
            }
            return SyncLoginView(
              onPendingVerification: (email) {
                setState(() => _pendingVerificationEmail = email);
              },
            );
          }

          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_hasLocalKey) {
            final isSetupMode =
                _remoteProfile == null ||
                _remoteProfile!['encryption_salt'] == null;

            return SyncMasterPasswordView(
              isSetupMode: isSetupMode,
              remoteProfile: _remoteProfile,
              onKeySet: _onKeySet,
              onSignOut: _onSignOut,
            );
          }

          return SyncProfileView(onSignOut: _onSignOut);
        },
      ),
    );
  }
}
