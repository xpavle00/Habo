import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/navigation/routes.dart';
import 'package:habo/settings/color_icon.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
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
    Key? key,
  }) : super(key: key);

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
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: "Warning",
      desc: "All habits will be replaced with habits from backup.",
      btnOkText: "Restore",
      btnCancelText: "Cancel",
      btnCancelColor: Colors.grey,
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        context.loaderOverlay.show();
        await Provider.of<HabitsManager>(context, listen: false).loadBackup();
        context.loaderOverlay.hide();
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
          overlayWidget: const Center(
            child: CircularProgressIndicator(
              color: HaboColors.primary,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Settings',
              ),
              backgroundColor: Colors.transparent,
              iconTheme: Theme.of(context).iconTheme,
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text("Theme"),
                    trailing: DropdownButton<String>(
                      items: Provider.of<SettingsManager>(context)
                          .getThemeList
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      value: Provider.of<SettingsManager>(context).getTheme,
                      onChanged: (value) {
                        Provider.of<SettingsManager>(context, listen: false)
                            .setTheme = value!;
                      },
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("First day of the week"),
                        SizedBox(width: 5),
                      ],
                    ),
                    trailing: DropdownButton<String>(
                      alignment: Alignment.center,
                      items: Provider.of<SettingsManager>(context)
                          .getWeekStartList
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      value: Provider.of<SettingsManager>(context).getWeekStart,
                      onChanged: (value) {
                        Provider.of<SettingsManager>(context, listen: false)
                            .setWeekStart = value!;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Notifications"),
                    trailing: Switch(
                      value:
                          Provider.of<SettingsManager>(context).getShowDailyNot,
                      onChanged: (value) async {
                        Provider.of<SettingsManager>(context, listen: false)
                            .setShowDailyNot = value;
                      },
                    ),
                  ),
                  ListTile(
                    enabled:
                        Provider.of<SettingsManager>(context).getShowDailyNot,
                    title: const Text("Notification time"),
                    trailing: InkWell(
                      onTap: () {
                        if (Provider.of<SettingsManager>(context, listen: false)
                            .getShowDailyNot) {
                          testTime(context);
                        }
                      },
                      child: Text(
                        "${Provider.of<SettingsManager>(context).getDailyNot.hour.toString().padLeft(2, '0')}"
                        ":"
                        "${Provider.of<SettingsManager>(context).getDailyNot.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                            color: (Provider.of<SettingsManager>(context)
                                    .getShowDailyNot)
                                ? null
                                : Theme.of(context).disabledColor),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Sound effects"),
                    trailing: Switch(
                      value:
                          Provider.of<SettingsManager>(context).getSoundEffects,
                      onChanged: (value) {
                        Provider.of<SettingsManager>(context, listen: false)
                            .setSoundEffects = value;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Show month name"),
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
                    title: const Text("Set colors"),
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
                            Provider.of<SettingsManager>(context, listen: false)
                                .checkColor = value;
                          },
                        ),
                        ColorIcon(
                          color: Provider.of<SettingsManager>(context,
                                  listen: false)
                              .failColor,
                          icon: Icons.close,
                          defaultColor: HaboColors.red,
                          onPicked: (value) {
                            Provider.of<SettingsManager>(context, listen: false)
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
                            Provider.of<SettingsManager>(context, listen: false)
                                .skipColor = value;
                          },
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text("Backup"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            Provider.of<HabitsManager>(context, listen: false)
                                .createBackup();
                          },
                          child: const Text(
                            'Create',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
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
                          child: const Text(
                            'Restore',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text("Onboarding"),
                    onTap: () {
                      // navigateToOnboarding(context);
                      Provider.of<AppStateManager>(context, listen: false)
                          .goOnboarding(true);
                    },
                  ),
                  ListTile(
                    title: const Text("About"),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationIcon: Image.asset(
                          "assets/images/icon.png",
                          width: 55,
                          height: 55,
                        ),
                        applicationName: 'Habo',
                        applicationVersion: _packageInfo.version,
                        applicationLegalese: '©2022 Habo',
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyText2,
                                children: [
                                  TextSpan(
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    text: "Terms and Conditions\n",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final Uri url = Uri.parse(
                                            'https://habo.space/terms.html#terms');
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    text: "Privacy Policy\n",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final Uri url = Uri.parse(
                                            'https://habo.space/terms.html#privacy');
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                    text: "Disclaimer\n",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final Uri url = Uri.parse(
                                            'https://habo.space/terms.html#disclaimer');
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
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
        );
      },
    );
  }
}
