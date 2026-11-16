import AppIntents
import WidgetKit

/// Runs when the check-in widget's button is tapped, without opening Habo.
///
/// Records the resulting state for today as a pending action (the app
/// applies it on next launch/resume), adjusts today's reminder, and reloads
/// every Habo widget so they all show the tap at once.
struct HabitTapIntent: AppIntent {
    static var title: LocalizedStringResource = "Check habit"
    static var isDiscoverable = false

    @Parameter(title: "Habit")
    var habitUUID: String

    init() {}

    init(habitUUID: String) {
        self.habitUUID = habitUUID
    }

    func perform() async throws -> some IntentResult {
        guard let defaults = sharedDefaults,
              let snapshot = Snapshot.load(from: defaults),
              let habit = snapshot.habit(uuid: habitUUID)
        else { return .result() }

        let today = LocalDate(Date())
        let store = PendingActionStore(store: defaults)
        let pending = store.pending()
        let current = effectiveCode(habit: habit, on: today, pending: pending)
        let value = effectiveTodayValue(habit: habit, today: today, snapshotDate: snapshot.date, pending: pending)
        let target = effectiveTodayTarget(habit: habit, today: today, snapshotDate: snapshot.date)
        let next = nextState(for: habit, current: current, currentValue: value, target: target)

        store.append(uuid: habit.uuid, date: today, code: next.code, value: next.value, target: next.target, at: Date(), from: current)
        // Ask for the reload before awaiting the notification center, so the
        // other widgets' refresh isn't held back by a slow reminder update.
        reloadAllHaboWidgets()
        await ReminderAdjuster.adjust(
            habitId: habit.id,
            reminder: habit.reminder,
            becameDone: !current.isDone && next.code.isDone,
            becameUndone: current.isDone && !next.code.isDone
        )
        return .result()
    }
}
