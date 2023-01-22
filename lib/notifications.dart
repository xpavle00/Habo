import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';

void initializeNotifications() {
  AwesomeNotifications().initialize(
    'resource://raw/res_app_icon',
    [
      NotificationChannel(
          channelKey: 'app_notifications_habo',
          channelName: 'App notifications',
          channelShowBadge: true,
          channelDescription:
              'Notification channel for application notifications',
          defaultColor: HaboColors.primary,
          importance: NotificationImportance.Max,
          criticalAlerts: true),
      NotificationChannel(
          channelKey: 'habit_notifications_habo',
          channelName: 'Habit notifications',
          channelShowBadge: true,
          channelDescription: 'Notification channel for habit notifications',
          defaultColor: HaboColors.primary,
          importance: NotificationImportance.Max,
          criticalAlerts: true)
    ],
  );
}

void resetAppNotificationIfMissing(TimeOfDay timeOfDay) async {
  AwesomeNotifications().listScheduledNotifications().then((notifications) {
    for (var not in notifications) {
      if (not.content?.id == 0) {
        return;
      }
    }
    setAppNotification(timeOfDay);
  });
}

void setAppNotification(TimeOfDay timeOfDay) async {
  _setupDailyNotification(0, timeOfDay, 'Habo',
      'Do not forget to check your habits.', 'app_notifications_habo');
}

void setHabitNotification(
    int id, TimeOfDay timeOfDay, String title, String desc) {
  _setupDailyNotification(
      id, timeOfDay, title, desc, 'habit_notifications_habo');
}

void disableHabitNotification(int id) {
  AwesomeNotifications().cancel(id);
}

void disableAppNotification() {
  AwesomeNotifications().cancel(0);
}

Future<void> _setupDailyNotification(int id, TimeOfDay timeOfDay, String title,
    String desc, String channel) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channel,
      title: title,
      body: desc,
      wakeUpScreen: true,
      criticalAlert: true,
      category: NotificationCategory.Reminder,
    ),
    schedule: NotificationCalendar(
        hour: timeOfDay.hour,
        minute: timeOfDay.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
        preciseAlarm: true,
        timeZone: localTimeZone),
  );
}
