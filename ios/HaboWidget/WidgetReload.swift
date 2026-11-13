import WidgetKit

/// Widget kinds this extension provides. Must match `WidgetKinds` in Dart.
enum HaboWidgetKind {
    /// Kept from the original widget so placed widgets survive updates.
    static let today = "HaboWidget"
    static let checkIn = "HaboCheckInWidget"
    static let heatmap = "HaboHeatmapWidget"
    static let todayList = "HaboTodayListWidget"
}

/// Shared App Group defaults, or nil if the group isn't configured.
var sharedDefaults: UserDefaults? { UserDefaults(suiteName: SharedKeys.appGroup) }

/// Every Habo widget renders snapshot + pending taps, so a tap on one must
/// refresh all of them.
func reloadAllHaboWidgets() {
    WidgetCenter.shared.reloadAllTimelines()
}
