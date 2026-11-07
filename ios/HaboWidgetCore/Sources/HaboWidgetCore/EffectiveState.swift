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

/// Current streak shown on widgets.
///
/// Up to the day after the snapshot it comes from the app's precomputed
/// table. Beyond that the app hasn't run, so it is carried forward day by
/// day over the widget's own taps, following the app's streak rules: a done
/// day extends the run (restarting at 1 after a day with nothing logged),
/// skip and partial progress hold it, and a fail ends it (with the two-day
/// rule, only a second fail in a row does).
public func streak(habit: SnapshotHabit, today: LocalDate, snapshotDate: LocalDate, pending: [PendingAction]) -> Int {
    let table = habit.streak
    func code(_ date: LocalDate) -> DayCode { effectiveCode(habit: habit, on: date, pending: pending) }

    let snapshotDayDone = code(snapshotDate).isDone ? 1 : 0
    if today <= snapshotDate {
        return table.today[safe: snapshotDayDone] ?? 0
    }
    let tomorrow = snapshotDate.adding(days: 1)
    let row = table.tomorrow[safe: snapshotDayDone] ?? []
    var current = row[safe: code(tomorrow).isDone ? 1 : 0] ?? 0
    var previous = code(tomorrow)
    var day = tomorrow.adding(days: 1)
    let twoDayRule = habit.twoDayRule ?? false
    while day <= today {
        let dayCode = code(day)
        switch dayCode {
        case .check, .progressDone:
            current = previous == .none ? 1 : current + 1
        case .fail:
            if !twoDayRule || previous == .fail { current = 0 }
        case .skip, .progress, .none:
            break
        }
        previous = dayCode
        day = day.adding(days: 1)
    }
    return current
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
