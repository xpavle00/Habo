import SwiftUI
import WidgetKit

/// Colours from the app's `HaboColors` (lib/constants.dart).
enum HaboPalette {
    static let primary = Color(red: 0x09 / 255, green: 0xBF / 255, blue: 0x30 / 255)
    static let red = Color(red: 0xF4 / 255, green: 0x43 / 255, blue: 0x36 / 255)
    static let skip = Color(red: 0xFB / 255, green: 0xC0 / 255, blue: 0x2D / 255)
    static let progress = Color(red: 0x21 / 255, green: 0x96 / 255, blue: 0xF3 / 255)
    /// Flutter `Colors.red[300]`, the app's weekend day number.
    static let weekend = Color(red: 0xE5 / 255, green: 0x73 / 255, blue: 0x73 / 255)
    /// Flutter `Colors.grey`.
    static let grey = Color(red: 0x9E / 255, green: 0x9E / 255, blue: 0x9E / 255)
}

/// What every Habo widget renders: the app's snapshot plus pending taps,
/// evaluated for the entry's own day.
struct HaboEntry: TimelineEntry {
    let date: Date
    let snapshot: Snapshot?
    let pending: [PendingAction]
    /// Selected habit for per-habit widgets; nil for the Today widget.
    let habitUUID: String?

    var today: LocalDate { LocalDate(date) }

    var habit: SnapshotHabit? {
        guard let habitUUID else { return nil }
        return snapshot?.habit(uuid: habitUUID)
    }
}

enum SnapshotTimeline {
    static func currentEntry(habitUUID: String?, at date: Date = Date()) -> HaboEntry {
        let defaults = sharedDefaults
        return HaboEntry(
            date: date,
            snapshot: defaults.flatMap { Snapshot.load(from: $0) },
            pending: defaults.map { PendingActionStore(store: $0).pending() } ?? [],
            habitUUID: habitUUID
        )
    }

    /// An entry now and one at the next local midnight, so "today" (and the
    /// year, on 1 January) rolls over without the app running.
    static func timeline(habitUUID: String?) -> Timeline<HaboEntry> {
        let now = Date()
        let calendar = Calendar.current
        let midnight = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now))!
        let entries = [
            currentEntry(habitUUID: habitUUID, at: now),
            currentEntry(habitUUID: habitUUID, at: midnight),
        ]
        return Timeline(entries: entries, policy: .atEnd)
    }
}

/// Provider for widgets configured with a habit.
struct HabitTimelineProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> HaboEntry {
        PreviewData.entry(habitUUID: PreviewData.water.uuid)
    }

    func snapshot(for configuration: SelectHabitIntent, in context: Context) async -> HaboEntry {
        if context.isPreview, sharedDefaults.flatMap({ Snapshot.load(from: $0) }) == nil {
            return PreviewData.entry(habitUUID: PreviewData.water.uuid)
        }
        return SnapshotTimeline.currentEntry(habitUUID: await resolvedUUID(configuration))
    }

    func timeline(for configuration: SelectHabitIntent, in context: Context) async -> Timeline<HaboEntry> {
        SnapshotTimeline.timeline(habitUUID: await resolvedUUID(configuration))
    }

    /// Selected habit, else the first habit (matches the picker's default).
    private func resolvedUUID(_ configuration: SelectHabitIntent) async -> String? {
        if let id = configuration.habit?.id { return id }
        return await HabitEntityQuery().defaultResult()?.id
    }
}

/// Small text shown when a widget has nothing to render.
struct WidgetMessage: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    /// Applies the system widget background.
    func haboWidgetBackground() -> some View {
        containerBackground(.fill.tertiary, for: .widget)
    }
}

func habitURL(_ uuid: String) -> URL {
    URL(string: "habo://habit/\(uuid)")!
}

let openAppURL = URL(string: "habo://open")!
