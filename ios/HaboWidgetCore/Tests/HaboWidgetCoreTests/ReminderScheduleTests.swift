import XCTest
@testable import HaboWidgetCore

final class ReminderScheduleTests: XCTestCase {
    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Europe/Prague")!
        return calendar
    }

    private let reminder = Reminder(hour: 18, minute: 30)

    private func at(_ hour: Int, _ minute: Int = 0) -> Date {
        calendar.date(from: DateComponents(year: 2026, month: 11, day: 14, hour: hour, minute: minute))!
    }

    private func assertDaily(_ result: (components: DateComponents, repeats: Bool), file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(result.repeats, file: file, line: line)
        XCTAssertNil(result.components.year, file: file, line: line)
        XCTAssertNil(result.components.day, file: file, line: line)
        XCTAssertNil(result.components.timeZone, "floating local time", file: file, line: line)
        XCTAssertEqual(result.components.hour, 18, file: file, line: line)
        XCTAssertEqual(result.components.minute, 30, file: file, line: line)
    }

    func testUndoneRestoresTheDailyReminderBeforeItsTime() {
        assertDaily(reminderSchedule(for: reminder, becameDone: false, now: at(9), calendar: calendar))
    }

    func testUndoneRestoresTheDailyReminderAfterItsTime() {
        assertDaily(reminderSchedule(for: reminder, becameDone: false, now: at(20), calendar: calendar))
    }

    func testDoneAfterTodaysReminderStaysDaily() {
        assertDaily(reminderSchedule(for: reminder, becameDone: true, now: at(19), calendar: calendar))
    }

    func testDoneBeforeTodaysReminderSkipsToTomorrowOnce() {
        let result = reminderSchedule(for: reminder, becameDone: true, now: at(9), calendar: calendar)
        XCTAssertFalse(result.repeats)
        XCTAssertEqual(result.components.year, 2026)
        XCTAssertEqual(result.components.month, 11)
        XCTAssertEqual(result.components.day, 15)
        XCTAssertEqual(result.components.hour, 18)
        XCTAssertEqual(result.components.minute, 30)
    }

    func testDoneExactlyAtReminderTimeStaysDaily() {
        // The reminder is firing now; nothing left to skip today.
        assertDaily(reminderSchedule(for: reminder, becameDone: true, now: at(18, 30), calendar: calendar))
    }
}
