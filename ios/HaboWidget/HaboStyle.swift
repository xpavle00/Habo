import SwiftUI
import WidgetKit

/// The app's typeface (Nunito), bundled with the widget extension and
/// listed under `UIAppFonts`. Falls back to the system font if missing.
enum HaboFont {
    static func bold(_ size: CGFloat) -> Font { .custom("Nunito-Bold", fixedSize: size) }
    static func extraBold(_ size: CGFloat) -> Font { .custom("Nunito-ExtraBold", fixedSize: size) }
}

extension DayCode {
    /// Fill colour of a day tile, as in the app's calendar row.
    /// `nil` (a day that hasn't happened yet) is fainter than an empty day.
    ///
    /// In tinted and clear home screens (`accented`) iOS keeps only opacity,
    /// so states are told apart by how opaque the tile is instead of by hue.
    static func tileColor(_ code: DayCode?, accented: Bool = false) -> Color {
        if accented {
            switch code {
            case .check?, .progressDone?: return .white
            case .progress?: return .white.opacity(0.6)
            case .fail?: return .white.opacity(0.42)
            case .skip?: return .white.opacity(0.28)
            case .none?: return .white.opacity(0.14)
            case nil: return .white.opacity(0.06)
            }
        }
        switch code {
        case .check?, .progressDone?: return HaboPalette.primary
        case .fail?: return HaboPalette.red
        case .skip?: return HaboPalette.skip
        case .progress?: return HaboPalette.progress
        case .none?: return HaboPalette.grey.opacity(0.28)
        case nil: return HaboPalette.grey.opacity(0.12)
        }
    }
}

extension View {
    /// Punches `mask` out of this view. Used in tinted and clear home
    /// screens, where white-on-colour would collapse into one flat tint:
    /// cut out, the icon or text shows the glass behind it instead.
    func knockout<Mask: View>(@ViewBuilder _ mask: () -> Mask) -> some View {
        overlay(mask().blendMode(.destinationOut)).compositingGroup()
    }
}

extension WidgetRenderingMode {
    /// Tinted and clear home screens: colour is dropped, opacity kept.
    var isAccented: Bool { self != .fullColor }
}

/// The green streak capsule from the app's habit header.
struct StreakPill: View {
    let count: Int

    var body: some View { CountPill(text: "\(count)") }
}

/// Habit title on the left, streak pill on the right, with `detail`
/// (by default a spacer) in between.
struct HabitHeader<Detail: View>: View {
    let title: String
    let streak: Int
    @ViewBuilder var detail: Detail

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            Text(title)
                .font(HaboFont.extraBold(15))
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .truncationMode(.tail)
                .layoutPriority(1)
            detail
            if streak > 0 {
                StreakPill(count: streak)
            }
        }
        .frame(height: 20)
    }
}

extension HabitHeader where Detail == Spacer {
    init(title: String, streak: Int) {
        self.init(title: title, streak: streak) { Spacer(minLength: 0) }
    }
}

/// The Material icons the app uses on day buttons (`Icons.check`, `close`,
/// `last_page`, `add`), drawn from their 24x24 outlines so the widget
/// matches the app without bundling the icon font.
enum MaterialIcon: Shape {
    case check, close, lastPage, add

    private var polygons: [[(CGFloat, CGFloat)]] {
        switch self {
        case .check:
            return [[(9, 16.17), (4.83, 12), (3.41, 13.41), (9, 19), (21, 7), (19.59, 5.59)]]
        case .close:
            return [[
                (19, 6.41), (17.59, 5), (12, 10.59), (6.41, 5), (5, 6.41), (10.59, 12),
                (5, 17.59), (6.41, 19), (12, 13.41), (17.59, 19), (19, 17.59), (13.41, 12),
            ]]
        case .lastPage:
            return [
                [(5.59, 7.41), (10.18, 12), (5.59, 16.59), (7, 18), (13, 12), (7, 6)],
                [(16, 6), (18, 6), (18, 18), (16, 18)],
            ]
        case .add:
            return [[
                (19, 13), (13, 13), (13, 19), (11, 19), (11, 13), (5, 13),
                (5, 11), (11, 11), (11, 5), (13, 5), (13, 11), (19, 11),
            ]]
        }
    }

    func path(in rect: CGRect) -> Path {
        let scale = min(rect.width, rect.height) / 24
        let origin = CGPoint(x: rect.midX - 12 * scale, y: rect.midY - 12 * scale)
        var path = Path()
        for polygon in polygons {
            let points = polygon.map { CGPoint(x: origin.x + $0.0 * scale, y: origin.y + $0.1 * scale) }
            path.addLines(points)
            path.closeSubpath()
        }
        return path
    }
}
