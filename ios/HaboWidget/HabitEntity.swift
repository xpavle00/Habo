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
    private func habits() -> [SnapshotHabit] {
        guard let defaults = sharedDefaults else { return [] }
        return Snapshot.load(from: defaults)?.habits ?? []
    }

    func entities(for identifiers: [HabitEntity.ID]) async throws -> [HabitEntity] {
        let all = habits()
        return identifiers.compactMap { id in
            all.first { $0.uuid == id }.map { HabitEntity(id: $0.uuid, title: $0.title) }
        }
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
