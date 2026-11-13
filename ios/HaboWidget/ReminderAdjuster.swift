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

        let calendar = Calendar.current
        let now = Date()
        var day = calendar.startOfDay(for: now)
        if becameDone {
            // Done today: next reminder is tomorrow.
            day = calendar.date(byAdding: .day, value: 1, to: day)!
        } else {
            // Undone today: restore today's reminder if its time hasn't passed.
            guard let fire = calendar.date(bySettingHour: reminder.hour, minute: reminder.minute, second: 0, of: now),
                  fire > now else { return }
        }
        var components = calendar.dateComponents([.year, .month, .day], from: day)
        components.hour = reminder.hour
        components.minute = reminder.minute
        components.second = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: existing.content, trigger: trigger)
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        try? await center.add(request)
    }
}
