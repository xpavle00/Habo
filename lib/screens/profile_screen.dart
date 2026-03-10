import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/screens/change_master_password_screen.dart';
import 'package:habo/screens/change_account_password_screen.dart';
import 'package:habo/screens/delete_account_screen.dart';
import 'package:habo/services/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static MaterialPage page() {
    return MaterialPage(
      name: '/profile',
      key: const ValueKey('/profile'),
      child: const ProfileScreen(),
    );
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool get _isEmailPasswordUser {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return false;
    final identities = user.identities;
    if (identities == null || identities.isEmpty) return false;
    return identities.any((id) => id.provider == 'email');
  }

  Future<void> _onSignOut() async {
    // Logout from RevenueCat first to reset user ID
    await ServiceLocator.instance.subscriptionService.logout();
    // Reset sync state, clear key material (syncVersion, unsynced changes, etc.)
    await ServiceLocator.instance.syncManager?.onSignOut();
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      Navigator.of(context).pop(); // Close profile screen
    }
  }

  Future<void> _openSubscriptionManagement() async {
    final subscriptionService = ServiceLocator.instance.subscriptionService;
    final info = await subscriptionService.getSubscriptionInfo();

    Uri? uri;

    if (info?.managementUrl != null) {
      uri = Uri.parse(info!.managementUrl!);
    } else {
      if (Theme.of(context).platform == TargetPlatform.iOS ||
          Theme.of(context).platform == TargetPlatform.macOS) {
        uri = Uri.parse('https://apps.apple.com/account/subscriptions');
      } else if (Theme.of(context).platform == TargetPlatform.android) {
        uri = Uri.parse('https://play.google.com/store/account/subscriptions');
      }
    }

    if (uri != null && mounted) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ServiceLocator.instance.uiFeedbackService.showError(
          'Could not open subscription management',
        );
      }
    } else if (mounted) {
      ServiceLocator.instance.uiFeedbackService.showError(
        'Subscription management not available on this platform',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),

            // Hero section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: HaboColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: HaboColors.primary.withValues(alpha: 0.2),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: HaboColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.email ?? 'Not available',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Profile actions
            _buildProfileAction(
              context: context,
              isDark: isDark,
              icon: Icons.lock_outline,
              title: 'Change Master Password',
              subtitle: 'Update your encryption password',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChangeMasterPasswordScreen(),
                ),
              ),
            ),

            if (_isEmailPasswordUser) ...[
              const SizedBox(height: 12),
              _buildProfileAction(
                context: context,
                isDark: isDark,
                icon: Icons.key,
                title: 'Change Account Password',
                subtitle: 'Update your login password',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChangeAccountPasswordScreen(),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            _buildProfileAction(
              context: context,
              isDark: isDark,
              icon: Icons.credit_card,
              title: 'Manage Subscription',
              subtitle: 'View or cancel your plan',
              onTap: _openSubscriptionManagement,
            ),

            const SizedBox(height: 12),

            _buildProfileAction(
              context: context,
              isDark: isDark,
              icon: Icons.delete_forever,
              iconColor: Colors.redAccent,
              title: 'Delete Account',
              subtitle: 'Permanently delete your account and data',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DeleteAccountScreen(),
                ),
              ),
              titleColor: Colors.redAccent,
            ),

            const SizedBox(height: 32),

            // Sign out at the bottom (matching sync screen style)
            Center(
              child: Column(
                children: [
                  Text(
                    user?.email ?? '',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _showSignOutConfirmation(),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAction({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    final borderRadius = BorderRadius.circular(15);
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.white,
        borderRadius: borderRadius,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashColor: HaboColors.primary.withValues(alpha: 0.08),
          highlightColor: HaboColors.primary.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: iconColor ?? HaboColors.primary, size: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSignOutConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out?'),
        content: const Text(
          'You will need to enter your master password again to access your synced data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _onSignOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
