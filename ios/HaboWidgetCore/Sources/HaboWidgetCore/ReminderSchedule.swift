import Foundation

/// When a habit's reminder should fire after a widget tap.
///
/// Whenever possible this is the plain daily reminder (repeating, local
/// wall-clock time), so a widget tap never turns it into a one-off:
/// - undone today: daily, which still fires today if its time hasn't passed;
/// - done after today's reminder time: daily, whose next fire is tomorrow.
/// Only when done before today's reminder time does it have to skip today,
/// which a repeating trigger can't express; that is a one-off for tomorrow,
/// as the app's own reschedule does on iOS, and the app restores the daily
/// reminder when it next runs.
public func reminderSchedule(for reminder: Reminder, becameDone: Bool, now: Date, calendar: Calendar) -> (components: DateComponents, repeats: Bool) {
    var daily = DateComponents()
    daily.hour = reminder.hour
    daily.minute = reminder.minute
    daily.second = 0

    let todaysFire = calendar.date(bySettingHour: reminder.hour, minute: reminder.minute, second: 0, of: now)
    let stillAheadToday = todaysFire.map { $0 > now } ?? false
    guard becameDone, stillAheadToday,
          let tomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now))
    else {
        return (daily, true)
    }

    var once = calendar.dateComponents([.year, .month, .day], from: tomorrow)
    once.hour = reminder.hour
    once.minute = reminder.minute
    once.second = 0
    return (once, false)
}
