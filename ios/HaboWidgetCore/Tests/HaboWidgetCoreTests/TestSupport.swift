import Foundation
@testable import HaboWidgetCore

/// In-memory KeyValueStore that records which keys were written.
final class MemoryStore: KeyValueStore {
    var values: [String: Any] = [:]
    var writes: [String] = []

    func string(forKey key: String) -> String? { values[key] as? String }
    func integer(forKey key: String) -> Int { values[key] as? Int ?? 0 }
    func set(_ value: Any?, forKey key: String) {
        writes.append(key)
        values[key] = value
    }
}

func fixtureSnapshot() throws -> Snapshot {
    let url = try XCTUnwrapURL(Bundle.module.url(forResource: "snapshot", withExtension: "json", subdirectory: "Fixtures"))
    return try Snapshot.decode(Data(contentsOf: url))
}

private func XCTUnwrapURL(_ url: URL?) throws -> URL {
    guard let url else { throw NSError(domain: "fixture", code: 1) }
    return url
}

func habit(
    uuid: String = "h",
    type: String = "boolean",
    year: Int = 2026,
    days: String? = nil,
    today: TodayProgress? = nil,
    streakToday: [Int] = [0, 1],
    streakTomorrow: [[Int]] = [[0, 1], [1, 2]],
    twoDayRule: Bool = false
) -> SnapshotHabit {
    let length = LocalDate.daysInYear(year)
    return SnapshotHabit(
        uuid: uuid, id: 1, title: "Habit \(uuid)", type: type,
        target: 30, partial: 10, unit: "min", position: 0, twoDayRule: twoDayRule, reminder: nil,
        year: year, days: days ?? String(repeating: ".", count: length),
        today: today,
        streak: StreakTable(today: streakToday, tomorrow: streakTomorrow)
    )
}

func days(year: Int = 2026, set: [LocalDate: Character]) -> String {
    var chars = Array(repeating: Character("."), count: LocalDate.daysInYear(year))
    for (date, code) in set { chars[date.dayOfYearIndex] = code }
    return String(chars)
}
