import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/services/sync_error.dart';
import 'package:habo/services/sync_manager.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SyncProfileView extends StatefulWidget {
  final VoidCallback onSignOut;
  const SyncProfileView({super.key, required this.onSignOut});

  @override
  State<SyncProfileView> createState() => _SyncProfileViewState();
}

class _SyncProfileViewState extends State<SyncProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowPaywall();
    });
  }

  Future<void> _checkAndShowPaywall() async {
    final syncManager = ServiceLocator.instance.syncManager;
    if (syncManager != null &&
        syncManager.status == SyncStatus.noSubscription) {
      await _showPaywall();
    }
  }

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
      return Center(child: Text(S.of(context).syncNotAvailable));
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
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.sync, size: 20),
                                const SizedBox(width: 8),
                                Text(S.of(context).syncNow),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 18),
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
                  title: S.of(context).pauseSyncing,
                  subtitle: S.of(context).pausesSyncingAndBackup,
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
                  title: S.of(context).restoreData,
                  subtitle: S.of(context).fromPreviousBackups,
                  trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
                  onTap: () => _showBackupsSheet(context),
                ),
              ],

              SizedBox(height: isSubscribed ? 12 : 24),

              _buildActionRow(
                context: context,
                icon: Icons.person,
                iconColor: HaboColors.primary,
                title: S.of(context).profile,
                subtitle: S.of(context).emailPasswordAndAccount,
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
        S.of(context).syncingPaused,
        _formatLastSyncTime(context, lastSyncTime) ?? S.of(context).neverSynced,
        Colors.orange,
        S.of(context).paused,
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
        heroText = S.of(context).syncingHero;
        subtitleText = S.of(context).dataBeingSynchronized;
        dotColor = HaboColors.primary;
        connectionText = S.of(context).syncingToCloud;
        iconData = Icons.cloud_sync;
        break;
      case SyncStatus.synced:
      case SyncStatus.idle:
        heroText = S.of(context).everythingIsSafe;
        subtitleText =
            _formatLastSyncTime(context, lastSyncTime) ??
            S.of(context).neverSynced;
        dotColor = HaboColors.primary;
        connectionText = S.of(context).connectedToCloud;
        iconData = Icons.cloud_done;
        break;
      case SyncStatus.error:
        heroText = S.of(context).syncError;
        subtitleText = S.of(context).tapSyncNowToRetry;
        dotColor = Colors.red;
        connectionText = S.of(context).errorText;
        iconData = Icons.cloud_off;
        break;
      case SyncStatus.offline:
        heroText = S.of(context).youAreOffline;
        subtitleText = S.of(context).willSyncWhenConnected;
        dotColor = Colors.grey;
        connectionText = S.of(context).offline;
        iconData = Icons.cloud_off;
        break;
      case SyncStatus.notConfigured:
        heroText = S.of(context).notConfigured;
        subtitleText = S.of(context).setUpSyncToEnable;
        dotColor = Colors.orange;
        connectionText = S.of(context).notConfigured;
        iconData = Icons.cloud_off;
        break;
      case SyncStatus.noSubscription:
        heroText = S.of(context).subscriptionNeeded;
        subtitleText = S.of(context).subscribeToEnableSync;
        dotColor = Colors.amber;
        connectionText = S.of(context).notActive;
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
      S.of(context).syncAndBackup,
      S.of(context).subscribeToEnableSync,
      Colors.grey,
      S.of(context).notActive,
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
        color: isDark
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
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
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.cloud_off,
            size: 48,
            color: isDark ? Colors.grey[400] : Colors.grey[500],
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).unlockSyncAndBackup,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).subscribeToEnableSync,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Subscribe button
          PrimaryButton(
            onPressed: _showPaywall,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, size: 20),
                const SizedBox(width: 8),
                Text(S.of(context).subscribe),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),

          const SizedBox(height: 16),
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
                  S.of(context).purchasesRestoredSuccessfully,
                );
              } else if (mounted) {
                ServiceLocator.instance.uiFeedbackService.showError(
                  S.of(context).noPreviousPurchasesFound,
                );
              }
            },
            child: Text(
              S.of(context).restorePurchases,
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 11,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: S.of(context).termsAndConditions,
                  style: const TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final Uri url = Uri.parse(
                        'https://habo.space/terms.html#terms',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                ),
                const TextSpan(text: '  •  '),
                TextSpan(
                  text: S.of(context).privacyPolicy,
                  style: const TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final Uri url = Uri.parse(
                        'https://habo.space/terms.html#privacy',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                ),
                const TextSpan(text: '  •  '),
                TextSpan(
                  text: 'EULA',
                  style: const TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final Uri url = Uri.parse(
                        'https://habo.space/terms.html#eula',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _formatLastSyncTime(BuildContext context, DateTime? lastSyncTime) {
    if (lastSyncTime == null) {
      return S.of(context).neverSynced;
    }

    final diff = DateTime.now().difference(lastSyncTime);

    if (diff.inMinutes < 1) {
      return S.of(context).lastSyncedJustNow;
    } else if (diff.inMinutes < 60) {
      return S.of(context).lastSyncedMinsAgo(diff.inMinutes);
    } else if (diff.inHours < 24) {
      return S.of(context).lastSyncedHoursAgo(diff.inHours);
    } else {
      final days = diff.inDays;
      return S.of(context).lastSyncedDaysAgo(days, days > 1 ? 's' : '');
    }
  }

  String _formatBackupDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    final timeStr =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    if (diff.inDays == 0) {
      return S.of(context).todayAt(timeStr);
    } else if (diff.inDays == 1) {
      return S.of(context).yesterdayAt(timeStr);
    } else if (diff.inDays < 7) {
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return S.of(context).weekdayAt(weekdays[date.weekday - 1], timeStr);
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
        title: Text(S.of(context).restoreBackupQuestion),
        content: Text(
          S
              .of(context)
              .restoreBackupConfirmation(
                _formatBackupDate(context, backupDate),
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(S.of(context).cancel),
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
            child: Text(S.of(context).restore),
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
          S.of(context).backupRestoredSuccessfully,
        );
      }
    } on HaboSyncException catch (e) {
      dev.log('Restore failed (${e.code})', name: 'SyncProfileView', error: e);
      if (mounted) {
        ServiceLocator.instance.uiFeedbackService.showError(
          S.of(context).restoreFailedWithError(e.message),
        );
      }
    } catch (e) {
      dev.log('Restore failed (unexpected)', name: 'SyncProfileView', error: e);
      if (mounted) {
        ServiceLocator.instance.uiFeedbackService.showError(
          S.of(context).restoreFailedTryAgain,
        );
      }
    }
  }
}

class _BackupsSheet extends StatelessWidget {
  final void Function(String backupId, DateTime backupDate) onRestore;

  const _BackupsSheet({required this.onRestore});

  String _formatDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    final timeStr =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    if (diff.inDays == 0) {
      return S.of(context).todayAt(timeStr);
    } else if (diff.inDays == 1) {
      return S.of(context).yesterdayAt(timeStr);
    } else if (diff.inDays < 7) {
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return S.of(context).weekdayAt(weekdays[date.weekday - 1], timeStr);
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
            S.of(context).restoreData,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            S.of(context).chooseBackupToRestore,
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
                        S.of(context).noBackupsAvailable,
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
                        _formatDate(context, createdAt),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(S.of(context).habitsCount(habitsCount)),
                      trailing: TextButton(
                        onPressed: () => onRestore(backup['id'], createdAt),
                        child: Text(S.of(context).restore),
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
