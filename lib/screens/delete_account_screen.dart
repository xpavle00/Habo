import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/widgets/password_change_widgets.dart';
import 'package:habo/widgets/primary_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:habo/generated/l10n.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _confirmController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isProcessing = false;
  bool _obscurePassword = true;
  String? _confirmError;
  String? _passwordError;

  bool get _isEmailPasswordUser {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return false;
    final identities = user.identities;
    if (identities == null || identities.isEmpty) return false;
    return identities.any((id) => id.provider == 'email');
  }

  bool get _isDeleteConfirmed =>
      _confirmController.text.trim().toUpperCase() == 'DELETE';

  @override
  void dispose() {
    _confirmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleDeleteAccount() async {
    setState(() {
      _confirmError = null;
      _passwordError = null;
    });

    if (!_isDeleteConfirmed) {
      setState(() => _confirmError = S.of(context).pleaseTypeDeleteToConfirm);
      return;
    }

    // Re-authenticate email/password users
    if (_isEmailPasswordUser) {
      final password = _passwordController.text;
      if (password.isEmpty) {
        setState(() => _passwordError = S.of(context).passwordCannotBeEmpty);
        return;
      }

      final user = Supabase.instance.client.auth.currentUser;
      if (user?.email == null) {
        setState(() => _passwordError = S.of(context).unableToVerifyIdentity);
        return;
      }

      setState(() => _isProcessing = true);

      try {
        await Supabase.instance.client.auth.signInWithPassword(
          email: user!.email!,
          password: password,
        );
      } on AuthException {
        setState(() {
          _passwordError = S.of(context).incorrectPassword;
          _isProcessing = false;
        });
        return;
      }
    } else {
      setState(() => _isProcessing = true);
    }

    try {
      // Call the delete-account edge function
      final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
        throw Exception('No active session');
      }

      final response = await Supabase.instance.client.functions.invoke(
        'delete-account',
        headers: {'Authorization': 'Bearer ${session.accessToken}'},
      );

      if (response.status != 200) {
        final errorMsg = response.data is Map
            ? (response.data['error'] ?? S.of(context).failedToDeleteAccount)
            : S.of(context).failedToDeleteAccount;
        throw Exception(errorMsg);
      }

      // Clear local data
      await ServiceLocator.instance.syncManager?.onSignOut();
      await ServiceLocator.instance.encryptionService.clearKey();

      // Sign out locally (session is already invalid server-side)
      await Supabase.instance.client.auth.signOut(scope: SignOutScope.local);

      if (mounted) {
        // Pop all screens back to root
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).errorWithDescription(errorMessage)),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).deleteAccountTitle),
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
                        // Danger icon
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.warning_rounded,
                              size: 40,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Title
                        Text(
                          S.of(context).deleteYourAccount,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Warning card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.red.withValues(alpha: 0.1)
                                : Colors.red.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.redAccent.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).deleteAccountWarning,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: isDark
                                          ? Colors.grey[300]
                                          : Colors.grey[700],
                                    ),
                              ),
                              const SizedBox(height: 12),
                              _buildDeletionItem(
                                context,
                                S.of(context).deleteHabitsAndTrackingData,
                              ),
                              _buildDeletionItem(
                                context,
                                S.of(context).deleteCloudBackupsAndSyncData,
                              ),
                              _buildDeletionItem(
                                context,
                                S.of(context).deleteEncryptionKeysAndProfile,
                              ),
                              _buildDeletionItem(
                                context,
                                S
                                    .of(context)
                                    .deleteYourAccountAndLoginCredentials,
                              ),
                              _buildDeletionItem(
                                context,
                                S
                                    .of(context)
                                    .deleteSubscriptionManagedSeparately,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Type DELETE confirmation
                        Text(
                          S.of(context).typeDeleteToConfirm,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                                color: isDark
                                    ? Colors.black.withValues(alpha: 0.15)
                                    : const Color(0x21000000),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _confirmController,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 25,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: 'DELETE',
                              prefixIcon: const Icon(
                                Icons.delete_forever,
                                color: Colors.redAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: _confirmError != null
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: HaboColors.red,
                                      ),
                                    )
                                  : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            onChanged: (_) {
                              if (_confirmError != null) {
                                setState(() => _confirmError = null);
                              }
                              setState(() {}); // Update button state
                            },
                          ),
                        ),
                        if (_confirmError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 4),
                            child: Text(
                              _confirmError!,
                              style: const TextStyle(
                                color: HaboColors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),

                        // Password field (only for email/password users)
                        if (_isEmailPasswordUser) ...[
                          Text(
                            S.of(context).enterYourPasswordToConfirm,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          PasswordFormField(
                            controller: _passwordController,
                            label: S.of(context).passwordLabel,
                            errorText: _passwordError,
                            obscureText: _obscurePassword,
                            onToggleVisibility: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            onErrorClear: () =>
                                setState(() => _passwordError = null),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Delete button
                        PrimaryButton(
                          onPressed: _isProcessing || !_isDeleteConfirmed
                              ? null
                              : _handleDeleteAccount,
                          backgroundColor: Colors.redAccent,
                          width: double.infinity,
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
                                    const Icon(Icons.delete_forever, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      S.of(context).permanentlyDeleteAccount,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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

  Widget _buildDeletionItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.close, size: 16, color: Colors.redAccent),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[400]
                    : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
