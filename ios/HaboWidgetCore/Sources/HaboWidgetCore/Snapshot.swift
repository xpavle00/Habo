import Foundation

/// Keys in the shared App Group. Each key has exactly one writer:
/// the Flutter app writes `snapshot` and `appliedSeq`, widget code writes
/// `pendingActions` and `pendingSeq`. Must match `WidgetKeys` in Dart.
public enum SharedKeys {
    public static let appGroup = "group.com.pavlenko.Habo"
    public static let snapshot = "widget_snapshot"
    public static let appliedSeq = "widget_applied_seq"
    public static let pendingActions = "widget_pending_actions"
    public static let pendingSeq = "widget_pending_seq"
}

/// One day's state, encoded as a single character in the snapshot.
public enum DayCode: Character, Codable, Sendable {
    case none = "."
    case check = "c"
    case fail = "f"
    case skip = "s"
    case progress = "p"
    case progressDone = "P"

    public var isDone: Bool { self == .check || self == .progressDone }

    public init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        guard let first = raw.first, raw.count == 1, let code = DayCode(rawValue: first) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unknown day code \(raw)"))
        }
        self = code
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(rawValue))
    }
}

/// A calendar day without time or time zone.
public struct LocalDate: Hashable, Comparable, Sendable {
    public let year: Int
    public let month: Int
    public let day: Int

    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }

    /// The local calendar day of `date` in `calendar`'s time zone.
    public init(_ date: Date, calendar: Calendar = .current) {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        self.init(year: c.year!, month: c.month!, day: c.day!)
    }

    /// Parses `yyyy-MM-dd`.
    public init?(iso: String) {
        let parts = iso.split(separator: "-").compactMap { Int($0) }
        guard parts.count == 3, (1...12).contains(parts[1]), (1...31).contains(parts[2]) else { return nil }
        self.init(year: parts[0], month: parts[1], day: parts[2])
    }

    public var iso: String { String(format: "%04d-%02d-%02d", year, month, day) }

    private static let utc: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "UTC")!
        return cal
    }()

    /// Noon UTC on this day; only used for calendar arithmetic.
    public var anchor: Date {
        LocalDate.utc.date(from: DateComponents(year: year, month: month, day: day, hour: 12))!
    }

    public func adding(days: Int) -> LocalDate {
        LocalDate(LocalDate.utc.date(byAdding: .day, value: days, to: anchor)!, calendar: LocalDate.utc)
    }

    /// ISO weekday: 1 = Monday ... 7 = Sunday.
    public var isoWeekday: Int {
        let weekday = LocalDate.utc.component(.weekday, from: anchor) // 1 = Sunday
        return weekday == 1 ? 7 : weekday - 1
    }

    /// 0-based index of this day within its year.
    public var dayOfYearIndex: Int {
        LocalDate.utc.ordinality(of: .day, in: .year, for: anchor)! - 1
    }

    public static func daysInYear(_ year: Int) -> Int {
        let leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
        return leap ? 366 : 365
    }

    public static func daysInMonth(year: Int, month: Int) -> Int {
        let start = LocalDate(year: year, month: month, day: 1).anchor
        return utc.range(of: .day, in: .month, for: start)!.count
    }

    public static func < (lhs: LocalDate, rhs: LocalDate) -> Bool {
        (lhs.year, lhs.month, lhs.day) < (rhs.year, rhs.month, rhs.day)
    }
}

extension LocalDate: Codable {
    public init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        guard let date = LocalDate(iso: raw) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Bad date \(raw)"))
        }
        self = date
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(iso)
    }
}

public struct Labels: Codable, Equatable, Sendable {
    public let habitsToday: String
    public let chooseHabit: String
    public let noHabits: String
    public let months: [String]
}

public struct Reminder: Codable, Equatable, Sendable {
    public let hour: Int
    public let minute: Int
}

public struct TodayProgress: Codable, Equatable, Sendable {
    public let value: Double
    public let target: Double
}

/// See the Dart builder: `today = [ifNotDone, ifDone]`,
/// `tomorrow[todayDone][tomorrowDone]`.
public struct StreakTable: Codable, Equatable, Sendable {
    public let today: [Int]
    public let tomorrow: [[Int]]
}

public struct SnapshotHabit: Codable, Equatable, Sendable, Identifiable {
    public let uuid: String
    public let id: Int?
    public let title: String
    public let type: String
    public let target: Double
    public let partial: Double
    public let unit: String
    public let position: Int
    /// Optional so snapshots written before this field still decode.
    public let twoDayRule: Bool?
    public let reminder: Reminder?
    public let year: Int
    public let days: String
    public let today: TodayProgress?
    public let streak: StreakTable

    public var isNumeric: Bool { type == "numeric" }

    /// Snapshot state for `date`; `.none` outside the snapshot's year.
    public func code(on date: LocalDate) -> DayCode {
        guard date.year == year else { return .none }
        let index = date.dayOfYearIndex
        guard index >= 0, index < days.count else { return .none }
        let char = days[days.index(days.startIndex, offsetBy: index)]
        return DayCode(rawValue: char) ?? .none
    }
}

public struct Snapshot: Codable, Equatable, Sendable {
    public let v: Int
    public let date: LocalDate
    public let weekStart: Int
    /// `device`, `light` or `dark`. Optional so snapshots written before
    /// this field still decode; anything else means `device`.
    public let theme: String?
    public let labels: Labels
    public let habits: [SnapshotHabit]

    public static func decode(_ data: Data) throws -> Snapshot {
        try JSONDecoder().decode(Snapshot.self, from: data)
    }

    /// Reads the snapshot the app wrote, or nil if none or unreadable.
    public static func load(from store: KeyValueStore) -> Snapshot? {
        guard let raw = store.string(forKey: SharedKeys.snapshot) else { return nil }
        return try? decode(Data(raw.utf8))
    }

    public func habit(uuid: String) -> SnapshotHabit? {
        habits.first { $0.uuid == uuid }
    }
}

/// A habit as shown in the "Edit Widget" picker.
public struct ResolvedHabitEntity: Equatable, Sendable {
    public let id: String
    public let title: String
    /// False when the habit is gone from the snapshot (deleted or archived).
    public let exists: Bool
}

/// Resolves stored widget selections. Ids missing from the snapshot keep
/// their id with a placeholder title, so the widget shows "choose a habit"
/// instead of silently switching to another habit.
public func resolveHabitEntities(ids: [String], habits: [SnapshotHabit], missingTitle: String) -> [ResolvedHabitEntity] {
    ids.map { id in
        if let habit = habits.first(where: { $0.uuid == id }) {
            return ResolvedHabitEntity(id: id, title: habit.title, exists: true)
        }
        return ResolvedHabitEntity(id: id, title: missingTitle, exists: false)
    }
}
