import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';

bool platformSupportsNotifications() => Platform.isAndroid || Platform.isIOS;

void initializeNotifications() {
  AwesomeNotifications().initialize('resource://raw/res_app_icon', [
    NotificationChannel(
      channelKey: 'app_notifications_habo',
      channelName: 'App notifications',
      channelDescription: 'Notification channel for application notifications',
      defaultColor: HaboColors.primary,
      importance: NotificationImportance.Max,
      criticalAlerts: true,
    ),
    NotificationChannel(
      channelKey: 'habit_notifications_habo',
      channelName: 'Habit notifications',
      channelDescription: 'Notification channel for habit notifications',
      defaultColor: HaboColors.primary,
      importance: NotificationImportance.Max,
      criticalAlerts: true,
    ),
  ]);
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
  _setupDailyNotification(
    0,
    timeOfDay,
    'Habo',
    S.current.doNotForgetToCheckYourHabits,
    'app_notifications_habo',
  );
}

void setHabitNotification(
  int id,
  TimeOfDay timeOfDay,
  String title,
  String desc,
) {
  _setupDailyNotification(
    id,
    timeOfDay,
    title,
    desc,
    'habit_notifications_habo',
  );
}

void disableHabitNotification(int id) {
  if (platformSupportsNotifications()) {
    AwesomeNotifications().cancel(id);
  }
}

void disableAppNotification() {
  AwesomeNotifications().cancel(0);
}

Future<void> _setupDailyNotification(
  int id,
  TimeOfDay timeOfDay,
  String title,
  String desc,
  String channel,
) async {
  if (platformSupportsNotifications()) {
    String localTimeZone = await AwesomeNotifications()
        .getLocalTimeZoneIdentifier();
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
        timeZone: localTimeZone,
      ),
    );
  }
}

/// Returns a copy of [schedule] pinned to [timeZone], or null when no update
/// is needed (not a calendar schedule, or already in [timeZone]).
///
/// Reminders are created with the device time zone at scheduling time, so
/// after travelling they would keep firing at home-zone wall-clock times.
/// The copy keeps the same wall-clock hour/minute (and start date, if set).
@visibleForTesting
NotificationCalendar? scheduleForTimeZone(
  NotificationSchedule? schedule,
  String timeZone,
) {
  if (schedule is! NotificationCalendar || schedule.timeZone == timeZone) {
    return null;
  }
  return NotificationCalendar(
    era: schedule.era,
    year: schedule.year,
    month: schedule.month,
    day: schedule.day,
    hour: schedule.hour,
    minute: schedule.minute,
    second: schedule.second ?? 0,
    weekday: schedule.weekday,
    weekOfYear: schedule.weekOfYear,
    repeats: schedule.repeats,
    allowWhileIdle: schedule.allowWhileIdle,
    preciseAlarm: schedule.preciseAlarm,
    timeZone: timeZone,
  );
}

/// Re-creates scheduled reminders that were set up in a different time zone
/// so they fire at the chosen time of day in the device's current zone.
Future<void> rescheduleNotificationsForCurrentTimeZone() async {
  if (!platformSupportsNotifications()) return;
  try {
    final localTimeZone = await AwesomeNotifications()
        .getLocalTimeZoneIdentifier();
    final scheduled = await AwesomeNotifications().listScheduledNotifications();

    for (final notification in scheduled) {
      final content = notification.content;
      final id = content?.id;
      final updatedSchedule = scheduleForTimeZone(
        notification.schedule,
        localTimeZone,
      );
      if (content == null || id == null || updatedSchedule == null) continue;

      // Same id replaces the existing scheduled notification.
      await AwesomeNotifications().createNotification(
        content: _copyContent(id, content),
        schedule: updatedSchedule,
      );
    }
  } catch (e) {
    debugPrint('Error rescheduling notifications for time zone: $e');
  }
}

NotificationContent _copyContent(int id, NotificationContent content) {
  return NotificationContent(
    id: id,
    channelKey: content.channelKey ?? 'habit_notifications_habo',
    title: content.title ?? 'Habo',
    body: content.body ?? '',
    wakeUpScreen: content.wakeUpScreen ?? true,
    criticalAlert: content.criticalAlert ?? true,
    category: content.category ?? NotificationCategory.Reminder,
  );
}

Future<void> rescheduleNotificationForTomorrow(int originalId) async {
  if (platformSupportsNotifications()) {
    try {
      // Get all scheduled notifications
      final notifications = await AwesomeNotifications()
          .listScheduledNotifications();

      // Find the notification with the matching ID
      NotificationModel? existingNotification;
      for (var notification in notifications) {
        if (notification.content?.id == originalId) {
          existingNotification = notification;
          break;
        }
      }

      if (existingNotification != null &&
          existingNotification.content != null) {
        final content = existingNotification.content!;
        final schedule = existingNotification.schedule;

        if (schedule is NotificationCalendar) {
          final tomorrow = DateTime.now().add(const Duration(days: 1));

          await AwesomeNotifications().createNotification(
            content: _copyContent(originalId, content),
            schedule: NotificationCalendar(
              year: tomorrow.year,
              month: tomorrow.month,
              day: tomorrow.day,
              hour: schedule.hour ?? 0,
              minute: schedule.minute ?? 0,
              second: 0,
              millisecond: 0,
              repeats: true,
              preciseAlarm: true,
              timeZone: await AwesomeNotifications()
                  .getLocalTimeZoneIdentifier(),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error rescheduling notification: $e');
    }
  }
}

Future<void> rescheduleNotificationForToday(int originalId) async {
  if (platformSupportsNotifications()) {
    try {
      // Get all scheduled notifications
      final notifications = await AwesomeNotifications()
          .listScheduledNotifications();

      // Find the notification with the matching ID
      NotificationModel? existingNotification;
      for (var notification in notifications) {
        if (notification.content?.id == originalId) {
          existingNotification = notification;
          break;
        }
      }

      if (existingNotification != null &&
          existingNotification.content != null) {
        final content = existingNotification.content!;
        final schedule = existingNotification.schedule;

        if (schedule is NotificationCalendar) {
          await AwesomeNotifications().createNotification(
            content: _copyContent(originalId, content),
            schedule: NotificationCalendar(
              hour: schedule.hour ?? 0,
              minute: schedule.minute ?? 0,
              second: 0,
              millisecond: 0,
              repeats: true,
              preciseAlarm: true,
              timeZone: await AwesomeNotifications()
                  .getLocalTimeZoneIdentifier(),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error rescheduling notification: $e');
    }
  }
}
