import WidgetKit

/// Widget kinds this extension provides. Must match `WidgetKinds` in Dart.
enum HaboWidgetKind {
    /// Kept from the original widget so placed widgets survive updates.
    static let today = "HaboWidget"
    static let checkIn = "HaboCheckInWidget"
    static let heatmap = "HaboHeatmapWidget"
    static let todayList = "HaboTodayListWidget"

    static let all = [today, checkIn, heatmap, todayList]
}

/// Shared App Group defaults, or nil if the group isn't configured.
var sharedDefaults: UserDefaults? { UserDefaults(suiteName: SharedKeys.appGroup) }

/// Every Habo widget renders snapshot + pending taps, so a tap on one must
/// refresh all of them.
///
/// From an intent, iOS only promises to refresh the tapped widget; other
/// reloads are requests it may defer. Naming each kind is reported to be
/// honoured more readily than `reloadAllTimelines()` alone.
func reloadAllHaboWidgets() {
    let center = WidgetCenter.shared
    for kind in HaboWidgetKind.all {
        center.reloadTimelines(ofKind: kind)
    }
}
