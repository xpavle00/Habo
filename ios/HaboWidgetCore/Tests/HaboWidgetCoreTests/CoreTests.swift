import XCTest
@testable import HaboWidgetCore

final class SnapshotDecodingTests: XCTestCase {
    func testDecodesDartFixture() throws {
        let snapshot = try fixtureSnapshot()
        XCTAssertEqual(snapshot.v, 1)
        XCTAssertEqual(snapshot.date, LocalDate(year: 2026, month: 11, day: 6))
        XCTAssertEqual(snapshot.weekStart, 1)
        XCTAssertEqual(snapshot.theme, "device")
        XCTAssertEqual(snapshot.labels.months.count, 12)
        XCTAssertEqual(snapshot.habits.map(\.uuid), ["water", "read"])

        let water = snapshot.habits[0]
        XCTAssertEqual(water.reminder, Reminder(hour: 20, minute: 30))
        XCTAssertNil(water.today)
        XCTAssertEqual(water.code(on: LocalDate(year: 2026, month: 1, day: 1)), .check)
        XCTAssertEqual(water.code(on: LocalDate(year: 2026, month: 11, day: 5)), .skip)
        // Last year comes from prevDays; older years are unknown.
        XCTAssertEqual(water.code(on: LocalDate(year: 2025, month: 12, day: 31)), .fail)
        XCTAssertEqual(water.code(on: LocalDate(year: 2025, month: 12, day: 30)), .none)
        XCTAssertEqual(water.code(on: LocalDate(year: 2024, month: 12, day: 31)), .none)

        let read = snapshot.habits[1]
        XCTAssertEqual(read.isNumeric, true)
        XCTAssertEqual(read.today, TodayProgress(value: 10, target: 30))
        XCTAssertEqual(read.code(on: snapshot.date), .progress)
        XCTAssertEqual(read.code(on: LocalDate(year: 2026, month: 11, day: 5)), .fail)
    }

    func testCodeOutsideSnapshotYearIsNone() {
        let h = habit(days: days(set: [LocalDate(year: 2026, month: 12, day: 31): "c"]))
        XCTAssertEqual(h.code(on: LocalDate(year: 2026, month: 12, day: 31)), .check)
        XCTAssertEqual(h.code(on: LocalDate(year: 2027, month: 1, day: 1)), .none)
    }
}

final class LocalDateTests: XCTestCase {
    func testIsoRoundTrip() {
        let d = LocalDate(iso: "2026-02-03")
        XCTAssertEqual(d, LocalDate(year: 2026, month: 2, day: 3))
        XCTAssertEqual(d?.iso, "2026-02-03")
        XCTAssertNil(LocalDate(iso: "nope"))
    }

    func testFromDateUsesCalendarTimeZone() {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "Europe/Bratislava")!
        // 23:59 local on 6 Nov is 22:59 UTC.
        let date = ISO8601DateFormatter().date(from: "2026-11-06T22:59:00Z")!
        XCTAssertEqual(LocalDate(date, calendar: cal), LocalDate(year: 2026, month: 11, day: 6))
    }

    func testAddingDaysCrossesYear() {
        XCTAssertEqual(LocalDate(year: 2026, month: 12, day: 31).adding(days: 1), LocalDate(year: 2027, month: 1, day: 1))
    }

    func testLeapYear() {
        XCTAssertEqual(LocalDate.daysInYear(2028), 366)
        XCTAssertEqual(LocalDate.daysInYear(2026), 365)
        XCTAssertEqual(LocalDate(year: 2028, month: 12, day: 31).dayOfYearIndex, 365)
    }
}

final class PendingActionStoreTests: XCTestCase {
    let day = LocalDate(year: 2026, month: 11, day: 6)

    func testAppendIssuesIncreasingSeq() {
        let store = MemoryStore()
        let pending = PendingActionStore(store: store)
        pending.append(uuid: "a", date: day, code: .check, value: nil, target: nil, at: Date())
        pending.append(uuid: "b", date: day, code: .none, value: nil, target: nil, at: Date())
        XCTAssertEqual(pending.pending().map(\.seq), [1, 2])
        XCTAssertEqual(store.integer(forKey: SharedKeys.pendingSeq), 2)
    }

    func testAppendPrunesAppliedActions() {
        let store = MemoryStore()
        let pending = PendingActionStore(store: store)
        pending.append(uuid: "a", date: day, code: .check, value: nil, target: nil, at: Date())
        pending.append(uuid: "b", date: day, code: .check, value: nil, target: nil, at: Date())
        store.values[SharedKeys.appliedSeq] = 2
        pending.append(uuid: "c", date: day, code: .check, value: nil, target: nil, at: Date())
        XCTAssertEqual(pending.pending().map(\.uuid), ["c"])
        XCTAssertEqual(pending.pending().map(\.seq), [3])
    }

    func testAppendNeverWritesDartOwnedKeys() {
        let store = MemoryStore()
        PendingActionStore(store: store).append(uuid: "a", date: day, code: .check, value: nil, target: nil, at: Date())
        XCTAssertFalse(store.writes.contains(SharedKeys.appliedSeq))
        XCTAssertFalse(store.writes.contains(SharedKeys.snapshot))
    }

    func testPendingIgnoresAppliedEvenBeforePrune() {
        let store = MemoryStore()
        let pending = PendingActionStore(store: store)
        pending.append(uuid: "a", date: day, code: .check, value: nil, target: nil, at: Date())
        store.values[SharedKeys.appliedSeq] = 1
        XCTAssertTrue(pending.pending().isEmpty)
    }

    func testWritesJsonTheDartDrainerReads() throws {
        let store = MemoryStore()
        PendingActionStore(store: store).append(uuid: "a", date: day, code: .progressDone, value: 30, target: 30, at: Date(timeIntervalSince1970: 0))
        let raw = try XCTUnwrap(store.string(forKey: SharedKeys.pendingActions))
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(raw.utf8)) as? [[String: Any]])
        XCTAssertEqual(json.first?["seq"] as? Int, 1)
        XCTAssertEqual(json.first?["uuid"] as? String, "a")
        XCTAssertEqual(json.first?["date"] as? String, "2026-11-06")
        XCTAssertEqual(json.first?["code"] as? String, "P")
        XCTAssertEqual(json.first?["value"] as? Double, 30)
        XCTAssertEqual(json.first?["at"] as? String, "1970-01-01T00:00:00Z")
    }

    func testCorruptListStartsFresh() {
        let store = MemoryStore()
        store.values[SharedKeys.pendingActions] = "{oops"
        let pending = PendingActionStore(store: store)
        XCTAssertTrue(pending.pending().isEmpty)
        pending.append(uuid: "a", date: day, code: .check, value: nil, target: nil, at: Date())
        XCTAssertEqual(pending.pending().count, 1)
    }
}

final class EffectiveStateTests: XCTestCase {
    let today = LocalDate(year: 2026, month: 11, day: 6)

    private func action(_ seq: Int, _ code: DayCode, uuid: String = "h", date: LocalDate? = nil, value: Double? = nil) -> PendingAction {
        PendingAction(seq: seq, uuid: uuid, date: date ?? today, code: code, value: value, target: value == nil ? nil : 30, at: "x")
    }

    func testOverlaySurvivesSnapshotRewrite() {
        // A fresh snapshot (without the tap) is read while the tap is pending.
        let fresh = habit(days: days(set: [:]))
        XCTAssertEqual(effectiveCode(habit: fresh, on: today, pending: [action(1, .check)]), .check)
    }

    func testLastPendingActionForSameDayWins() {
        let h = habit()
        XCTAssertEqual(effectiveCode(habit: h, on: today, pending: [action(2, .none), action(1, .check)]), .none)
    }

    func testPendingForOtherHabitOrDayIgnored() {
        let h = habit(days: days(set: [today: "f"]))
        let pending = [action(1, .check, uuid: "other"), action(2, .check, date: today.adding(days: -1))]
        XCTAssertEqual(effectiveCode(habit: h, on: today, pending: pending), .fail)
    }

    func testSnapshotFromYesterdayGivesNoneToday() {
        let yesterday = today.adding(days: -1)
        let h = habit(days: days(set: [yesterday: "c"]))
        XCTAssertEqual(effectiveCode(habit: h, on: today, pending: []), .none)
        XCTAssertEqual(effectiveCode(habit: h, on: yesterday, pending: []), .check)
    }

    func testSnapshotYearViewedNextYearIsNone() {
        let h = habit(days: String(repeating: "c", count: 365))
        XCTAssertEqual(effectiveCode(habit: h, on: LocalDate(year: 2027, month: 1, day: 1), pending: []), .none)
    }

    func testTodayValueFromSnapshotThenPending() {
        let h = habit(type: "numeric", today: TodayProgress(value: 12, target: 30))
        XCTAssertEqual(effectiveTodayValue(habit: h, today: today, snapshotDate: today, pending: []), 12)
        XCTAssertEqual(effectiveTodayValue(habit: h, today: today, snapshotDate: today, pending: [action(1, .progress, value: 22)]), 22)
        // Next day without app open: nothing logged yet.
        XCTAssertEqual(effectiveTodayValue(habit: h, today: today.adding(days: 1), snapshotDate: today, pending: []), 0)
    }

    func testNextStateBooleanToggles() {
        let h = habit()
        XCTAssertEqual(nextState(for: h, current: .none, currentValue: nil).code, .check)
        XCTAssertEqual(nextState(for: h, current: .check, currentValue: nil).code, .none)
        XCTAssertEqual(nextState(for: h, current: .fail, currentValue: nil).code, .check)
        XCTAssertEqual(nextState(for: h, current: .skip, currentValue: nil).code, .check)
    }

    func testNextStateNumericAddsPartialAndFlipsAtTarget() {
        let h = habit(type: "numeric", today: TodayProgress(value: 10, target: 30))
        let first = nextState(for: h, current: .progress, currentValue: 10)
        XCTAssertEqual(first.code, .progress)
        XCTAssertEqual(first.value, 20)
        let second = nextState(for: h, current: .progress, currentValue: 20)
        XCTAssertEqual(second.code, .progressDone)
        XCTAssertEqual(second.value, 30)
        XCTAssertEqual(second.target, 30)
    }

    func testStreakToday() {
        let h = habit(streakToday: [3, 4])
        XCTAssertEqual(streak(habit: h, today: today, snapshotDate: today, pending: []), 3)
        XCTAssertEqual(streak(habit: h, today: today, snapshotDate: today, pending: [action(1, .check)]), 4)
    }

    func testStreakPicksTomorrowTableAfterMidnight() {
        let tomorrow = today.adding(days: 1)
        let h = habit(days: days(set: [today: "c"]), streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]])
        XCTAssertEqual(streak(habit: h, today: tomorrow, snapshotDate: today, pending: []), 4)
        XCTAssertEqual(streak(habit: h, today: tomorrow, snapshotDate: today, pending: [action(1, .check, date: tomorrow)]), 5)
        // Yesterday undone from the widget after the snapshot was written.
        XCTAssertEqual(streak(habit: h, today: tomorrow, snapshotDate: today, pending: [action(1, .none)]), 3)
    }

    func testStreakBeyondTomorrowWithoutTapsKeepsLastValue() {
        let h = habit(streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]])
        XCTAssertEqual(streak(habit: h, today: today.adding(days: 5), snapshotDate: today, pending: []), 3)
    }

    private func ticks(_ offsets: [Int], _ code: DayCode = .check) -> [PendingAction] {
        offsets.enumerated().map { i, offset in action(i + 1, code, date: today.adding(days: offset)) }
    }

    func testWidgetOnlyTickingKeepsCounting() {
        // Snapshot day done (row 1), then ticked from the widget every day.
        let h = habit(days: days(set: [today: "c"]), streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]])
        XCTAssertEqual(streak(habit: h, today: today.adding(days: 3), snapshotDate: today, pending: ticks([1, 2, 3])), 7)
    }

    func testMissedDayRestartsAtOne() {
        let h = habit(days: days(set: [today: "c"]), streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]])
        XCTAssertEqual(streak(habit: h, today: today.adding(days: 3), snapshotDate: today, pending: ticks([1, 3])), 1)
    }

    func testUntickedTodayShowsStreakSoFar() {
        let h = habit(days: days(set: [today: "c"]), streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]])
        XCTAssertEqual(streak(habit: h, today: today.adding(days: 3), snapshotDate: today, pending: ticks([1, 2])), 6)
    }

    func testFailEndsStreakWithoutTwoDayRule() {
        let h = habit(days: days(set: [today: "c"]), streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]])
        XCTAssertEqual(streak(habit: h, today: today.adding(days: 2), snapshotDate: today,
                              pending: ticks([1]) + [action(9, .fail, date: today.adding(days: 2))]), 0)
    }

    func testTwoDayRuleSingleFailBridges() {
        let h = habit(days: days(set: [today: "c"]), streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]], twoDayRule: true)
        let pending = ticks([1]) + [action(8, .fail, date: today.adding(days: 2)), action(9, .check, date: today.adding(days: 3))]
        XCTAssertEqual(streak(habit: h, today: today.adding(days: 3), snapshotDate: today, pending: pending), 6)
    }

    func testTwoDayRuleTwoFailsEndStreak() {
        let h = habit(days: days(set: [today: "c"]), streakToday: [3, 4], streakTomorrow: [[3, 1], [4, 5]], twoDayRule: true)
        let pending = [action(8, .fail, date: today.adding(days: 1)), action(9, .fail, date: today.adding(days: 2))]
        XCTAssertEqual(streak(habit: h, today: today.adding(days: 2), snapshotDate: today, pending: pending), 0)
    }
}

final class TodaySummaryTests: XCTestCase {
    func testCountsLikeHomeWidgetHelper() throws {
        let today = LocalDate(year: 2026, month: 11, day: 6)
        let habits = [
            habit(uuid: "a", days: days(set: [today: "c"])),
            habit(uuid: "b", days: days(set: [today: "P"])),
            habit(uuid: "c", days: days(set: [today: "p"])),
            habit(uuid: "d", days: days(set: [today: "s"])),
            habit(uuid: "e", days: days(set: [today: "f"])),
            habit(uuid: "f"),
        ]
        let summary = todaySummary(habits: habits, today: today, pending: [])
        XCTAssertEqual(summary, TodaySummary(total: 6, completed: 2, skipped: 1, failed: 1))
        XCTAssertEqual(summary.done, 4)
        XCTAssertFalse(summary.allDone)
    }

    func testPendingTapCounts() {
        let today = LocalDate(year: 2026, month: 11, day: 6)
        let pending = [PendingAction(seq: 1, uuid: "a", date: today, code: .check, value: nil, target: nil, at: "x")]
        let summary = todaySummary(habits: [habit(uuid: "a")], today: today, pending: pending)
        XCTAssertEqual(summary.completed, 1)
        XCTAssertTrue(summary.allDone)
    }

    func testEmptyIsNotAllDone() {
        XCTAssertFalse(todaySummary(habits: [], today: LocalDate(year: 2026, month: 1, day: 1), pending: []).allDone)
    }
}

final class HabitEntityResolutionTests: XCTestCase {
    func testKnownIdsResolveToTitles() {
        let resolved = resolveHabitEntities(ids: ["a"], habits: [habit(uuid: "a")], missingTitle: "Choose a habit")
        XCTAssertEqual(resolved.map(\.id), ["a"])
        XCTAssertEqual(resolved.map(\.title), ["Habit a"])
        XCTAssertEqual(resolved.map(\.exists), [true])
    }

    func testMissingIdKeepsItsIdWithPlaceholderTitle() {
        // A deleted habit must stay selected (so the widget shows "choose a
        // habit") instead of falling back to the first habit.
        let resolved = resolveHabitEntities(ids: ["gone"], habits: [habit(uuid: "a")], missingTitle: "Choose a habit")
        XCTAssertEqual(resolved.map(\.id), ["gone"])
        XCTAssertEqual(resolved.map(\.title), ["Choose a habit"])
        XCTAssertEqual(resolved.map(\.exists), [false])
    }
}
