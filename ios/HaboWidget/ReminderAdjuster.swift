import Foundation
import UserNotifications

/// Keeps a habit's reminder in step with widget taps, mirroring
/// `NotificationService.handleHabitEventAdded/Deleted` in the app.
///
/// Habo schedules reminders with awesome_notifications, which uses the
/// habit's database id as the request identifier. awesome drops its own
/// schedule record if no pending request carries that identifier, so the
/// request is always replaced under the same identifier, never just removed.
/// If the extension cannot see the app's pending requests, this is a no-op
/// and the app reschedules when it next drains the tap.
enum ReminderAdjuster {
    static func adjust(habitId: Int?, reminder: Reminder?, becameDone: Bool, becameUndone: Bool) async {
        guard let habitId, let reminder, becameDone || becameUndone else { return }
        let center = UNUserNotificationCenter.current()
        let identifier = String(habitId)
        let requests = await center.pendingNotificationRequests()
        guard let existing = requests.first(where: { $0.identifier == identifier }) else { return }

        let schedule = reminderSchedule(for: reminder, becameDone: becameDone, now: Date(), calendar: .current)
        let trigger = UNCalendarNotificationTrigger(dateMatching: schedule.components, repeats: schedule.repeats)
        let request = UNNotificationRequest(identifier: identifier, content: existing.content, trigger: trigger)
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        try? await center.add(request)
    }
}
