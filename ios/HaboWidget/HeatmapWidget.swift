import SwiftUI
import WidgetKit

/// Medium widget: the current calendar year for one habit, one row per month.
struct HeatmapWidget: Widget {
    let kind = HaboWidgetKind.heatmap

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectHabitIntent.self, provider: HabitTimelineProvider()) { entry in
            HeatmapWidgetView(entry: entry)
                .haboWidgetBackground(entry)
        }
        .configurationDisplayName("Habit year")
        .description("A habit's whole year at a glance.")
        .supportedFamilies([.systemMedium])
    }
}

struct HeatmapWidgetView: View {
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
        let year = entry.today.year
        var codes: [LocalDate: DayCode] = [:]
        var date = LocalDate(year: year, month: 1, day: 1)
        while date <= entry.today {
            codes[date] = effectiveCode(habit: habit, on: date, pending: entry.pending)
            date = date.adding(days: 1)
        }
        let doneDays = codes.values.filter(\.isDone).count
        let currentStreak = streak(habit: habit, today: entry.today, snapshotDate: snapshot.date, pending: entry.pending)

        return VStack(alignment: .leading, spacing: 8) {
            HabitHeader(title: habit.title, streak: currentStreak) {
                Text(String(year))
                    .font(HaboFont.bold(12))
                    .foregroundStyle(.secondary)
                    .fixedSize()
                Spacer(minLength: 4)
                HStack(spacing: 3) {
                    MaterialIcon.check.frame(width: 13, height: 13)
                    Text("\(doneDays)").font(HaboFont.bold(12))
                }
                .foregroundStyle(.secondary)
                .fixedSize()
            }
            YearGridView(year: year, codes: codes, today: entry.today, monthLabels: snapshot.labels.months)
        }
    }
}

/// The whole year as a "year in pixels" grid: one row per month, one column
/// per day of the month. This shape fits a medium widget far better than a
/// 53-week strip, so the day tiles come out about twice as large.
struct YearGridView: View {
    let year: Int
    let codes: [LocalDate: DayCode]
    let today: LocalDate
    let monthLabels: [String]
    @Environment(\.widgetRenderingMode) private var renderingMode

    private let labelWidth: CGFloat = 11

    private struct Layout {
        let cell: CGFloat
        let pitchX: CGFloat
        let pitchY: CGFloat
        let top: CGFloat
    }

    private func layout(in size: CGSize) -> Layout {
        let pitchY = size.height / 12
        // Columns may breathe a little more than rows, but tiles stay square.
        let pitchX = min((size.width - labelWidth) / 31, pitchY * 1.2)
        let cell = max(1, min(pitchX, pitchY) * 0.84)
        return Layout(cell: cell, pitchX: pitchX, pitchY: pitchY, top: (pitchY - cell) / 2)
    }

    var body: some View {
        GeometryReader { proxy in
            let layout = layout(in: proxy.size)
            ZStack(alignment: .topLeading) {
                Canvas { context, _ in draw(in: context, layout: layout, accent: false) }
                Canvas { context, _ in draw(in: context, layout: layout, accent: true) }
                    .widgetAccentable()
            }
        }
    }

    /// Done tiles go on the accent layer so they stay distinct when the
    /// home screen is tinted; everything else on the base layer.
    private func draw(in context: GraphicsContext, layout: Layout, accent: Bool) {
        let radius = layout.cell * 0.3
        for month in 1...12 {
            let y = CGFloat(month - 1) * layout.pitchY + layout.top
            if !accent, month <= monthLabels.count {
                context.draw(
                    Text(String(monthLabels[month - 1].prefix(1)))
                        .font(HaboFont.bold(min(8, layout.pitchY)))
                        .foregroundStyle(.secondary),
                    at: CGPoint(x: 0, y: y + layout.cell / 2),
                    anchor: .leading
                )
            }
            for day in 1...LocalDate.daysInMonth(year: year, month: month) {
                let date = LocalDate(year: year, month: month, day: day)
                let code = codes[date]
                guard (code?.isDone ?? false) == accent else { continue }
                let rect = CGRect(
                    x: labelWidth + CGFloat(day - 1) * layout.pitchX,
                    y: y,
                    width: layout.cell,
                    height: layout.cell
                )
                let path = Path(roundedRect: rect, cornerRadius: radius, style: .continuous)
                context.fill(path, with: .color(DayCode.tileColor(code, accented: renderingMode.isAccented)))
                if date == today {
                    context.stroke(path, with: .style(.primary), lineWidth: max(1, layout.cell * 0.16))
                }
            }
        }
    }
}

#Preview("Heatmap", as: .systemMedium) {
    HeatmapWidget()
} timeline: {
    PreviewData.entry(habitUUID: PreviewData.water.uuid)
    PreviewData.entry(habitUUID: PreviewData.read.uuid, todayCode: "P")
    PreviewData.entry(habitUUID: PreviewData.longTitle.uuid, weekStart: 7)
    PreviewData.entry(habitUUID: "deleted")
}
