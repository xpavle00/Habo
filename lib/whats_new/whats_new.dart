import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:habo/widgets/primary_button.dart';

class WhatsNew extends StatefulWidget {
  const WhatsNew({super.key});

  @override
  State<WhatsNew> createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  void _markSeen(BuildContext context) {
    final settings = Provider.of<SettingsManager>(context, listen: false);
    final current = settings.getCurrentAppVersion;
    if (current.isNotEmpty) {
      settings.setLastWhatsNewVersion = current;
    }
  }

  Future<void> _launchHaboSync() async {
    final uri = Uri.parse('https://habo.space/sync');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _completeOnboarding() {
    _markSeen(context);
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final version = Provider.of<SettingsManager>(
      context,
      listen: false,
    ).getCurrentAppVersion;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Header with glowing icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              HaboColors.primary.withValues(alpha: 0.3),
                              HaboColors.primary.withValues(alpha: 0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: HaboColors.primary.withValues(alpha: 0.15),
                              blurRadius: 24,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.new_releases_rounded,
                          size: 48,
                          color: HaboColors.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        S.of(context).whatsNewTitle,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (version.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            S.of(context).whatsNewVersion(version),
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      const SizedBox(height: 48),
                      // Body List
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[900] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // iOS Sound Mixing
                            Row(
                              children: [
                                const Icon(
                                  Icons.music_note_outlined,
                                  color: HaboColors.primary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    S.of(context).featureIosSoundMixingTitle,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 36.0),
                              child: Text(
                                S.of(context).featureIosSoundMixingDesc,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Homescreen Widget
                            Row(
                              children: [
                                const Icon(
                                  Icons.widgets_outlined,
                                  color: HaboColors.primary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    S.of(context).featureHomescreenWidgetTitle,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 36.0),
                              child: Text(
                                S.of(context).featureHomescreenWidgetDesc,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Longpress Check
                            Row(
                              children: [
                                const Icon(
                                  Icons.touch_app_outlined,
                                  color: HaboColors.primary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    S.of(context).featureLongpressCheckTitle,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 36.0),
                              child: Text(
                                S.of(context).featureLongpressCheckDesc,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Habo Sync Coming Soon
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: HaboColors.primary.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: HaboColors.primary.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.cloud_sync_outlined,
                                  color: HaboColors.primary,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Habo Sync",
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: HaboColors.primary.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    S.of(context).haboSyncComingSoon,
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: HaboColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              S.of(context).haboSyncDescription,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark
                                    ? Colors.grey[300]
                                    : Colors.grey[800],
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: _launchHaboSync,
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).haboSyncLearnMore,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: HaboColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 16,
                                    color: HaboColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: PrimaryButton(
                width: double.infinity,
                onPressed: _completeOnboarding,
                child: Text(
                  S.of(context).done,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
