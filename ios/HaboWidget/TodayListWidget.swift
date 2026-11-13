import AppIntents
import SwiftUI
import WidgetKit

/// Large widget: today's habits as a list. Each row has the habit's name,
/// the previous days fading out, and today's button, which checks the habit
/// (or adds progress) without opening Habo.
struct TodayListWidget: Widget {
    let kind = HaboWidgetKind.todayList

    /// Rows that fit without crowding.
    static let capacity = 6
    /// How long a just-tapped row keeps its place before giving it up.
    static let hold: TimeInterval = 4

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TodayListProvider()) { entry in
            TodayListWidgetView(entry: entry)
                .haboWidgetBackground(entry)
        }
        .configurationDisplayName("Today's habits")
        .description("Check off today's habits from a list.")
        .supportedFamilies([.systemLarge])
    }
}

struct TodayListProvider: TimelineProvider {
    private var preview: HaboEntry { PreviewData.listEntry(codes: ["c", "p", ".", "f", ".", "s"]) }

    func placeholder(in context: Context) -> HaboEntry { preview }

    func getSnapshot(in context: Context, completion: @escaping (HaboEntry) -> Void) {
        let entry = SnapshotTimeline.currentEntry(habitUUID: nil)
        completion(context.isPreview && entry.snapshot == nil ? preview : entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HaboEntry>) -> Void) {
        completion(SnapshotTimeline.todayListTimeline())
    }
}

struct TodayListWidgetView: View {
    let entry: HaboEntry

    var body: some View {
        if let snapshot = entry.snapshot {
            if snapshot.habits.isEmpty {
                WidgetMessage(text: snapshot.labels.noHabits)
                    .widgetURL(openAppURL)
            } else {
                content(snapshot: snapshot)
                    .widgetURL(openAppURL)
            }
        } else {
            WidgetMessage(text: String(localized: "Open Habo to update this widget"))
                .widgetURL(openAppURL)
        }
    }

    private func content(snapshot: Snapshot) -> some View {
        let rows = todayListHabits(
            habits: snapshot.habits, today: entry.today, pending: entry.pending,
            now: entry.date, capacity: TodayListWidget.capacity, hold: TodayListWidget.hold
        )
        let summary = todaySummary(habits: snapshot.habits, today: entry.today, pending: entry.pending)

        return VStack(spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(snapshot.labels.habitsToday)
                    .font(HaboFont.extraBold(17))
                    .lineLimit(1)
                Text(entry.date, format: .dateTime.weekday(.abbreviated).day().month(.abbreviated))
                    .font(HaboFont.bold(12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                Spacer(minLength: 4)
                CountPill(text: "\(summary.done)/\(summary.total)")
                    .alignmentGuide(.firstTextBaseline) { $0[.bottom] - 5 }
            }
            .frame(height: 22)

            // Fixed row height: fewer habits leave space, they don't stretch.
            GeometryReader { proxy in
                let rowHeight = proxy.size.height / CGFloat(TodayListWidget.capacity)
                VStack(spacing: 0) {
                    ForEach(Array(rows.enumerated()), id: \.element.uuid) { index, habit in
                        TodayListRow(habit: habit, snapshot: snapshot, entry: entry)
                            .frame(height: rowHeight)
                            .overlay(alignment: .top) {
                                if index > 0 {
                                    Rectangle()
                                        .fill(HaboPalette.grey.opacity(0.25))
                                        .frame(height: 0.5)
                                }
                            }
                    }
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

/// One habit: name (and amount, for numeric habits), the five days before
/// today fading from oldest to newest, and today's button.
struct TodayListRow: View {
    let habit: SnapshotHabit
    let snapshot: Snapshot
    let entry: HaboEntry
    @Environment(\.widgetRenderingMode) private var renderingMode

    private static let history = 5

    var body: some View {
        let code = effectiveCode(habit: habit, on: entry.today, pending: entry.pending)
        let value = effectiveTodayValue(habit: habit, today: entry.today, snapshotDate: snapshot.date, pending: entry.pending)
        let target = effectiveTodayTarget(habit: habit, today: entry.today, snapshotDate: snapshot.date)

        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 0) {
                Text(habit.title)
                    .font(HaboFont.extraBold(15))
                    .lineLimit(1)
                    .truncationMode(.tail)
                if habit.isNumeric {
                    Text("\(format(value)) / \(format(target)) \(habit.unit)")
                        .font(HaboFont.bold(11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 3) {
                ForEach((1...Self.history).reversed(), id: \.self) { back in
                    let past = effectiveCode(habit: habit, on: entry.today.adding(days: -back), pending: entry.pending)
                    RoundedRectangle(cornerRadius: 3.5, style: .continuous)
                        .fill(DayCode.tileColor(past, accented: renderingMode.isAccented))
                        .widgetAccentable(past.isDone)
                        .frame(width: 11, height: 11)
                        // Oldest faintest, yesterday full strength.
                        .opacity(1 - Double(back - 1) * 0.175)
                }
            }

            Button(intent: HabitTapIntent(habitUUID: habit.uuid)) {
                CheckTile(habit: habit, code: code, value: value, target: target, today: entry.today, size: 36)
                    // A taller target than the tile itself.
                    .frame(width: 40, height: 44)
            }
            .buttonStyle(.plain)
        }
    }
}

/// The green pill from the app's habit header, with free text.
struct CountPill: View {
    let text: String
    @Environment(\.widgetRenderingMode) private var renderingMode

    private var label: some View {
        Text(text)
            .font(HaboFont.bold(13))
            .padding(.horizontal, 9)
            .frame(minWidth: 28, minHeight: 20)
    }

    var body: some View {
        if renderingMode.isAccented {
            label
                .hidden()
                .background(Capsule().fill(Color.white))
                .knockout { label }
                .widgetAccentable()
                .fixedSize()
        } else {
            label
                .foregroundStyle(.white)
                .background(Capsule().fill(HaboPalette.primary).widgetAccentable())
                .fixedSize()
        }
    }
}

#Preview("Today list", as: .systemLarge) {
    TodayListWidget()
} timeline: {
    PreviewData.listEntry(codes: ["c", "p", ".", "f", ".", "s"])
    PreviewData.listEntry(codes: [".", "."])
    PreviewData.listEntry(codes: ["c", "c", ".", "c", ".", ".", ".", "."])
}
