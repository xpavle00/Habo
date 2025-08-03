import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/extensions.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/navigation/routes.dart';
import 'package:habo/notifications.dart';
import 'package:habo/settings/color_icon.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Routes.settingsPath,
      key: ValueKey(Routes.settingsPath),
      child: const SettingsScreen(),
    );
  }

  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> testTime(context) async {
    TimeOfDay? selectedTime;
    TimeOfDay initialTime =
        Provider.of<SettingsManager>(context, listen: false).getDailyNot;
    selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (selectedTime != null) {
      Provider.of<SettingsManager>(context, listen: false).setDailyNot =
          selectedTime;
    }
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  showRestoreDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: S.of(context).warning,
      desc: S.of(context).allHabitsWillBeReplaced,
      btnOkText: S.of(context).restore,
      btnCancelText: S.of(context).cancel,
      btnCancelColor: Colors.grey,
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await Provider.of<HabitsManager>(context, listen: false).loadBackup();
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (
        context,
        appStateManager,
        child,
      ) {
        return LoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) {
            return const Center(
              child: CircularProgressIndicator(
                color: HaboColors.primary,
              ),
            );
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).settings,
              ),
              backgroundColor: Colors.transparent,
              iconTheme: Theme.of(context).iconTheme,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(S.of(context).theme),
                      trailing: DropdownButton<Themes>(
                        items: Themes.values.map((Themes value) {
                          return DropdownMenuItem<Themes>(
                            value: value,
                            child: Text(
                              S.of(context).themeSelect(value.name),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                        value: Provider.of<SettingsManager>(context)
                            .getThemeString,
                        onChanged: (value) {
                          Provider.of<SettingsManager>(context, listen: false)
                              .setTheme = value!;
                        },
                      ),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(S.of(context).firstDayOfWeek),
                          const SizedBox(width: 5),
                        ],
                      ),
                      trailing: DropdownButton<dynamic>(
                        alignment: Alignment.center,
                        items: StartingDayOfWeek.values.map((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            alignment: Alignment.center,
                            value: value,
                            child: Text(
                              DateFormat('E', Intl.getCurrentLocale())
                                  .dateSymbols
                                  .WEEKDAYS[(value.index + 1) % 7]
                                  .substring(0, 2)
                                  .capitalize(),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                        value: Provider.of<SettingsManager>(context)
                            .getWeekStartEnum,
                        onChanged: (value) {
                          Provider.of<SettingsManager>(context, listen: false)
                              .setWeekStart = value;
                        },
                      ),
                    ),
                    if (platformSupportsNotifications())
                      ListTile(
                        title: Text(S.of(context).notifications),
                        trailing: Switch(
                          value: Provider.of<SettingsManager>(context)
                              .getShowDailyNot,
                          onChanged: (value) async {
                            Provider.of<SettingsManager>(context, listen: false)
                                .setShowDailyNot = value;
                          },
                        ),
                      ),
                    if (platformSupportsNotifications())
                      ListTile(
                        enabled: Provider.of<SettingsManager>(context)
                            .getShowDailyNot,
                        title: Text(S.of(context).notificationTime),
                        trailing: InkWell(
                          onTap: () {
                            if (Provider.of<SettingsManager>(context,
                                    listen: false)
                                .getShowDailyNot) {
                              testTime(context);
                            }
                          },
                          child: Text(
                            '${Provider.of<SettingsManager>(context).getDailyNot.hour.toString().padLeft(2, '0')}'
                            ':'
                            '${Provider.of<SettingsManager>(context).getDailyNot.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                                color: (Provider.of<SettingsManager>(context)
                                        .getShowDailyNot)
                                    ? null
                                    : Theme.of(context).disabledColor),
                          ),
                        ),
                      ),
                    ListTile(
                      title: Text(S.of(context).soundEffects),
                      trailing: Switch(
                        value: Provider.of<SettingsManager>(context)
                            .getSoundEffects,
                        onChanged: (value) {
                          Provider.of<SettingsManager>(context, listen: false)
                              .setSoundEffects = value;
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(S.of(context).showMonthName),
                      trailing: Switch(
                        value: Provider.of<SettingsManager>(context)
                            .getShowMonthName,
                        onChanged: (value) {
                          Provider.of<SettingsManager>(context, listen: false)
                              .setShowMonthName = value;
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(S.of(context).setColors),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorIcon(
                            color: Provider.of<SettingsManager>(context,
                                    listen: false)
                                .checkColor,
                            icon: Icons.check,
                            defaultColor: HaboColors.primary,
                            onPicked: (value) {
                              Provider.of<SettingsManager>(context,
                                      listen: false)
                                  .checkColor = value;
                            },
                          ),
                          ColorIcon(
                            color: Provider.of<SettingsManager>(context,
                                    listen: false)
                                .progressColor,
                            icon: Icons.trending_up,
                            defaultColor: HaboColors.progress,
                            onPicked: (value) {
                              Provider.of<SettingsManager>(context,
                                      listen: false)
                                  .progressColor = value;
                            },
                          ),
                          ColorIcon(
                            color: Provider.of<SettingsManager>(context,
                                    listen: false)
                                .failColor,
                            icon: Icons.close,
                            defaultColor: HaboColors.red,
                            onPicked: (value) {
                              Provider.of<SettingsManager>(context,
                                      listen: false)
                                  .failColor = value;
                            },
                          ),
                          ColorIcon(
                            color: Provider.of<SettingsManager>(context,
                                    listen: false)
                                .skipColor,
                            icon: Icons.last_page,
                            defaultColor: HaboColors.skip,
                            onPicked: (value) {
                              Provider.of<SettingsManager>(context,
                                      listen: false)
                                  .skipColor = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(S.of(context).backup),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              final habitsManager = Provider.of<HabitsManager>(context, listen: false);
                              await ServiceLocator.instance.backupService.createBackup(
                                habitsManager.getAllHabits,
                              );
                            },
                            child: Text(
                              S.of(context).create,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                            color: Colors.grey,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              showRestoreDialog(context);
                            },
                            child: Text(
                              S.of(context).restore,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(S.of(context).onboarding),
                      onTap: () {
                        Provider.of<AppStateManager>(context, listen: false)
                            .goOnboarding(true);
                      },
                    ),
                    ListTile(
                      title: Text(S.of(context).about),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationIcon: Image.asset(
                            'assets/images/icon.png',
                            width: 55,
                            height: 55,
                          ),
                          applicationName: 'Habo',
                          applicationVersion: _packageInfo.version,
                          applicationLegalese: '©2023 Habo',
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      text: S.of(context).termsAndConditions,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final Uri url = Uri.parse(
                                              'https://habo.space/terms.html#terms');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                    ),
                                    const TextSpan(text: '\n'),
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      text: S.of(context).privacyPolicy,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final Uri url = Uri.parse(
                                              'https://habo.space/terms.html#privacy');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                    ),
                                    const TextSpan(text: '\n'),
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      text: S.of(context).disclaimer,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final Uri url = Uri.parse(
                                              'https://habo.space/terms.html#disclaimer');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                    ),
                                    const TextSpan(text: '\n'),
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      text: S.of(context).sourceCode,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final Uri url = Uri.parse(
                                              'https://github.com/xpavle00/Habo');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                    ),
                                    const TextSpan(text: '\n\n'),
                                    TextSpan(
                                      text: S.of(context).ifYouWantToSupport,
                                    ),
                                    const TextSpan(text: '\n'),
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      text: S.of(context).buyMeACoffee,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final Uri url = Uri.parse(
                                              'https://www.buymeacoffee.com/peterpavlenko');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(
                                              url,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
