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
                // Version 3.1.0 features
                Row(children: [
                  const Icon(Icons.music_note_outlined,
                      color: HaboColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureIosSoundMixingTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureIosSoundMixingDesc),
                ),
                const SizedBox(height: 16),

                Row(children: [
                  const Icon(Icons.widgets_outlined, color: HaboColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureHomescreenWidgetTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureHomescreenWidgetDesc),
                ),
                const SizedBox(height: 16),

                Row(children: [
                  const Icon(Icons.touch_app_outlined,
                      color: HaboColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      S.of(context).featureLongpressCheckTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text(S.of(context).featureLongpressCheckDesc),
                ),
                const SizedBox(height: 16),

                // Habo Sync Coming Soon
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: HaboColors.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.cloud_sync_outlined,
                              color: HaboColors.primary),
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
                              color: HaboColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              S.of(context).haboSyncComingSoon,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: HaboColors.primary,
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
                                color: HaboColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: HaboColors.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.open_in_new,
                              size: 16,
                              color: HaboColors.primary,
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
      dotsDecorator: const DotsDecorator(activeColor: HaboColors.primary),
      safeAreaList: const [false, false, false, true], // Only bottom SafeArea
    );
  }
}
