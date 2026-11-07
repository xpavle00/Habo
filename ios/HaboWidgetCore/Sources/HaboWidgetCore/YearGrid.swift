import Foundation

/// One month of the heatmap: week columns, each with 7 slots in week order
/// (starting at the configured week start). `nil` slots are outside the month.
public struct MonthBlock: Equatable, Sendable {
    public let month: Int
    public let columns: [[LocalDate?]]
}

/// Lays out `year` as 12 month blocks. No column holds days from two months,
/// so months stay visually separate.
///
/// - Parameter weekStart: ISO weekday of the first row, 1 = Monday ... 7 = Sunday.
public func yearGrid(year: Int, weekStart: Int) -> [MonthBlock] {
    (1...12).map { month in
        let first = LocalDate(year: year, month: month, day: 1)
        let offset = ((first.isoWeekday - weekStart) % 7 + 7) % 7
        let days = LocalDate.daysInMonth(year: year, month: month)
        let columnCount = (offset + days + 6) / 7
        let columns: [[LocalDate?]] = (0..<columnCount).map { column in
            (0..<7).map { row in
                let day = column * 7 + row - offset + 1
                return (1...days).contains(day) ? LocalDate(year: year, month: month, day: day) : nil
            }
        }
        return MonthBlock(month: month, columns: columns)
    }
}
