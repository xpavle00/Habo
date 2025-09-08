import 'dart:io';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsNew extends StatelessWidget {
  const WhatsNew({super.key});

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final version = Provider.of<SettingsManager>(context, listen: false)
        .getCurrentAppVersion;

    final pages = <PageViewModel>[
      PageViewModel(
        titleWidget: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).whatsNewTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (version.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    S.of(context).whatsNewVersion(version),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color
                          ?.withValues(alpha: 0.7),
                    ),
                  ),
                ),
            ],
          ),
        ),
        bodyWidget: SafeArea(
          left: true,
          right: true,
          top: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.push_pin_outlined,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureNumericTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureNumericDesc),
                ),
                const SizedBox(height: 16),

                Row(children: [
                  Icon(Icons.link, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureDeepLinksTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureDeepLinksDesc),
                ),
                const SizedBox(height: 16),

                Row(children: [
                  Icon(Icons.category, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureCategoriesTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureCategoriesDesc),
                ),
                const SizedBox(height: 16),

                Row(children: [
                  Icon(Icons.inventory_2_outlined,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureArchiveTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureArchiveDesc),
                ),
                const SizedBox(height: 16),

                // Material You theme - Android only
                if (!Platform.isIOS) ...[
                  Row(children: [
                    Icon(Icons.palette_outlined,
                        color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        S.of(context).featureMaterialYouTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 34.0),
                    child: Text(S.of(context).featureMaterialYouDesc),
                  ),
                  const SizedBox(height: 16),
                ],

                Row(children: [
                  Icon(Icons.volume_up_outlined,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureSoundTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureSoundDesc),
                ),
                const SizedBox(height: 16),

                Row(children: [
                  Icon(Icons.lock_outline, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureLockTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureLockDesc),
                ),
                const SizedBox(height: 24),

                // Habo Sync Coming Soon
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.cloud_sync_outlined,
                              color: theme.colorScheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Habo Sync",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              S.of(context).haboSyncComingSoon,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        S.of(context).haboSyncDescription,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: _launchHaboSync,
                        child: Row(
                          children: [
                            Text(
                              S.of(context).haboSyncLearnMore,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.open_in_new,
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
    return IntroductionScreen(
      pages: pages,
      done: Text(S.of(context).done,
          style: const TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        _markSeen(context);
        Navigator.of(context).maybePop();
      },
      next: const Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: Text(S.of(context).skip),
      onSkip: () {
        _markSeen(context);
        Navigator.of(context).maybePop();
      },
      dotsDecorator: DotsDecorator(activeColor: theme.colorScheme.primary),
    );
  }
}
