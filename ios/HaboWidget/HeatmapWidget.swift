import SwiftUI
import WidgetKit

/// Medium widget: the current calendar year for one habit as a GitHub-style
/// strip, each month its own block with a gap and a label.
struct HeatmapWidget: Widget {
    let kind = HaboWidgetKind.heatmap

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectHabitIntent.self, provider: HabitTimelineProvider()) { entry in
            HeatmapWidgetView(entry: entry)
                .haboWidgetBackground()
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
        let year = entry.today.year
        let blocks = yearGrid(year: year, weekStart: snapshot.weekStart)
        var codes: [LocalDate: DayCode] = [:]
        for block in blocks {
            for date in block.columns.joined().compactMap({ $0 }) where date <= entry.today {
                codes[date] = effectiveCode(habit: habit, on: date, pending: entry.pending)
            }
        }
        let doneDays = codes.values.filter(\.isDone).count
        let currentStreak = streak(habit: habit, today: entry.today, snapshotDate: snapshot.date, pending: entry.pending)

        return VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(habit.title)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .layoutPriority(1)
                Text(String(year))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize()
                Spacer(minLength: 4)
                Text("🔥 \(currentStreak)  ✓ \(doneDays)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize()
            }
            YearStrip(blocks: blocks, codes: codes, today: entry.today, monthLabels: snapshot.labels.months)
        }
    }
}

/// The 12 month blocks. Cell size is derived from the space available so
/// the whole year always fits; nothing is ever cropped.
struct YearStrip: View {
    let blocks: [MonthBlock]
    let codes: [LocalDate: DayCode]
    let today: LocalDate
    let monthLabels: [String]

    private let monthGap: CGFloat = 4
    private let labelHeight: CGFloat = 11

    private struct Layout {
        let cell: CGFloat
        let spacing: CGFloat
        let origins: [CGFloat] // x of each block
        let top: CGFloat // vertical offset that centres the strip
    }

    private func layout(in size: CGSize) -> Layout {
        let totalColumns = CGFloat(blocks.reduce(0) { $0 + $1.columns.count })
        let innerGaps = CGFloat(blocks.reduce(0) { $0 + max($1.columns.count - 1, 0) })
        let gaps = monthGap * CGFloat(blocks.count - 1)
        // Spacing between cells is a fixed fraction of the cell size.
        let ratio: CGFloat = 0.2
        let byWidth = (size.width - gaps) / (totalColumns + innerGaps * ratio)
        let byHeight = (size.height - labelHeight) / (7 + 6 * ratio)
        let cell = max(1, min(byWidth, byHeight))
        let spacing = cell * ratio
        var x: CGFloat = 0
        var origins: [CGFloat] = []
        for block in blocks {
            origins.append(x)
            x += CGFloat(block.columns.count) * cell + CGFloat(max(block.columns.count - 1, 0)) * spacing + monthGap
        }
        let height = labelHeight + 7 * cell + 6 * spacing
        return Layout(cell: cell, spacing: spacing, origins: origins, top: max(0, (size.height - height) / 2))
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

    private func color(for code: DayCode?) -> Color {
        switch code {
        case .check?, .progressDone?: return HaboPalette.primary
        case .fail?: return HaboPalette.red
        case .skip?: return HaboPalette.skip
        case .progress?: return HaboPalette.progress
        case .none?: return HaboPalette.grey.opacity(0.3)
        case nil: return HaboPalette.grey.opacity(0.1) // future
        }
    }

    /// Done cells go on the accent layer so they stay distinct when the
    /// home screen is tinted; everything else on the base layer.
    private func draw(in context: GraphicsContext, layout: Layout, accent: Bool) {
        let radius = layout.cell * 0.25
        for (index, block) in blocks.enumerated() {
            let x0 = layout.origins[index]
            if !accent, index < monthLabels.count {
                context.draw(
                    Text(monthLabels[block.month - 1]).font(.system(size: 8)).foregroundStyle(.secondary),
                    at: CGPoint(x: x0, y: layout.top),
                    anchor: .topLeading
                )
            }
            for (column, slots) in block.columns.enumerated() {
                for (row, slot) in slots.enumerated() {
                    guard let date = slot else { continue }
                    let code = codes[date]
                    let isDone = code?.isDone ?? false
                    guard isDone == accent else { continue }
                    let rect = CGRect(
                        x: x0 + CGFloat(column) * (layout.cell + layout.spacing),
                        y: layout.top + labelHeight + CGFloat(row) * (layout.cell + layout.spacing),
                        width: layout.cell,
                        height: layout.cell
                    )
                    let path = Path(roundedRect: rect, cornerRadius: radius)
                    context.fill(path, with: .color(color(for: code)))
                    if date == today {
                        context.stroke(path, with: .style(.primary), lineWidth: max(1, layout.cell * 0.18))
                    }
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
