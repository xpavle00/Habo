import 'package:flutter/material.dart';
import 'package:habo/widgets/password_change_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:habo/generated/l10n.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isProcessing = false;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _newPasswordError;
  String? _confirmPasswordError;
  bool _isSuccess = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validate() {
    bool isValid = true;
    setState(() {
      _newPasswordError = null;
      _confirmPasswordError = null;
    });

    final newPassword = _newPasswordController.text;
    if (newPassword.isEmpty) {
      setState(() => _newPasswordError = S.of(context).passwordCannotBeEmpty);
      isValid = false;
    } else if (newPassword.length < 8) {
      setState(() => _newPasswordError = S.of(context).passwordMinLengthError);
      isValid = false;
    }

    if (_confirmPasswordController.text != newPassword) {
      setState(() => _confirmPasswordError = S.of(context).passwordsDoNotMatch);
      isValid = false;
    }

    return isValid;
  }

  Future<void> _handleResetPassword() async {
    if (!_validate()) return;

    setState(() => _isProcessing = true);

    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: _newPasswordController.text),
      );

      if (mounted) {
        setState(() => _isSuccess = true);
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMsg = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).errorWithDescription(errorMsg)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).resetPassword),
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
                    child: _isSuccess ? _buildSuccessView() : _buildResetForm(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle, size: 40, color: Colors.green),
        ),
        const SizedBox(height: 24),
        Text(
          S.of(context).passwordUpdated,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          S.of(context).passwordResetSuccessMessage,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        const SizedBox(height: 32),
        PrimaryCTAButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).done),
        ),
      ],
    );
  }

  Widget _buildResetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Icon
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lock_reset, size: 40, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 24),

        // Title
        Text(
          S.of(context).setNewPassword,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          S.of(context).chooseStrongPassword,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        const SizedBox(height: 32),

        // New password
        PasswordFormField(
          controller: _newPasswordController,
          label: S.of(context).newPassword,
          helperText: S.of(context).minimum8Characters,
          errorText: _newPasswordError,
          obscureText: _obscureNew,
          onToggleVisibility: () => setState(() => _obscureNew = !_obscureNew),
          onErrorClear: () => setState(() => _newPasswordError = null),
        ),
        const SizedBox(height: 16),

        // Confirm password
        PasswordFormField(
          controller: _confirmPasswordController,
          label: S.of(context).confirmNewPassword,
          errorText: _confirmPasswordError,
          obscureText: _obscureConfirm,
          onToggleVisibility: () =>
              setState(() => _obscureConfirm = !_obscureConfirm),
          onErrorClear: () => setState(() => _confirmPasswordError = null),
        ),
        const SizedBox(height: 24),

        // Submit button
        PrimaryCTAButton(
          onPressed: _isProcessing ? null : _handleResetPassword,
          child: _isProcessing
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(S.of(context).resetPassword),
        ),

        const Spacer(),
      ],
    );
  }
}
