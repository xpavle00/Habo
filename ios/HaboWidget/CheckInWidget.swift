import AppIntents
import SwiftUI
import WidgetKit

/// Small widget for one habit: tap the button to check it (or add progress)
/// without opening Habo. Tapping elsewhere opens the habit.
struct CheckInWidget: Widget {
    let kind = HaboWidgetKind.checkIn

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectHabitIntent.self, provider: HabitTimelineProvider()) { entry in
            CheckInWidgetView(entry: entry)
                .haboWidgetBackground()
        }
        .configurationDisplayName("Habit check-in")
        .description("Check a habit right from your home screen.")
        .supportedFamilies([.systemSmall])
    }
}

struct CheckInWidgetView: View {
    let entry: HaboEntry

    var body: some View {
        if let snapshot = entry.snapshot {
            if let habit = entry.habit {
                content(habit: habit, snapshot: snapshot)
                    .widgetURL(habitURL(habit.uuid))
            } else {
                WidgetMessage(text: snapshot.habits.isEmpty ? snapshot.labels.noHabits : snapshot.labels.chooseHabit)
                    .widgetURL(openAppURL)
            }
        } else {
            WidgetMessage(text: "Add a habit in Habo")
                .widgetURL(openAppURL)
        }
    }

    private func content(habit: SnapshotHabit, snapshot: Snapshot) -> some View {
        let code = effectiveCode(habit: habit, on: entry.today, pending: entry.pending)
        let value = effectiveTodayValue(habit: habit, today: entry.today, snapshotDate: snapshot.date, pending: entry.pending)
        let target = effectiveTodayTarget(habit: habit, today: entry.today, snapshotDate: snapshot.date)
        let currentStreak = streak(habit: habit, today: entry.today, snapshotDate: snapshot.date, pending: entry.pending)

        return VStack(alignment: .leading, spacing: 4) {
            Text(habit.title)
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.tail)
            Text(currentStreak > 0 ? "🔥 \(currentStreak)" : " ")
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer(minLength: 0)
            HStack {
                Spacer(minLength: 0)
                Button(intent: HabitTapIntent(habitUUID: habit.uuid)) {
                    CheckButtonFace(habit: habit, code: code, value: value, target: target)
                }
                .buttonStyle(.plain)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            if habit.isNumeric {
                Text("\(format(value)) / \(format(target)) \(habit.unit)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

/// The big round tap target, showing today's state.
struct CheckButtonFace: View {
    let habit: SnapshotHabit
    let code: DayCode
    let value: Double
    let target: Double
    private let size: CGFloat = 64
    private let stroke: CGFloat = 6

    var body: some View {
        ZStack {
            if code.isDone {
                Circle().fill(HaboPalette.primary).widgetAccentable()
                Image(systemName: "checkmark")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
            } else if habit.isNumeric {
                Circle().stroke(HaboPalette.progress.opacity(0.25), lineWidth: stroke)
                Circle()
                    .trim(from: 0, to: target > 0 ? min(value / target, 1) : 0)
                    .stroke(HaboPalette.progress, style: StrokeStyle(lineWidth: stroke, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .widgetAccentable()
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(HaboPalette.progress)
            } else {
                Circle().stroke(stateColor, lineWidth: stroke).widgetAccentable()
                if let symbol = stateSymbol {
                    Image(systemName: symbol)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(stateColor)
                }
            }
        }
        .frame(width: size, height: size)
        .contentShape(Circle())
    }

    private var stateColor: Color {
        switch code {
        case .fail: return HaboPalette.red
        case .skip: return HaboPalette.skip
        default: return HaboPalette.primary
        }
    }

    private var stateSymbol: String? {
        switch code {
        case .fail: return "xmark"
        case .skip: return "arrow.uturn.right"
        default: return nil
        }
    }
}

func format(_ value: Double) -> String {
    value.rounded() == value ? String(Int(value)) : String(format: "%.1f", value)
}

#Preview("Check-in", as: .systemSmall) {
    CheckInWidget()
} timeline: {
    PreviewData.entry(habitUUID: PreviewData.water.uuid)
    PreviewData.entry(habitUUID: PreviewData.water.uuid, todayCode: "c")
    PreviewData.entry(habitUUID: PreviewData.read.uuid)
    PreviewData.entry(habitUUID: PreviewData.read.uuid, todayCode: "P")
    PreviewData.entry(habitUUID: PreviewData.longTitle.uuid)
    PreviewData.entry(habitUUID: "deleted")
}
