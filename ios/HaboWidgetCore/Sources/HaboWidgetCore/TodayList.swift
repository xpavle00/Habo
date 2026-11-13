import Foundation

/// Whether a habit needs nothing more today: done, failed or skipped.
/// Partial numeric progress still waits for more.
private func isHandled(_ code: DayCode) -> Bool {
    switch code {
    case .check, .progressDone, .fail, .skip: return true
    case .none, .progress: return false
    }
}

private let tapTimestamp: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.timeZone = TimeZone(identifier: "UTC")
    return formatter
}()

/// When the hold on a just-tapped row ends, or nil if `action` isn't a
/// widget tap for `today` that handled its habit.
private func holdEnd(_ action: PendingAction, today: LocalDate, hold: TimeInterval) -> Date? {
    guard action.date == today, isHandled(action.code),
          let tapped = tapTimestamp.date(from: action.at) else { return nil }
    return tapped.addingTimeInterval(hold)
}

/// The habits the large "today" list shows, in app order.
///
/// When everything fits, every habit keeps its row all day. With more
/// habits than rows, handled ones give up their row so the list shows what
/// is still waiting; handled habits fill any rows left over. A habit handled
/// by a widget tap keeps its row for `hold` seconds, so the next habit
/// doesn't slide under the finger that just tapped.
///
/// - Parameter habits: all habits, already in app order.
public func todayListHabits(
    habits: [SnapshotHabit],
    today: LocalDate,
    pending: [PendingAction],
    now: Date,
    capacity: Int,
    hold: TimeInterval
) -> [SnapshotHabit] {
    guard habits.count > capacity else { return habits }

    var held = Set<String>()
    for action in pending {
        // Only the newest tap for a habit counts.
        let newest = pending.filter { $0.uuid == action.uuid && $0.date == today }.max { $0.seq < $1.seq }
        if newest?.seq == action.seq, let end = holdEnd(action, today: today, hold: hold), end > now {
            held.insert(action.uuid)
        }
    }

    func waits(_ habit: SnapshotHabit) -> Bool {
        held.contains(habit.uuid) || !isHandled(effectiveCode(habit: habit, on: today, pending: pending))
    }

    let waiting = habits.filter(waits)
    if waiting.count >= capacity { return Array(waiting.prefix(capacity)) }

    let fillers = habits.filter { !waits($0) }.prefix(capacity - waiting.count)
    let chosen = Set(waiting.map(\.uuid)).union(fillers.map(\.uuid))
    return habits.filter { chosen.contains($0.uuid) }
}

/// Future moments at which a held row is released, soonest first. The
/// widget needs a timeline entry at each so the list reorders by itself.
public func todayListReleaseDates(
    pending: [PendingAction],
    today: LocalDate,
    now: Date,
    hold: TimeInterval
) -> [Date] {
    pending.compactMap { holdEnd($0, today: today, hold: hold) }.filter { $0 > now }.sorted()
}
