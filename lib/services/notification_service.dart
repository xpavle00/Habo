import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/constants.dart';
import 'package:habo/notifications.dart' as notifications;

/// Service responsible for managing habit notifications
///
/// Extracts notification functionality from HabitsManager to provide
/// a focused, testable service for notification operations.
class NotificationService {
  /// Resets notifications for all provided habits
  ///
  /// Checks existing notifications and habit completion status
  /// to avoid duplicate notifications.
  void resetNotifications(List<Habit> habits) {
    if (!notifications.platformSupportsNotifications()) return;

    // Check existing notifications and habit completion status
    AwesomeNotifications()
        .listScheduledNotifications()
        .then((scheduledNotifications) {
      final existingIds = scheduledNotifications
          .map((n) => n.content?.id)
          .whereType<int>()
          .toSet();

      for (var element in habits) {
        if (element.habitData.notification) {
          var data = element.habitData;

          // Check if habit is already completed for today
          DateTime today = DateTime.now();
          DateTime todayDate = DateTime(today.year, today.month, today.day);
          bool isCompletedToday = false;

          // Check if there's a completed event for today
          data.events.forEach((date, event) {
            if (date.year == todayDate.year &&
                date.month == todayDate.month &&
                date.day == todayDate.day) {
              if (event[0] == DayType.check) {
                isCompletedToday = true;
              }
            }
          });

          // Only schedule notification if not completed today
          if (!isCompletedToday && !existingIds.contains(data.id)) {
            notifications.setHabitNotification(
                data.id!, data.notTime, 'Habo', data.title);
          }
        }
      }
    });
  }

  /// Removes notifications for all provided habits
  void removeNotifications(List<Habit> habits) {
    for (var element in habits) {
      notifications.disableHabitNotification(element.habitData.id!);
    }
  }

  /// Sets a notification for a specific habit
  void setHabitNotification(int id, TimeOfDay time, String title, String desc) {
    // Delegate to global notification function
    notifications.setHabitNotification(id, time, title, desc);
  }

  /// Disables notification for a specific habit
  void disableHabitNotification(int id) {
    // Delegate to global notification function
    notifications.disableHabitNotification(id);
  }

  /// Handles notification rescheduling when a habit event is added
  /// If a habit is marked as completed today, reschedule notification for tomorrow
  void handleHabitEventAdded(int habitId, DateTime eventDate, List event) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDateOnly =
        DateTime(eventDate.year, eventDate.month, eventDate.day);

    if (eventDateOnly == today &&
        event.isNotEmpty &&
        event[0] == DayType.check) {
      notifications.rescheduleNotificationForTomorrow(habitId);
    }
  }

  /// Handles notification rescheduling when a habit event is deleted
  /// If an event is deleted for today, reschedule notification for today
  void handleHabitEventDeleted(int habitId, DateTime eventDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDateOnly =
        DateTime(eventDate.year, eventDate.month, eventDate.day);

    if (eventDateOnly == today) {
      notifications.rescheduleNotificationForToday(habitId);
    }
  }
}
