import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habo/constants.dart';
import 'package:habo/env_config.dart';
import 'package:habo/screens/sync_helpers.dart';
import 'package:habo/widgets/habo_text_field.dart';
import 'package:habo/widgets/primary_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncLoginView extends StatefulWidget {
  const SyncLoginView({super.key});

  @override
  State<SyncLoginView> createState() => _SyncLoginViewState();
}

class _SyncLoginViewState extends State<SyncLoginView> {
  bool _isSignUp = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool _validateAndSave() {
    bool isValid = true;
    setState(() {
      _emailError = null;
      _passwordError = null;
      _confirmError = null;
    });

    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _emailError = 'Email is required');
      isValid = false;
    } else if (!email.contains('@')) {
      setState(() => _emailError = 'Enter a valid email');
      isValid = false;
    }

    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() => _passwordError = 'Password is required');
      isValid = false;
    } else if (_isSignUp && password.length < 6) {
      setState(() => _passwordError = 'Password must be at least 6 characters');
      isValid = false;
    }

    if (_isSignUp) {
      if (_confirmController.text != password) {
        setState(() => _confirmError = 'Passwords do not match');
        isValid = false;
      }
    }

    return isValid;
  }

  Future<void> _handleSubmit() async {
    if (!_validateAndSave()) return;

    setState(() => _isLoading = true);
    try {
      final supabase = Supabase.instance.client;
      if (_isSignUp) {
        await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign up successful! Check your email.'),
            ),
          );
        }
      } else {
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        // StreamBuilder picks up auth state change and triggers rebuild
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();
    final resetEmailController = TextEditingController(text: email);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your email address and we\'ll send you a link to reset your password.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: resetEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              autofocus: email.isEmpty,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Send Reset Link'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final resetEmail = resetEmailController.text.trim();

    if (resetEmail.isEmpty || !resetEmail.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        resetEmail,
        redirectTo: 'habo://reset-password',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your email for a password reset link.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  /// Generates a random string for Apple nonce.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// Returns the SHA256 hash of [input] as a hex string.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final hashedNonce = _sha256ofString(rawNonce);

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = credential.identityToken;
      if (idToken == null) {
        throw Exception('Apple Sign In failed — no identity token received.');
      }

      await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Apple Sign In error: ${e.message}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        clientId: Platform.isIOS ? EnvConfig.googleIosClientId : null,
        serverClientId: EnvConfig.googleWebClientId,
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        throw Exception('Google Sign In failed — no ID token received.');
      }

      await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      if (mounted) {
        final message = e.toString().contains('ApiException')
            ? 'Google Sign In failed. Please check that Google is configured in the developer console with the correct SHA-1 fingerprint.'
            : 'Google Sign In error: $e';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required Widget iconWidget,
    required String label,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(inputDecorationTheme: syncInputDecorationTheme(context)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              // Green circle icon
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: HaboColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_sync,
                    size: 36,
                    color: HaboColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Habo',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _isSignUp
                    ? 'Create an account to backup & sync.'
                    : 'Welcome back! Let\'s stay consistent.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Email field
              HaboTextField(
                label: 'Email',
                errorText: _emailError,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  maxLength: 254,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'hello@habo.app',
                    prefixIcon: const Icon(Icons.email_outlined),
                    enabledBorder: _emailError != null ? syncErrorBorder : null,
                    focusedBorder: _emailError != null
                        ? syncFocusedErrorBorder
                        : null,
                  ),
                  onChanged: (_) {
                    if (_emailError != null) {
                      setState(() => _emailError = null);
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Password field
              HaboTextField(
                label: 'Password',
                errorText: _passwordError,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: _isSignUp
                      ? TextInputAction.next
                      : TextInputAction.done,
                  maxLength: 128,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    enabledBorder: _passwordError != null
                        ? syncErrorBorder
                        : null,
                    focusedBorder: _passwordError != null
                        ? syncFocusedErrorBorder
                        : null,
                  ),
                  onChanged: (_) {
                    if (_passwordError != null) {
                      setState(() => _passwordError = null);
                    }
                  },
                  onFieldSubmitted: _isSignUp ? null : (_) => _handleSubmit(),
                ),
              ),

              // Confirm password field (sign-up only)
              if (_isSignUp) ...[
                const SizedBox(height: 20),
                HaboTextField(
                  label: 'Confirm Password',
                  errorText: _confirmError,
                  child: TextFormField(
                    controller: _confirmController,
                    obscureText: _obscureConfirm,
                    textInputAction: TextInputAction.done,
                    maxLength: 128,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                      enabledBorder: _confirmError != null
                          ? syncErrorBorder
                          : null,
                      focusedBorder: _confirmError != null
                          ? syncFocusedErrorBorder
                          : null,
                    ),
                    onChanged: (_) {
                      if (_confirmError != null) {
                        setState(() => _confirmError = null);
                      }
                    },
                    onFieldSubmitted: (_) => _handleSubmit(),
                  ),
                ),
              ],

              // Forgot password (sign-in only)
              if (!_isSignUp) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _handleForgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // CTA button with green glow
              PrimaryButton(
                onPressed: _isLoading ? null : _handleSubmit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_isSignUp ? 'Create Account' : 'Sign In'),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
              ),

              const SizedBox(height: 24),

              // Toggle sign-in / sign-up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isSignUp
                        ? 'Already have an account? '
                        : 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _isSignUp = !_isSignUp),
                    child: Text(
                      _isSignUp ? 'Sign In' : 'Sign Up',
                      style: const TextStyle(
                        color: HaboColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey[300], thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or continue with',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey[300], thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Social login buttons
              Column(
                children: [
                  // Apple
                  if (Platform.isIOS || Platform.isMacOS) ...[
                    SizedBox(
                      height: 48,
                      child: SignInWithAppleButton(
                        onPressed: _signInWithApple,
                        text: 'Continue with Apple',
                        style: Theme.of(context).brightness == Brightness.dark
                            ? SignInWithAppleButtonStyle.white
                            : SignInWithAppleButtonStyle.black,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Google
                  _buildSocialButton(
                    context: context,
                    iconWidget: SvgPicture.asset(
                      'assets/images/google_logo.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: 'Continue with Google',
                    onTap: _signInWithGoogle,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF131314)
                        : Colors.white,
                    textColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFE3E3E3)
                        : const Color(0xFF1F1F1F),
                    borderColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF8E918F)
                        : const Color(0xFF747775),
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
