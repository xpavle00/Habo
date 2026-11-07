import Foundation

private func latest(_ pending: [PendingAction], uuid: String, date: LocalDate) -> PendingAction? {
    pending.filter { $0.uuid == uuid && $0.date == date }.max { $0.seq < $1.seq }
}

/// The state widgets show for `habit` on `date`: the newest pending tap,
/// else the app's snapshot.
public func effectiveCode(habit: SnapshotHabit, on date: LocalDate, pending: [PendingAction]) -> DayCode {
    latest(pending, uuid: habit.uuid, date: date)?.code ?? habit.code(on: date)
}

/// Today's numeric progress, including pending taps.
public func effectiveTodayValue(habit: SnapshotHabit, today: LocalDate, snapshotDate: LocalDate, pending: [PendingAction]) -> Double {
    if let action = latest(pending, uuid: habit.uuid, date: today) {
        if let value = action.value { return value }
        return action.code.isDone ? (habit.today?.target ?? habit.target) : 0
    }
    guard today == snapshotDate else { return 0 }
    return habit.today?.value ?? 0
}

/// Target for today's numeric progress.
public func effectiveTodayTarget(habit: SnapshotHabit, today: LocalDate, snapshotDate: LocalDate) -> Double {
    today == snapshotDate ? (habit.today?.target ?? habit.target) : habit.target
}

/// The state a tap on the check-in widget moves to.
///
/// Boolean: done -> cleared, anything else -> checked.
/// Numeric: adds the habit's partial value; done once it reaches the target.
public func nextState(for habit: SnapshotHabit, current: DayCode, currentValue: Double?, target: Double? = nil) -> (code: DayCode, value: Double?, target: Double?) {
    if habit.isNumeric {
        let goal = target ?? habit.today?.target ?? habit.target
        let value = (currentValue ?? 0) + habit.partial
        return (value >= goal ? .progressDone : .progress, value, goal)
    }
    return (current == .check ? .none : .check, nil, nil)
}

/// Current streak shown on widgets, from the app's precomputed table.
public func streak(habit: SnapshotHabit, today: LocalDate, snapshotDate: LocalDate, pending: [PendingAction]) -> Int {
    let table = habit.streak
    let snapshotDayDone = effectiveCode(habit: habit, on: snapshotDate, pending: pending).isDone ? 1 : 0
    if today == snapshotDate {
        return table.today[safe: snapshotDayDone] ?? 0
    }
    let row = table.tomorrow[safe: snapshotDayDone] ?? []
    if today == snapshotDate.adding(days: 1) {
        let todayDone = effectiveCode(habit: habit, on: today, pending: pending).isDone ? 1 : 0
        return row[safe: todayDone] ?? 0
    }
    return row[safe: 0] ?? 0
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
