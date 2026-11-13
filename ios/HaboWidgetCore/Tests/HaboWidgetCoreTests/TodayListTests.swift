import XCTest
@testable import HaboWidgetCore

final class TodayListTests: XCTestCase {
    let today = LocalDate(year: 2026, month: 11, day: 6)
    let now = Date(timeIntervalSince1970: 1_800_000_000)

    private func habits(_ codes: String) -> [SnapshotHabit] {
        codes.enumerated().map { index, code in
            habit(uuid: "h\(index)", days: days(set: [today: code]))
        }
    }

    private func tap(_ uuid: String, _ code: DayCode, secondsAgo: TimeInterval, seq: Int = 1) -> PendingAction {
        let formatter = ISO8601DateFormatter()
        return PendingAction(
            seq: seq, uuid: uuid, date: today, code: code, value: nil, target: nil,
            at: formatter.string(from: now.addingTimeInterval(-secondsAgo))
        )
    }

    private func shown(_ all: [SnapshotHabit], pending: [PendingAction] = [], capacity: Int = 3) -> [String] {
        todayListHabits(habits: all, today: today, pending: pending, now: now, capacity: capacity, hold: 4).map(\.uuid)
    }

    func testEverythingShownWhenItFits() {
        XCTAssertEqual(shown(habits("c.f")), ["h0", "h1", "h2"])
        XCTAssertEqual(shown(habits("cc")), ["h0", "h1"])
    }

    func testHandledHabitsGiveUpTheirRowWhenThereAreTooMany() {
        // done, to do, failed, to do, skipped, to do
        XCTAssertEqual(shown(habits("c.f.s.")), ["h1", "h3", "h5"])
    }

    func testPartialProgressStillWaits() {
        XCTAssertEqual(shown(habits("cp..")), ["h1", "h2", "h3"])
    }

    func testHandledHabitsFillRowsLeftOver() {
        // Only one habit still waiting: the first handled ones fill up, in app order.
        XCTAssertEqual(shown(habits("cc.cc")), ["h0", "h1", "h2"])
        XCTAssertEqual(shown(habits("cccc")), ["h0", "h1", "h2"])
    }

    func testJustTappedRowStaysInPlaceDuringHold() {
        let all = habits("....")
        XCTAssertEqual(shown(all, pending: [tap("h0", .check, secondsAgo: 1)]), ["h0", "h1", "h2"])
        XCTAssertEqual(shown(all, pending: [tap("h0", .check, secondsAgo: 5)]), ["h1", "h2", "h3"])
    }

    func testUncheckingFromTheWidgetBringsTheRowBack() {
        let all = habits("c...")
        XCTAssertEqual(shown(all), ["h1", "h2", "h3"])
        XCTAssertEqual(shown(all, pending: [tap("h0", .none, secondsAgo: 60)]), ["h0", "h1", "h2"])
    }

    func testReleaseDatesAreFutureEndsOfHolds() {
        let pending = [
            tap("h0", .check, secondsAgo: 1, seq: 1),
            tap("h1", .check, secondsAgo: 10, seq: 2),
            tap("h2", .none, secondsAgo: 1, seq: 3),
        ]
        let dates = todayListReleaseDates(pending: pending, today: today, now: now, hold: 4)
        XCTAssertEqual(dates, [now.addingTimeInterval(3)])
    }
}
