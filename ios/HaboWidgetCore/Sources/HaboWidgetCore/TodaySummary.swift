import Foundation

/// Counts for the "Habits today" ring. Same rules as the Flutter
/// `HomeWidgetHelper.getTodayData`: numeric below target counts as nothing.
public struct TodaySummary: Equatable, Sendable {
    public let total: Int
    public let completed: Int
    public let skipped: Int
    public let failed: Int

    public init(total: Int, completed: Int, skipped: Int, failed: Int) {
        self.total = total
        self.completed = completed
        self.skipped = skipped
        self.failed = failed
    }

    /// The ring's centre number: completed + skipped + failed.
    public var done: Int { completed + skipped + failed }
    public var allDone: Bool { total > 0 && done == total }
}

public func todaySummary(habits: [SnapshotHabit], today: LocalDate, pending: [PendingAction]) -> TodaySummary {
    var completed = 0, skipped = 0, failed = 0
    for habit in habits {
        switch effectiveCode(habit: habit, on: today, pending: pending) {
        case .check, .progressDone: completed += 1
        case .skip: skipped += 1
        case .fail: failed += 1
        case .none, .progress: break
        }
    }
    return TodaySummary(total: habits.count, completed: completed, skipped: skipped, failed: failed)
}
