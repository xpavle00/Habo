import AppIntents
import WidgetKit

/// A habit the user can pick in "Edit Widget". Backed by the app's snapshot.
struct HabitEntity: AppEntity {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Habit")
    static var defaultQuery = HabitEntityQuery()

    let id: String
    let title: String

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }
}

struct HabitEntityQuery: EntityQuery {
    private func snapshot() -> Snapshot? {
        guard let defaults = sharedDefaults else { return nil }
        return Snapshot.load(from: defaults)
    }

    private func habits() -> [SnapshotHabit] {
        snapshot()?.habits ?? []
    }

    /// Keeps ids of deleted/archived habits (with a placeholder title) so the
    /// widget shows "choose a habit" rather than switching to another habit.
    func entities(for identifiers: [HabitEntity.ID]) async throws -> [HabitEntity] {
        let snapshot = snapshot()
        return resolveHabitEntities(
            ids: identifiers,
            habits: snapshot?.habits ?? [],
            missingTitle: snapshot?.labels.chooseHabit ?? "Choose a habit"
        ).map { HabitEntity(id: $0.id, title: $0.title) }
    }

    func suggestedEntities() async throws -> [HabitEntity] {
        habits().map { HabitEntity(id: $0.uuid, title: $0.title) }
    }

    /// First habit by position, so a freshly added widget shows something.
    func defaultResult() async -> HabitEntity? {
        habits().first.map { HabitEntity(id: $0.uuid, title: $0.title) }
    }
}

/// Configuration shared by the check-in and heatmap widgets.
struct SelectHabitIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Choose habit"
    static var description = IntentDescription("The habit this widget shows.")

    @Parameter(title: "Habit")
    var habit: HabitEntity?

    init() {}

    init(habit: HabitEntity?) {
        self.habit = habit
    }
}
