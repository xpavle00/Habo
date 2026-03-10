import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/widgets/password_change_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangeAccountPasswordScreen extends StatefulWidget {
  const ChangeAccountPasswordScreen({super.key});

  @override
  State<ChangeAccountPasswordScreen> createState() =>
      _ChangeAccountPasswordScreenState();
}

class _ChangeAccountPasswordScreenState
    extends State<ChangeAccountPasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isProcessing = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _currentPasswordError;
  String? _newPasswordError;
  String? _confirmError;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validatePasswords() {
    setState(() {
      _currentPasswordError = null;
      _newPasswordError = null;
      _confirmError = null;
    });

    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (currentPassword.isEmpty) {
      setState(() => _currentPasswordError = 'Current password is required');
      return false;
    }

    if (newPassword.isEmpty) {
      setState(() => _newPasswordError = 'New password is required');
      return false;
    }

    if (newPassword.length < 8) {
      setState(
        () => _newPasswordError = 'Password must be at least 8 characters',
      );
      return false;
    }

    if (confirm.isEmpty) {
      setState(() => _confirmError = 'Please confirm your password');
      return false;
    }

    if (newPassword != confirm) {
      setState(() => _confirmError = 'Passwords do not match');
      return false;
    }

    if (currentPassword == newPassword) {
      setState(
        () => _newPasswordError = 'New password must be different from current',
      );
      return false;
    }

    return true;
  }

  Future<void> _handleChangePassword() async {
    if (!_validatePasswords()) return;

    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    setState(() => _isProcessing = true);

    try {
      // First verify the current password by attempting to sign in
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        throw Exception('No user logged in');
      }

      // Get the user's email
      final email = user.email;
      if (email == null) {
        throw Exception('No email found for user');
      }

      // Verify current password by attempting to sign in
      try {
        await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: currentPassword,
        );
      } on AuthException {
        // If sign in fails, the password is wrong
        setState(() {
          _currentPasswordError = 'Incorrect current password';
          _isProcessing = false;
        });
        return;
      }

      // Password verified, now update to new password
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account password changed successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } on AuthException catch (e) {
      if (mounted) {
        String errorMessage = e.message;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Account Password'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: passwordChangeInputDecorationTheme(context),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Icon in green circle
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: HaboColors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.key,
                              size: 40,
                              color: HaboColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Title
                        Text(
                          'Change Account Password',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          'This changes your login password for Habo.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 24),

                        // Current Password field
                        PasswordFormField(
                          controller: _currentPasswordController,
                          label: 'Current Password',
                          errorText: _currentPasswordError,
                          obscureText: _obscureCurrent,
                          onToggleVisibility: () => setState(
                            () => _obscureCurrent = !_obscureCurrent,
                          ),
                          onErrorClear: () =>
                              setState(() => _currentPasswordError = null),
                        ),
                        const SizedBox(height: 16),

                        // New Password field
                        PasswordFormField(
                          controller: _newPasswordController,
                          label: 'New Password',
                          errorText: _newPasswordError,
                          obscureText: _obscureNew,
                          onToggleVisibility: () =>
                              setState(() => _obscureNew = !_obscureNew),
                          onErrorClear: () =>
                              setState(() => _newPasswordError = null),
                          helperText: 'Minimum 8 characters',
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password field
                        PasswordFormField(
                          controller: _confirmPasswordController,
                          label: 'Confirm New Password',
                          errorText: _confirmError,
                          obscureText: _obscureConfirm,
                          onToggleVisibility: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                          onErrorClear: () =>
                              setState(() => _confirmError = null),
                        ),
                        const SizedBox(height: 24),

                        // Submit button with green glow
                        PrimaryCTAButton(
                          onPressed: _isProcessing
                              ? null
                              : _handleChangePassword,
                          child: _isProcessing
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
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Change Password'),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward, size: 18),
                                  ],
                                ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
