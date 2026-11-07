import SwiftUI
import WidgetKit

/// "Habits today" ring. Visual port of the Flutter `HaboHomeWidget` /
/// `CircularProgressPainter` — the look must not change.
struct TodayWidget: Widget {
    // Same kind as the original widget so placed widgets keep working.
    let kind = HaboWidgetKind.today

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TodayProvider()) { entry in
            TodayWidgetView(entry: entry)
                .haboWidgetBackground()
        }
        .configurationDisplayName("Habo Habits")
        .description("Track your daily habit progress")
        .supportedFamilies([.systemSmall])
    }
}

struct TodayProvider: TimelineProvider {
    func placeholder(in context: Context) -> HaboEntry { PreviewData.entry(habitUUID: nil) }

    func getSnapshot(in context: Context, completion: @escaping (HaboEntry) -> Void) {
        let entry = SnapshotTimeline.currentEntry(habitUUID: nil)
        completion(context.isPreview && entry.snapshot == nil ? PreviewData.entry(habitUUID: nil) : entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HaboEntry>) -> Void) {
        completion(SnapshotTimeline.timeline(habitUUID: nil))
    }
}

struct TodayWidgetView: View {
    let entry: HaboEntry
    @Environment(\.colorScheme) private var colorScheme

    private var textColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.92) : Color.black.opacity(0.85)
    }

    var body: some View {
        let summary = entry.snapshot.map {
            todaySummary(habits: $0.habits, today: entry.today, pending: entry.pending)
        } ?? TodaySummary(total: 0, completed: 0, skipped: 0, failed: 0)
        let title = entry.snapshot?.labels.habitsToday ?? "Habits today"

        // Laid out in the Flutter widget's 170pt coordinate space, then scaled.
        GeometryReader { proxy in
            let scale = min(proxy.size.width, proxy.size.height) / 170
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundStyle(textColor)
                    .lineLimit(1)
                ZStack {
                    TodayRing(summary: summary)
                        .frame(width: 130, height: 130)
                    if summary.allDone {
                        Image(systemName: "checkmark")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundStyle(HaboPalette.primary)
                            .widgetAccentable()
                    } else {
                        Text("\(summary.done)/\(summary.total)")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(textColor)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .frame(width: 100)
                    }
                }
            }
            .frame(width: 170, height: 170)
            .scaleEffect(scale)
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .widgetURL(openAppURL)
    }
}

/// Segmented ring: grey background, then skipped, completed and failed
/// arcs from 12 o'clock, each overlapping the previous (as in Flutter).
struct TodayRing: View {
    let summary: TodaySummary
    private let stroke: CGFloat = 12

    var body: some View {
        if summary.total == 0 {
            Color.clear
        } else {
            let segment = 1.0 / Double(summary.total)
            ZStack {
                Circle()
                    .inset(by: stroke / 2)
                    .stroke(HaboPalette.grey.opacity(0.3), style: StrokeStyle(lineWidth: stroke, lineCap: .butt))
                if summary.skipped > 0 {
                    arc(Double(summary.done) * segment, HaboPalette.primary.opacity(0.2))
                }
                if summary.completed > 0 {
                    arc(Double(summary.failed + summary.completed) * segment, HaboPalette.primary.opacity(0.75))
                        .widgetAccentable()
                }
                if summary.failed > 0 {
                    arc(Double(summary.failed) * segment, HaboPalette.red)
                }
            }
        }
    }

    private func arc(_ fraction: Double, _ color: Color) -> some View {
        Circle()
            .inset(by: stroke / 2)
            .trim(from: 0, to: min(fraction, 1))
            .stroke(color, style: StrokeStyle(lineWidth: stroke, lineCap: .round))
            .rotationEffect(.degrees(-90))
    }
}

#Preview("Today 0/5", as: .systemSmall) {
    TodayWidget()
} timeline: {
    PreviewData.todayEntry(codes: [".", ".", ".", ".", "."])
    PreviewData.todayEntry(codes: ["c", "c", "s", "f", "."])
    PreviewData.todayEntry(codes: ["c", "c", "c", "P", "s"])
}
