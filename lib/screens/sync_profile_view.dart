import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/services/sync_error.dart';
import 'package:habo/services/sync_manager.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncProfileView extends StatefulWidget {
  final VoidCallback onSignOut;
  const SyncProfileView({super.key, required this.onSignOut});

  @override
  State<SyncProfileView> createState() => _SyncProfileViewState();
}

class _SyncProfileViewState extends State<SyncProfileView> {
  Future<void> _showPaywall() async {
    final subscriptionService = ServiceLocator.instance.subscriptionService;
    await subscriptionService.initialize();
    final result = await subscriptionService.showPaywall();

    if (result) {
      // Paywall returned success — ask SyncManager to re-evaluate its status
      // so the statusStream emits the updated state and the UI reacts.
      await ServiceLocator.instance.syncManager?.refreshConfiguration();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final syncManager = ServiceLocator.instance.syncManager;

    if (syncManager == null) {
      return const Center(child: Text('Sync not available'));
    }

    return StreamBuilder<SyncStatus>(
      stream: syncManager.statusStream,
      initialData: syncManager.status,
      builder: (context, statusSnapshot) {
        final status = statusSnapshot.data ?? SyncStatus.idle;
        final isSubscribed = status != SyncStatus.noSubscription;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              // Hero section with sync status
              if (isSubscribed)
                Consumer<SettingsManager>(
                  builder: (context, settings, _) {
                    return _buildStatusHero(
                      context,
                      syncManager,
                      status,
                      settings.isSyncPaused,
                    );
                  },
                )
              else
                _buildStatusHeroSimple(context),

              const SizedBox(height: 24),

              // Subscribe card or action rows
              if (!isSubscribed) ...[
                _buildSubscriptionRequiredCard(context),
              ] else ...[
                // Sync Now CTA
                Builder(
                  builder: (context) {
                    final isSyncing = status == SyncStatus.syncing;
                    return PrimaryButton(
                      onPressed: isSyncing
                          ? null
                          : () {
                              syncManager.syncNow();
                            },
                      child: isSyncing
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
                                Icon(Icons.sync, size: 20),
                                SizedBox(width: 8),
                                Text('Sync Now'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 18),
                              ],
                            ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Action rows
                _buildActionRow(
                  context: context,
                  icon: Icons.pause_circle,
                  iconColor: Colors.orange,
                  title: 'Pause Syncing',
                  subtitle: 'Pauses syncing and backup',
                  trailing: Consumer<SettingsManager>(
                    builder: (context, settings, _) {
                      return Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: settings.isSyncPaused,
                          onChanged: (value) => settings.setIsSyncPaused(value),
                          activeTrackColor: Colors.orange,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                _buildActionRow(
                  context: context,
                  icon: Icons.restore,
                  iconColor: HaboColors.primary,
                  title: 'Restore Data',
                  subtitle: 'From previous backups',
                  trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
                  onTap: () => _showBackupsSheet(context),
                ),
              ],

              SizedBox(height: isSubscribed ? 12 : 24),

              _buildActionRow(
                context: context,
                icon: Icons.person,
                iconColor: HaboColors.primary,
                title: 'Profile',
                subtitle: 'Email, password, and account',
                trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
                onTap: () => Provider.of<AppStateManager>(
                  context,
                  listen: false,
                ).goProfile(true),
              ),

              const SizedBox(height: 32),

              // Email + Sign out
              Center(
                child: Column(
                  children: [
                    Text(
                      user?.email ?? '',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: widget.onSignOut,
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
        );
      },
    );
  }

  Widget _buildStatusHero(
    BuildContext context,
    SyncManager syncManager,
    SyncStatus status,
    bool isPaused,
  ) {
    final lastSyncTime = syncManager.lastSyncTime;

    // If paused, override to show paused state
    if (isPaused && status != SyncStatus.syncing) {
      return _buildHeroColumn(
        context,
        Icons.cloud_done,
        'Syncing Paused',
        _formatLastSyncTime(lastSyncTime) ?? 'Never synced',
        Colors.orange,
        'Paused',
        false,
      );
    }

    String heroText;
    String subtitleText;
    Color dotColor;
    String connectionText;
    IconData iconData;

    switch (status) {
      case SyncStatus.syncing:
        heroText = 'Syncing...';
        subtitleText = 'Your data is being synchronized';
        dotColor = HaboColors.primary;
        connectionText = 'Syncing to Cloud';
        iconData = Icons.cloud_sync;
        break;
      case SyncStatus.synced:
      case SyncStatus.idle:
        heroText = 'Everything is safe';
        subtitleText = _formatLastSyncTime(lastSyncTime) ?? 'Never synced';
        dotColor = HaboColors.primary;
        connectionText = 'Connected to Cloud';
        iconData = Icons.cloud_done;
        break;
      case SyncStatus.error:
        heroText = 'Sync Error';
        subtitleText = 'Tap Sync Now to retry';
        dotColor = Colors.red;
        connectionText = 'Error';
        iconData = Icons.cloud_off;
        break;
      case SyncStatus.offline:
        heroText = 'You\'re offline';
        subtitleText = 'Will sync when connected';
        dotColor = Colors.grey;
        connectionText = 'Offline';
        iconData = Icons.cloud_off;
        break;
      case SyncStatus.notConfigured:
        heroText = 'Not configured';
        subtitleText = 'Set up sync to enable';
        dotColor = Colors.orange;
        connectionText = 'Not configured';
        iconData = Icons.cloud_off;
        break;
      case SyncStatus.noSubscription:
        heroText = 'Subscription needed';
        subtitleText = 'Subscribe to enable sync';
        dotColor = Colors.amber;
        connectionText = 'Not active';
        iconData = Icons.cloud_off;
        break;
    }

    return _buildHeroColumn(
      context,
      iconData,
      heroText,
      subtitleText,
      dotColor,
      connectionText,
      status == SyncStatus.syncing,
    );
  }

  Widget _buildStatusHeroSimple(BuildContext context) {
    return _buildHeroColumn(
      context,
      Icons.cloud_sync,
      'Cloud & Backup',
      'Subscribe to enable sync',
      Colors.grey,
      'Not active',
      false,
    );
  }

  Widget _buildHeroColumn(
    BuildContext context,
    IconData iconData,
    String heroText,
    String subtitleText,
    Color dotColor,
    String connectionText,
    bool isSyncing,
  ) {
    return Column(
      children: [
        // Sync icon in green circle
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: HaboColors.primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
            border: Border.all(
              color: HaboColors.primary.withValues(alpha: 0.2),
              width: 3,
            ),
          ),
          child: isSyncing
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      HaboColors.primary,
                    ),
                  ),
                )
              : Icon(iconData, size: 40, color: HaboColors.primary),
        ),
        const SizedBox(height: 20),

        // Hero text
        Text(
          heroText,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),

        // Subtitle
        Text(
          subtitleText,
          style: TextStyle(color: Colors.grey[500], fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        // Connection status dot
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              connectionText,
              style: TextStyle(
                color: dotColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionRow({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
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
            trailing,
          ],
        ),
      ),
    );
  }

  void _showBackupsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _BackupsSheet(
        onRestore: (backupId, backupDate) {
          Navigator.of(ctx).pop();
          _showRestoreConfirmation(context, backupId, backupDate);
        },
      ),
    );
  }

  Widget _buildSubscriptionRequiredCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1A3A1A), const Color(0xFF0D2B0D)]
              : [
                  HaboColors.primary.withValues(alpha: 0.05),
                  HaboColors.primary.withValues(alpha: 0.12),
                ],
        ),
        border: Border.all(
          color: HaboColors.primary.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: HaboColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.rocket_launch,
              size: 28,
              color: HaboColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Unlock Sync & Backup',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Keep your habits safe and synced across all your devices.',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Feature list
          _buildFeatureItem(Icons.sync, 'Real-time sync across devices'),
          const SizedBox(height: 10),
          _buildFeatureItem(Icons.backup, 'Automatic cloud backups'),
          const SizedBox(height: 10),
          _buildFeatureItem(Icons.lock, 'End-to-end encryption'),

          const SizedBox(height: 24),

          // Subscribe button
          PrimaryButton(
            onPressed: _showPaywall,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 20),
                SizedBox(width: 8),
                Text('Subscribe'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),

          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              final subscriptionService =
                  ServiceLocator.instance.subscriptionService;
              await subscriptionService.initialize();
              final restored = await subscriptionService.restorePurchases();
              if (restored && mounted) {
                await ServiceLocator.instance.syncManager
                    ?.refreshConfiguration();
                ServiceLocator.instance.uiFeedbackService.showSuccess(
                  'Purchases restored successfully!',
                );
              } else if (mounted) {
                ServiceLocator.instance.uiFeedbackService.showError(
                  'No previous purchases found.',
                );
              }
            },
            child: Text(
              'Restore Purchases',
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: HaboColors.primary, size: 20),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  String? _formatLastSyncTime(DateTime? lastSyncTime) {
    if (lastSyncTime == null) {
      return 'Never synced';
    }

    final diff = DateTime.now().difference(lastSyncTime);

    if (diff.inMinutes < 1) {
      return 'Last synced just now';
    } else if (diff.inMinutes < 60) {
      return 'Last synced ${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return 'Last synced ${diff.inHours} hours ago';
    } else {
      final days = diff.inDays;
      return 'Last synced $days day${days > 1 ? 's' : ''} ago';
    }
  }

  String _formatBackupDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays < 7) {
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return '${weekdays[date.weekday - 1]} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }

  void _showRestoreConfirmation(
    BuildContext context,
    String backupId,
    DateTime backupDate,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore Backup?'),
        content: Text(
          'This will replace all current data with the backup from ${_formatBackupDate(backupDate)}.\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await _performRestore(backupId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }

  Future<void> _performRestore(String backupId) async {
    try {
      await ServiceLocator.instance.syncService.restoreFromBackup(backupId);

      // Push the restored data to make it the "truth"
      await ServiceLocator.instance.syncManager?.onLocalBackupRestored();

      // Reload habits in memory
      final habitsManager = Provider.of<HabitsManager>(context, listen: false);
      await habitsManager.reloadFromDatabase();

      if (mounted) {
        ServiceLocator.instance.uiFeedbackService.showSuccess(
          'Backup restored successfully!',
        );
      }
    } on HaboSyncException catch (e) {
      dev.log('Restore failed (${e.code})', name: 'SyncProfileView', error: e);
      if (mounted) {
        ServiceLocator.instance.uiFeedbackService.showError(
          'Restore failed: ${e.message}',
        );
      }
    } catch (e) {
      dev.log('Restore failed (unexpected)', name: 'SyncProfileView', error: e);
      if (mounted) {
        ServiceLocator.instance.uiFeedbackService.showError(
          'Restore failed. Please try again.',
        );
      }
    }
  }
}

class _BackupsSheet extends StatelessWidget {
  final void Function(String backupId, DateTime backupDate) onRestore;

  const _BackupsSheet({required this.onRestore});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays < 7) {
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return '${weekdays[date.weekday - 1]} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Restore Data',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose a backup to restore from',
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: ServiceLocator.instance.syncService.listBackups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final backups = snapshot.data ?? [];

                if (backups.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'No backups available yet.\nBackups are created automatically during sync.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: backups.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                  itemBuilder: (context, index) {
                    final backup = backups[index];
                    final createdAt = DateTime.parse(
                      backup['created_at'],
                    ).toLocal();
                    final habitsCount = backup['habits_count'] ?? 0;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: HaboColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.restore,
                          color: HaboColors.primary,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        _formatDate(createdAt),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('$habitsCount habits'),
                      trailing: TextButton(
                        onPressed: () => onRestore(backup['id'], createdAt),
                        child: const Text('Restore'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
