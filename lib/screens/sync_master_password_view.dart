import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/screens/sync_helpers.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/services/sync_error.dart';
import 'package:habo/widgets/habo_text_field.dart';
import 'package:habo/widgets/primary_button.dart';
import 'package:habo/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncMasterPasswordView extends StatefulWidget {
  final bool isSetupMode;
  final Map<String, dynamic>? remoteProfile;
  final VoidCallback onKeySet;
  final VoidCallback onSignOut;

  const SyncMasterPasswordView({
    super.key,
    required this.isSetupMode,
    this.remoteProfile,
    required this.onKeySet,
    required this.onSignOut,
  });

  @override
  State<SyncMasterPasswordView> createState() => _SyncMasterPasswordViewState();
}

class _SyncMasterPasswordViewState extends State<SyncMasterPasswordView> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isProcessing = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool _validatePasswords() {
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    setState(() {
      _passwordError = null;
      _confirmError = null;
    });

    if (password.isEmpty) {
      setState(() => _passwordError = S.of(context).passwordCannotBeEmpty);
      return false;
    }

    if (widget.isSetupMode) {
      if (password.length < 8) {
        setState(() => _passwordError = S.of(context).passwordMinLengthError);
        return false;
      }

      if (confirm.isEmpty) {
        setState(() => _confirmError = S.of(context).pleaseConfirmYourPassword);
        return false;
      }

      if (password != confirm) {
        setState(() => _confirmError = S.of(context).passwordsDoNotMatch);
        return false;
      }
    }

    return true;
  }

  Future<void> _handleMasterPassword() async {
    if (!_validatePasswords()) return;

    final password = _passwordController.text;
    setState(() => _isProcessing = true);

    try {
      final syncService = ServiceLocator.instance.syncService;

      if (widget.isSetupMode) {
        await syncService.setupMasterPassword(password);
      } else {
        if (widget.remoteProfile == null) {
          throw Exception('Remote profile not found.');
        }
        await syncService.unlockMasterPassword(password, widget.remoteProfile!);
      }

      // Refresh SyncManager so it knows sync is now configured
      await ServiceLocator.instance.syncManager?.refreshConfiguration();

      widget.onKeySet();
    } on MasterPasswordException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } on HaboSyncException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).anUnexpectedErrorOccurred)),
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
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(inputDecorationTheme: syncInputDecorationTheme(context)),
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
                          child: Icon(
                            widget.isSetupMode
                                ? Icons.enhanced_encryption
                                : Icons.lock_open,
                            size: 40,
                            color: HaboColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Title
                      Text(
                        widget.isSetupMode
                            ? S.of(context).createMasterPassword
                            : S.of(context).unlockYourData,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Description
                      Text(
                        widget.isSetupMode
                            ? S.of(context).masterPasswordDescriptionSetup
                            : S.of(context).masterPasswordDescriptionUnlock,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Security warning card (only in setup mode)
                      if (widget.isSetupMode) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            border: Border.all(color: Colors.red.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red.shade700,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).importantCannotBeRecovered,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      S.of(context).masterPasswordWarning,
                                      style: TextStyle(
                                        color: Colors.red.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Password field
                      HaboTextField(
                        label: S.of(context).masterPasswordLabel,
                        errorText: _passwordError,
                        helperText: widget.isSetupMode
                            ? S.of(context).minimum8Characters
                            : null,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                              tooltip: _obscurePassword
                                  ? 'Show password'
                                  : 'Hide password',
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
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Confirm password field (only in setup mode)
                      if (widget.isSetupMode) ...[
                        HaboTextField(
                          label: S.of(context).confirmPasswordLabel,
                          errorText: _confirmError,
                          child: TextField(
                            controller: _confirmController,
                            obscureText: _obscureConfirm,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirm
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm,
                                ),
                                tooltip: _obscureConfirm
                                    ? 'Show password'
                                    : 'Hide password',
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
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      if (!widget.isSetupMode) const SizedBox(height: 8),

                      // Submit button with green glow
                      PrimaryButton(
                        onPressed: _isProcessing ? null : _handleMasterPassword,
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
                                  Text(
                                    widget.isSetupMode
                                        ? S.of(context).setPassword
                                        : S.of(context).unlockAndSync,
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward, size: 18),
                                ],
                              ),
                      ),

                      // Additional info for unlock mode
                      if (!widget.isSetupMode) ...[
                        const SizedBox(height: 24),
                        Text(
                          S.of(context).unlockPasswordExplanation,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                        ),
                      ],

                      const Spacer(),

                      // Email + Sign out
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 32),
                            Text(
                              Supabase
                                      .instance
                                      .client
                                      .auth
                                      .currentUser
                                      ?.email ??
                                  '',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: widget.onSignOut,
                              child: Text(
                                S.of(context).signOut,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
