package com.pavlenko.Habo.widgets

import org.junit.Assert.assertEquals
import org.junit.Test
import java.time.Instant
import java.time.LocalDate

/** Mirrors ios/HaboWidgetCore/Tests/TodayListTests.swift. */
class TodayListTest {
    private val today = LocalDate.of(2026, 11, 6)
    private val now = Instant.ofEpochSecond(1_800_000_000)

    private fun habits(codes: String) = codes.mapIndexed { index, code ->
        val days = CharArray(today.lengthOfYear()) { '.' }
        days[today.dayOfYear - 1] = code
        SnapshotHabit(
            uuid = "h$index", id = index, title = "h$index", type = "boolean", target = 30.0, partial = 10.0,
            unit = "", position = index, twoDayRule = false, reminder = null, year = 2026,
            days = String(days), today = null, streak = StreakTable(listOf(0, 1), listOf(listOf(0, 1), listOf(1, 2))),
        )
    }

    private fun tap(uuid: String, code: DayCode, secondsAgo: Long, seq: Int = 1) =
        PendingAction(seq, uuid, today, code, null, null, now.minusSeconds(secondsAgo).toString())

    private fun shown(all: List<SnapshotHabit>, pending: List<PendingAction> = emptyList(), capacity: Int = 3) =
        todayListHabits(all, today, pending, now, capacity, holdSeconds = 4).map { it.uuid }

    @Test
    fun everythingShownWhenItFits() {
        assertEquals(listOf("h0", "h1", "h2"), shown(habits("c.f")))
        assertEquals(listOf("h0", "h1"), shown(habits("cc")))
    }

    @Test
    fun handledHabitsGiveUpTheirRowWhenThereAreTooMany() {
        assertEquals(listOf("h1", "h3", "h5"), shown(habits("c.f.s.")))
    }

    @Test
    fun partialProgressStillWaits() {
        assertEquals(listOf("h1", "h2", "h3"), shown(habits("cp..")))
    }

    @Test
    fun handledHabitsFillRowsLeftOver() {
        assertEquals(listOf("h0", "h1", "h2"), shown(habits("cc.cc")))
        assertEquals(listOf("h0", "h1", "h2"), shown(habits("cccc")))
    }

    @Test
    fun justTappedRowStaysInPlaceDuringHold() {
        val all = habits("....")
        assertEquals(listOf("h0", "h1", "h2"), shown(all, listOf(tap("h0", DayCode.CHECK, 1))))
        assertEquals(listOf("h1", "h2", "h3"), shown(all, listOf(tap("h0", DayCode.CHECK, 5))))
    }

    @Test
    fun uncheckingFromTheWidgetBringsTheRowBack() {
        val all = habits("c...")
        assertEquals(listOf("h1", "h2", "h3"), shown(all))
        assertEquals(listOf("h0", "h1", "h2"), shown(all, listOf(tap("h0", DayCode.NONE, 60))))
    }

    @Test
    fun releaseTimesAreFutureEndsOfHolds() {
        val pending = listOf(
            tap("h0", DayCode.CHECK, 1, seq = 1),
            tap("h1", DayCode.CHECK, 10, seq = 2),
            tap("h2", DayCode.NONE, 1, seq = 3),
        )
        assertEquals(listOf(now.plusSeconds(3)), todayListReleaseTimes(pending, today, now, holdSeconds = 4))
    }

    @Test
    fun summaryCountsDoneFailedAndSkipped() {
        val summary = todaySummary(habits("cfsp."), today, emptyList())
        assertEquals(TodaySummary(total = 5, completed = 1, skipped = 1, failed = 1), summary)
        assertEquals(3, summary.done)
    }
}
