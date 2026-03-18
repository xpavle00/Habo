import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/widgets/password_change_widgets.dart';
import 'package:habo/generated/l10n.dart';

class ChangeMasterPasswordScreen extends StatefulWidget {
  const ChangeMasterPasswordScreen({super.key});

  static MaterialPage page() {
    return MaterialPage(
      name: '/change-master-password',
      key: const ValueKey('/change-master-password'),
      child: const ChangeMasterPasswordScreen(),
    );
  }

  @override
  State<ChangeMasterPasswordScreen> createState() =>
      _ChangeMasterPasswordScreenState();
}

class _ChangeMasterPasswordScreenState
    extends State<ChangeMasterPasswordScreen> {
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
      setState(
        () => _currentPasswordError = S.of(context).currentPasswordIsRequired,
      );
      return false;
    }

    if (newPassword.isEmpty) {
      setState(() => _newPasswordError = S.of(context).newPasswordIsRequired);
      return false;
    }

    if (newPassword.length < 8) {
      setState(() => _newPasswordError = S.of(context).passwordMinLengthError);
      return false;
    }

    if (confirm.isEmpty) {
      setState(() => _confirmError = S.of(context).pleaseConfirmYourPassword);
      return false;
    }

    if (newPassword != confirm) {
      setState(() => _confirmError = S.of(context).passwordsDoNotMatch);
      return false;
    }

    if (currentPassword == newPassword) {
      setState(
        () => _newPasswordError = S.of(context).newPasswordMustBeDifferent,
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
      await ServiceLocator.instance.syncService.changeMasterPassword(
        currentPassword,
        newPassword,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).masterPasswordChangedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceFirst('Exception: ', '');

        // Check for common error patterns
        if (errorMessage.toLowerCase().contains('invalid') ||
            errorMessage.toLowerCase().contains('wrong') ||
            errorMessage.toLowerCase().contains('incorrect')) {
          setState(
            () =>
                _currentPasswordError = S.of(context).incorrectCurrentPassword,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).errorWithDescription(errorMessage)),
              backgroundColor: Colors.red,
            ),
          );
        }
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
        title: Text(S.of(context).changeMasterPassword),
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
                              Icons.lock_reset,
                              size: 40,
                              color: HaboColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Title
                        Text(
                          S.of(context).changeMasterPassword,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          S.of(context).enterCurrentPasswordAndChooseNew,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 24),

                        // Current Password field
                        PasswordFormField(
                          controller: _currentPasswordController,
                          label: S.of(context).currentPassword,
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
                          label: S.of(context).newPassword,
                          errorText: _newPasswordError,
                          obscureText: _obscureNew,
                          onToggleVisibility: () =>
                              setState(() => _obscureNew = !_obscureNew),
                          onErrorClear: () =>
                              setState(() => _newPasswordError = null),
                          helperText: S.of(context).minimum8Characters,
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password field
                        PasswordFormField(
                          controller: _confirmPasswordController,
                          label: S.of(context).confirmNewPassword,
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
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(S.of(context).changePassword),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.arrow_forward, size: 18),
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
