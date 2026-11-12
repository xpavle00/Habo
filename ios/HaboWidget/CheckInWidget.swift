import AppIntents
import SwiftUI
import WidgetKit

/// Small widget for one habit: tap the button to check it (or add progress)
/// without opening Habo. Tapping elsewhere opens the app.
struct CheckInWidget: Widget {
    let kind = HaboWidgetKind.checkIn

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectHabitIntent.self, provider: HabitTimelineProvider()) { entry in
            CheckInWidgetView(entry: entry)
                .haboWidgetBackground(entry)
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
                    .widgetURL(openAppURL)
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

        return VStack(spacing: 0) {
            HabitHeader(title: habit.title, streak: currentStreak)
            Spacer(minLength: 4)
            Button(intent: HabitTapIntent(habitUUID: habit.uuid)) {
                CheckTile(habit: habit, code: code, value: value, target: target, today: entry.today)
            }
            .buttonStyle(.plain)
            Spacer(minLength: 4)
            Group {
                if habit.isNumeric {
                    Text("\(format(value)) / \(format(target)) \(habit.unit)")
                        .font(HaboFont.bold(12))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                } else {
                    RecentDays(habit: habit, today: entry.today, pending: entry.pending)
                }
            }
            .frame(height: 14)
        }
    }
}

/// The big tap target: the app's day button. Unchecked it shows the day of
/// the month (weekends in red, as in the app); otherwise it is filled with
/// today's state colour and icon. Numeric habits in progress show the app's
/// white progress ring with the percentage inside.
struct CheckTile: View {
    let habit: SnapshotHabit
    let code: DayCode
    let value: Double
    let target: Double
    let today: LocalDate
    private let size: CGFloat = 68

    private var fraction: Double {
        target > 0 ? min(max(value / target, 0), 1) : 0
    }

    private var showsRing: Bool {
        habit.isNumeric && !code.isDone && code != .fail && code != .skip && value > 0
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.27, style: .continuous)
                .fill(fill)
                .widgetAccentable(isFilled)
            if showsRing {
                ring
            } else if let icon {
                icon
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
            } else {
                Text("\(today.day)")
                    .font(HaboFont.extraBold(30))
                    .foregroundStyle(today.isoWeekday > 5 ? HaboPalette.weekend : Color.primary)
            }
        }
        .frame(width: size, height: size)
        .contentShape(Rectangle())
    }

    private var ring: some View {
        ZStack {
            Circle().stroke(Color.white.opacity(0.3), lineWidth: 5)
            Circle()
                .trim(from: 0, to: fraction)
                .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int((fraction * 100).rounded()))%")
                .font(HaboFont.extraBold(13))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
                .padding(.horizontal, 8)
        }
        .frame(width: 48, height: 48)
    }

    /// Whether the tile carries a state colour (as opposed to "to do").
    private var isFilled: Bool { code != .none || showsRing }

    private var fill: Color {
        if showsRing { return HaboPalette.progress }
        return code == .none ? HaboPalette.grey.opacity(0.18) : DayCode.tileColor(code)
    }

    private var icon: MaterialIcon? {
        switch code {
        case .fail: return .close
        case .skip: return .lastPage
        case .check, .progressDone: return .check
        case .progress: return .add
        case .none: return nil
        }
    }
}

/// The six days before today as small tiles, oldest first.
struct RecentDays: View {
    let habit: SnapshotHabit
    let today: LocalDate
    let pending: [PendingAction]

    var body: some View {
        HStack(spacing: 4) {
            ForEach((1...6).reversed(), id: \.self) { back in
                let code = effectiveCode(habit: habit, on: today.adding(days: -back), pending: pending)
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(DayCode.tileColor(code))
                    .widgetAccentable(code.isDone)
                    .frame(width: 13, height: 13)
            }
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
