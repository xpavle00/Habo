import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/notifications.dart';
import 'package:provider/provider.dart';
import 'package:habo/habits/calendar_column.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/navigation/navigation.dart';

class HabitsScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Routes.habitsPath,
      key: ValueKey(Routes.habitsPath),
      child: const HabitsScreen(),
    );
  }

  const HabitsScreen({
    super.key,
  });

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  void initState() {
    super.initState();
    if (platformSupportsNotifications()) {
      Future.delayed(const Duration(seconds: 0), () async {
        showNotificationDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (
        context,
        appStateManager,
        child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Habo',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.bar_chart,
                  semanticLabel: S.of(context).statistics,
                ),
                color: Colors.grey[400],
                tooltip: S.of(context).statistics,
                onPressed: () {
                  Provider.of<HabitsManager>(context, listen: false)
                      .hideSnackBar();
                  Provider.of<AppStateManager>(context, listen: false)
                      .goStatistics(true);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  semanticLabel: S.of(context).settings,
                ),
                color: Colors.grey[400],
                tooltip: S.of(context).settings,
                onPressed: () {
                  Provider.of<AppStateManager>(context, listen: false)
                      .goSettings(true);
                  Provider.of<HabitsManager>(context, listen: false)
                      .hideSnackBar();
                },
              ),
            ],
          ),
          body: const CalendarColumn(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Provider.of<AppStateManager>(context, listen: false)
                  .goCreateHabit(true);
              Provider.of<HabitsManager>(context, listen: false).hideSnackBar();
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              semanticLabel: S.of(context).add,
              size: 35.0,
            ),
          ),
        );
      },
    );
  }

  void showNotificationDialog(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showRestoreDialog(context);
      } else {
        resetNotifications();
      }
    });
  }

  void showRestoreDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: S.of(context).notifications,
      desc: S.of(context).haboNeedsPermission,
      btnOkText: S.of(context).allow,
      btnCancelText: S.of(context).cancel,
      btnCancelColor: Colors.grey,
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        AwesomeNotifications()
            .requestPermissionToSendNotifications()
            .then((value) {
          resetNotifications();
        });
      },
    ).show();
  }

  void resetNotifications() {
    Provider.of<SettingsManager>(context, listen: false).resetAppNotification();
    Provider.of<HabitsManager>(context, listen: false)
        .resetHabitsNotifications();
  }
}
