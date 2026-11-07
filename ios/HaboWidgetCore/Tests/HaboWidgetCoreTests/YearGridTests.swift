import XCTest
@testable import HaboWidgetCore

final class YearGridTests: XCTestCase {
    func testTwelveBlocks() {
        XCTAssertEqual(yearGrid(year: 2026, weekStart: 1).map(\.month), Array(1...12))
    }

    func testInMonthSlotsCoverTheYear() {
        func count(_ year: Int) -> Int {
            yearGrid(year: year, weekStart: 1).flatMap { $0.columns.flatMap { $0 } }.compactMap { $0 }.count
        }
        XCTAssertEqual(count(2026), 365)
        XCTAssertEqual(count(2028), 366)
    }

    func testDaysAppearInOrderOnce() {
        let dates = yearGrid(year: 2028, weekStart: 7).flatMap { $0.columns.flatMap { $0 } }.compactMap { $0 }
        XCTAssertEqual(dates.first, LocalDate(year: 2028, month: 1, day: 1))
        XCTAssertEqual(dates.last, LocalDate(year: 2028, month: 12, day: 31))
        XCTAssertEqual(dates, dates.sorted())
        XCTAssertEqual(Set(dates).count, dates.count)
    }

    func testNoColumnSpansTwoMonths() {
        for block in yearGrid(year: 2026, weekStart: 1) {
            for column in block.columns {
                XCTAssertEqual(column.count, 7)
                for date in column.compactMap({ $0 }) {
                    XCTAssertEqual(date.month, block.month)
                }
            }
        }
    }

    func testFirstSlotRowFollowsWeekStart() {
        // 1 Jan 2026 is a Thursday.
        let monday = yearGrid(year: 2026, weekStart: 1)[0].columns[0]
        XCTAssertEqual(monday.firstIndex { $0 != nil }, 3)
        let sunday = yearGrid(year: 2026, weekStart: 7)[0].columns[0]
        XCTAssertEqual(sunday.firstIndex { $0 != nil }, 4)
    }

    func testFebruary2026StartingSundayWithMondayWeekStart() {
        let feb = yearGrid(year: 2026, weekStart: 1)[1]
        XCTAssertEqual(feb.columns[0].filter { $0 == nil }.count, 6)
        XCTAssertEqual(feb.columns[0][6], LocalDate(year: 2026, month: 2, day: 1))
    }

    func testTotalColumnsFitsAYear() {
        let total = yearGrid(year: 2026, weekStart: 1).reduce(0) { $0 + $1.columns.count }
        XCTAssertGreaterThanOrEqual(total, 60)
        XCTAssertLessThanOrEqual(total, 66)
    }
}
