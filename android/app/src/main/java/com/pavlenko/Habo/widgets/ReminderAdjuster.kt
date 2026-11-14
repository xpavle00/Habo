package com.pavlenko.Habo.widgets

import android.content.Context
import android.util.Log
import me.carda.awesome_notifications.AwesomeNotificationsFlutterExtension
import me.carda.awesome_notifications.core.AwesomeNotifications
import me.carda.awesome_notifications.core.models.NotificationCalendarModel
import me.carda.awesome_notifications.core.models.NotificationModel
import java.time.LocalDate

/**
 * Keeps a habit's reminder in step with widget taps, mirroring
 * `rescheduleNotificationForTomorrow/Today` in lib/notifications.dart (and
 * ReminderAdjuster.swift on iOS).
 *
 * Habo schedules reminders with awesome_notifications, using the habit's
 * database id as the notification id. The existing schedule is copied and
 * replaced under the same id, so its title, body and channel stay the
 * app's. If anything fails this is a no-op, and the app reschedules when it
 * next drains the tap.
 */
object ReminderAdjuster {
    private const val TAG = "HaboReminderAdjuster"

    fun adjust(context: Context, habitId: Int?, reminder: Reminder?, becameDone: Boolean, becameUndone: Boolean) {
        if (habitId == null || reminder == null || !(becameDone || becameUndone)) return
        try {
            // Widget taps can start the process without the Flutter engine.
            AwesomeNotificationsFlutterExtension.initialize()
            val awesome = AwesomeNotifications(context)
            val existing = awesome.listAllPendingSchedules().firstOrNull { it.content?.id == habitId } ?: return
            val schedule = existing.schedule as? NotificationCalendarModel ?: return

            val calendar = NotificationCalendarModel().fromMap(schedule.toMap())
            if (becameDone) {
                // Done today: the next reminder is tomorrow.
                val tomorrow = LocalDate.now().plusDays(1)
                calendar.year = tomorrow.year
                calendar.month = tomorrow.monthValue
                calendar.day = tomorrow.dayOfMonth
            } else {
                // Undone today: back to the daily reminder, which still fires
                // today if its time hasn't passed.
                calendar.year = null
                calendar.month = null
                calendar.day = null
            }
            calendar.hour = reminder.hour
            calendar.minute = reminder.minute
            calendar.second = 0
            calendar.millisecond = 0
            calendar.repeats = true
            calendar.preciseAlarm = true

            val replacement = NotificationModel().fromMap(existing.toMap()) ?: return
            replacement.schedule = calendar
            awesome.createNotification(replacement, null)
        } catch (e: Exception) {
            Log.w(TAG, "Could not adjust reminder for habit $habitId", e)
        }
    }
}
