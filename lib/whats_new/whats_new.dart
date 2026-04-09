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
                      // Habo Sync
                      Row(
                        children: [
                          const Icon(
                            Icons.cloud_sync_outlined,
                            color: HaboColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Habo Sync",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0),
                        child: Text(
                          S.of(context).haboSyncDescription,
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0),
                        child: GestureDetector(
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
                      ),
                      const SizedBox(height: 48),
                      // Homescreen widget dark mode
                      Row(
                        children: [
                          const Icon(
                            Icons.dark_mode_outlined,
                            color: HaboColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              S.of(context).featureHomescreenWidgetTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0),
                        child: Text(
                          S.of(context).featureHomescreenWidgetDarkModeDesc,
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[700],
                            height: 1.4,
                          ),
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
