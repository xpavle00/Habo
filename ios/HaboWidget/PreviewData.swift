import Foundation

/// Sample data for SwiftUI previews and the widget gallery placeholder.
enum PreviewData {
    static let today = LocalDate(year: 2026, month: 11, day: 6)

    static func habit(uuid: String, title: String, type: String = "boolean", seed: Int, todayCode: Character? = nil) -> SnapshotHabit {
        let length = LocalDate.daysInYear(today.year)
        let pattern: [Character] = ["c", "c", "c", "f", "c", "s", "c", "p", "c", "."]
        var chars = (0..<length).map { i -> Character in
            i < today.dayOfYearIndex ? pattern[(i * 7 + seed) % pattern.count] : "."
        }
        if let todayCode { chars[today.dayOfYearIndex] = todayCode }
        return SnapshotHabit(
            uuid: uuid, id: seed, title: title, type: type,
            target: 30, partial: 10, unit: type == "numeric" ? "min" : "",
            position: seed, twoDayRule: false, reminder: nil, year: today.year, days: String(chars),
            today: type == "numeric" ? TodayProgress(value: todayCode == "P" ? 30 : 10, target: 30) : nil,
            streak: StreakTable(today: [12, 13], tomorrow: [[12, 1], [13, 14]])
        )
    }

    static let water = habit(uuid: "water", title: "Drink water", seed: 1)
    static let read = habit(uuid: "read", title: "Read", type: "numeric", seed: 2)
    static let longTitle = habit(uuid: "long", title: "Practise the piano scales for twenty minutes every morning", seed: 3)

    static let labels = Labels(
        habitsToday: "Habits today", chooseHabit: "Choose a habit", noHabits: "Add a habit in Habo",
        months: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    )

    static func snapshot(_ habits: [SnapshotHabit], weekStart: Int = 1) -> Snapshot {
        Snapshot(v: 1, date: today, weekStart: weekStart, theme: nil, labels: labels, habits: habits)
    }

    static var previewDate: Date {
        Calendar.current.date(from: DateComponents(year: today.year, month: today.month, day: today.day, hour: 20))!
    }

    static func entry(habitUUID: String?, todayCode: Character? = nil, weekStart: Int = 1) -> HaboEntry {
        var habits = [water, read, longTitle]
        if let todayCode, let uuid = habitUUID, let index = habits.firstIndex(where: { $0.uuid == uuid }) {
            let h = habits[index]
            habits[index] = habit(uuid: h.uuid, title: h.title, type: h.type, seed: h.position, todayCode: todayCode)
        }
        return HaboEntry(date: previewDate, snapshot: snapshot(habits, weekStart: weekStart), pending: [], habitUUID: habitUUID)
    }

    /// Named habits for the today list; `P`/`p` make a numeric habit.
    static func listEntry(codes: [Character]) -> HaboEntry {
        let titles = [
            "Drink water", "Read", "Morning stretch", "No sugar",
            "Practise the piano scales", "Meditate", "Walk", "Journal",
        ]
        let habits = codes.enumerated().map { i, code in
            habit(
                uuid: "l\(i)", title: titles[i % titles.count],
                type: code == "P" || code == "p" ? "numeric" : "boolean", seed: i, todayCode: code
            )
        }
        return HaboEntry(date: previewDate, snapshot: snapshot(habits), pending: [], habitUUID: nil)
    }

    static func todayEntry(codes: [Character]) -> HaboEntry {
        let habits = codes.enumerated().map { i, code in
            habit(uuid: "h\(i)", title: "Habit \(i)", type: code == "P" ? "numeric" : "boolean", seed: i, todayCode: code)
        }
        return HaboEntry(date: previewDate, snapshot: snapshot(habits), pending: [], habitUUID: nil)
    }
}
