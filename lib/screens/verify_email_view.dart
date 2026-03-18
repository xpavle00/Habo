import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/screens/sync_helpers.dart';
import 'package:habo/widgets/primary_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Shown after sign-up when email confirmation is required.
/// Guides the user to check their inbox, lets them resend,
/// and provides a button to continue once they've confirmed.
class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key, required this.email, required this.onBack});

  /// The email address the confirmation was sent to.
  final String email;

  /// Called when user wants to go back to the login form.
  final VoidCallback onBack;

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  bool _isResending = false;
  bool _isVerifying = false;
  int _resendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _resendCooldown = 60);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _resendCooldown--;
        if (_resendCooldown <= 0) {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _resendEmail() async {
    if (_resendCooldown > 0) return;

    setState(() => _isResending = true);
    try {
      await Supabase.instance.client.auth.resend(
        type: OtpType.signup,
        email: widget.email,
      );
      _startCooldown();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).verificationEmailResent)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).failedToResend(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  Future<void> _checkVerification() async {
    setState(() => _isVerifying = true);
    try {
      // Check if a session was created (e.g. via deep link)
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        // Already signed in — the StreamBuilder in
        // SyncScreen will pick it up automatically.
        return;
      }

      // On mobile, PKCE means the deep link token exchange often fails,
      // but the email IS confirmed server-side. Send user back to login.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).pleaseSignInWithEmailAndPassword),
          ),
        );
        widget.onBack();
      }
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(inputDecorationTheme: syncInputDecorationTheme(context)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),

            // Email icon
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: HaboColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_unread_outlined,
                  size: 36,
                  color: HaboColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              S.of(context).checkYourEmail,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            Text(
              S.of(context).weSentVerificationLinkTo,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            Text(
              widget.email,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              S.of(context).clickLinkInEmailToVerify,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // "I've verified my email" button
            PrimaryButton(
              onPressed: _isVerifying ? null : _checkVerification,
              child: _isVerifying
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).iveVerifiedMyEmail),
                        const SizedBox(width: 8),
                        const Icon(Icons.check_circle_outline, size: 18),
                      ],
                    ),
            ),
            const SizedBox(height: 16),

            // Resend button
            Center(
              child: TextButton(
                onPressed: (_isResending || _resendCooldown > 0)
                    ? null
                    : _resendEmail,
                child: _isResending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _resendCooldown > 0
                            ? S.of(context).resendInSeconds(_resendCooldown)
                            : S.of(context).resendVerificationEmail,
                        style: TextStyle(
                          color: _resendCooldown > 0
                              ? Colors.grey[400]
                              : HaboColors.primary,
                          fontSize: 13,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),

            // Back to sign in
            Center(
              child: GestureDetector(
                onTap: widget.onBack,
                child: Text(
                  S.of(context).backToSignIn,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
