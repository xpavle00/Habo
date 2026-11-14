package com.pavlenko.Habo.widgets

import org.json.JSONArray
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.io.File
import java.time.Instant
import java.time.LocalDate

/** Mirrors ios/HaboWidgetCore/Tests so both platforms keep the same rules. */
class WidgetCoreTest {
    private val today = LocalDate.of(2026, 11, 6)

    private class MemoryStore : KeyValueStore {
        val values = mutableMapOf<String, Any>()
        val writes = mutableListOf<String>()
        override fun getString(key: String) = values[key] as? String
        override fun getInt(key: String) = values[key] as? Int ?: 0
        override fun putString(key: String, value: String) { writes += key; values[key] = value }
        override fun putInt(key: String, value: Int) { writes += key; values[key] = value }
    }

    private fun days(set: Map<LocalDate, Char>, year: Int = 2026): String {
        val chars = CharArray(LocalDate.of(year, 1, 1).lengthOfYear()) { '.' }
        set.forEach { (date, code) -> chars[date.dayOfYear - 1] = code }
        return String(chars)
    }

    private fun habit(
        uuid: String = "h",
        type: String = "boolean",
        days: String = days(emptyMap()),
        todayProgress: TodayProgress? = null,
        streakToday: List<Int> = listOf(0, 1),
        streakTomorrow: List<List<Int>> = listOf(listOf(0, 1), listOf(1, 2)),
        twoDayRule: Boolean = false,
    ) = SnapshotHabit(
        uuid = uuid, id = 1, title = "Habit $uuid", type = type, target = 30.0, partial = 10.0,
        unit = "min", position = 0, twoDayRule = twoDayRule, reminder = null, year = 2026,
        days = days, today = todayProgress, streak = StreakTable(streakToday, streakTomorrow),
    )

    private fun action(seq: Int, code: DayCode, uuid: String = "h", date: LocalDate = today, value: Double? = null) =
        PendingAction(seq, uuid, date, code, value, if (value == null) null else 30.0, "x")

    private fun ticks(offsets: List<Int>) =
        offsets.mapIndexed { i, offset -> action(i + 1, DayCode.CHECK, date = today.plusDays(offset.toLong())) }

    // Snapshot

    @Test
    fun decodesTheSameFixtureAsSwift() {
        val raw = File("../../ios/HaboWidgetCore/Tests/HaboWidgetCoreTests/Fixtures/snapshot.json").readText()
        val snapshot = Snapshot.parse(raw)!!
        assertEquals(1, snapshot.v)
        assertEquals(today, snapshot.date)
        assertEquals(1, snapshot.weekStart)
        assertEquals(WidgetTheme.DEVICE, snapshot.theme)
        assertEquals(12, snapshot.labels.months.size)
        assertEquals(listOf("water", "read"), snapshot.habits.map { it.uuid })

        val water = snapshot.habits[0]
        assertEquals(Reminder(20, 30), water.reminder)
        assertNull(water.today)
        assertEquals(DayCode.CHECK, water.code(LocalDate.of(2026, 1, 1)))
        assertEquals(DayCode.SKIP, water.code(LocalDate.of(2026, 11, 5)))
        // Last year comes from prevDays; older years are unknown.
        assertEquals(DayCode.FAIL, water.code(LocalDate.of(2025, 12, 31)))
        assertEquals(DayCode.NONE, water.code(LocalDate.of(2025, 12, 30)))
        assertEquals(DayCode.NONE, water.code(LocalDate.of(2024, 12, 31)))

        val read = snapshot.habits[1]
        assertTrue(read.isNumeric)
        assertEquals(TodayProgress(10.0, 30.0), read.today)
        assertEquals(DayCode.PROGRESS, read.code(snapshot.date))
        assertEquals(DayCode.FAIL, read.code(LocalDate.of(2026, 11, 5)))
    }

    @Test
    fun widgetThemeDefaultsToDeviceForUnknownValues() {
        assertEquals(WidgetTheme.LIGHT, WidgetTheme.from("light"))
        assertEquals(WidgetTheme.DARK, WidgetTheme.from("dark"))
        assertEquals(WidgetTheme.DEVICE, WidgetTheme.from("device"))
        assertEquals(WidgetTheme.DEVICE, WidgetTheme.from(""))
        assertEquals(WidgetTheme.DEVICE, WidgetTheme.from(null))
    }

    @Test
    fun unreadableSnapshotIsNull() {
        assertNull(Snapshot.parse(null))
        assertNull(Snapshot.parse("{oops"))
    }

    @Test
    fun codeOutsideSnapshotYearIsNone() {
        val h = habit(days = days(mapOf(LocalDate.of(2026, 12, 31) to 'c')))
        assertEquals(DayCode.CHECK, h.code(LocalDate.of(2026, 12, 31)))
        assertEquals(DayCode.NONE, h.code(LocalDate.of(2027, 1, 1)))
    }

    // Pending actions

    @Test
    fun appendIssuesIncreasingSeq() {
        val store = MemoryStore()
        val pending = PendingActionStore(store)
        pending.append("a", today, DayCode.CHECK, null, null, Instant.now())
        pending.append("b", today, DayCode.NONE, null, null, Instant.now())
        assertEquals(listOf(1, 2), pending.pending().map { it.seq })
        assertEquals(2, store.getInt(SharedKeys.PENDING_SEQ))
    }

    @Test
    fun appendPrunesAppliedActions() {
        val store = MemoryStore()
        val pending = PendingActionStore(store)
        pending.append("a", today, DayCode.CHECK, null, null, Instant.now())
        pending.append("b", today, DayCode.CHECK, null, null, Instant.now())
        store.values[SharedKeys.APPLIED_SEQ] = 2
        pending.append("c", today, DayCode.CHECK, null, null, Instant.now())
        assertEquals(listOf("c"), pending.pending().map { it.uuid })
        assertEquals(listOf(3), pending.pending().map { it.seq })
    }

    @Test
    fun appendNeverWritesAppOwnedKeys() {
        val store = MemoryStore()
        PendingActionStore(store).append("a", today, DayCode.CHECK, null, null, Instant.now())
        assertFalse(store.writes.contains(SharedKeys.APPLIED_SEQ))
        assertFalse(store.writes.contains(SharedKeys.SNAPSHOT))
    }

    @Test
    fun writesJsonTheDartDrainerReads() {
        val store = MemoryStore()
        PendingActionStore(store).append("a", today, DayCode.PROGRESS_DONE, 30.0, 30.0, Instant.EPOCH)
        val json = JSONArray(store.getString(SharedKeys.PENDING_ACTIONS)).getJSONObject(0)
        assertEquals(1, json.getInt("seq"))
        assertEquals("a", json.getString("uuid"))
        assertEquals("2026-11-06", json.getString("date"))
        assertEquals("P", json.getString("code"))
        assertEquals(30.0, json.getDouble("value"), 0.0)
        assertEquals("1970-01-01T00:00:00Z", json.getString("at"))
    }

    @Test
    fun booleanActionOmitsValueAndTarget() {
        val store = MemoryStore()
        PendingActionStore(store).append("a", today, DayCode.CHECK, null, null, Instant.EPOCH)
        val json = JSONArray(store.getString(SharedKeys.PENDING_ACTIONS)).getJSONObject(0)
        assertFalse(json.has("value"))
        assertFalse(json.has("target"))
    }

    @Test
    fun recordsTheDayStateShownBeforeTheTap() {
        val store = MemoryStore()
        val pending = PendingActionStore(store)
        pending.append("a", today, DayCode.CHECK, null, null, Instant.EPOCH, from = DayCode.FAIL)
        pending.append("b", today, DayCode.CHECK, null, null, Instant.EPOCH)
        val list = JSONArray(store.getString(SharedKeys.PENDING_ACTIONS))
        assertEquals("f", list.getJSONObject(0).getString("from"))
        assertFalse(list.getJSONObject(1).has("from"))
        assertEquals(listOf(DayCode.FAIL, null), pending.pending().map { it.from })
    }

    @Test
    fun corruptListStartsFresh() {
        val store = MemoryStore()
        store.values[SharedKeys.PENDING_ACTIONS] = "{oops"
        val pending = PendingActionStore(store)
        assertTrue(pending.pending().isEmpty())
        pending.append("a", today, DayCode.CHECK, null, null, Instant.now())
        assertEquals(1, pending.pending().size)
    }

    // Effective state

    @Test
    fun lastPendingActionForSameDayWins() {
        val h = habit()
        assertEquals(DayCode.NONE, effectiveCode(h, today, listOf(action(1, DayCode.CHECK), action(2, DayCode.NONE))))
        assertEquals(DayCode.NONE, effectiveCode(h, today, listOf(action(1, DayCode.CHECK, uuid = "other"))))
    }

    @Test
    fun todayValueFromSnapshotThenPending() {
        val h = habit(type = "numeric", todayProgress = TodayProgress(10.0, 30.0))
        assertEquals(10.0, effectiveTodayValue(h, today, today, emptyList()), 0.0)
        assertEquals(20.0, effectiveTodayValue(h, today, today, listOf(action(1, DayCode.PROGRESS, value = 20.0))), 0.0)
        assertEquals(0.0, effectiveTodayValue(h, today.plusDays(1), today, emptyList()), 0.0)
    }

    @Test
    fun nextStateBooleanToggles() {
        val h = habit()
        assertEquals(DayCode.CHECK, nextState(h, DayCode.NONE, null).code)
        assertEquals(DayCode.NONE, nextState(h, DayCode.CHECK, null).code)
        assertEquals(DayCode.CHECK, nextState(h, DayCode.FAIL, null).code)
    }

    @Test
    fun nextStateNumericAddsPartialAndFlipsAtTarget() {
        val h = habit(type = "numeric")
        assertEquals(NextState(DayCode.PROGRESS, 10.0, 30.0), nextState(h, DayCode.NONE, 0.0))
        assertEquals(NextState(DayCode.PROGRESS_DONE, 30.0, 30.0), nextState(h, DayCode.PROGRESS, 20.0))
    }

    // Streak

    private val done = days(mapOf(today to 'c'))
    private val table = listOf(listOf(3, 1), listOf(4, 5))

    @Test
    fun streakToday() {
        val h = habit(streakToday = listOf(3, 4))
        assertEquals(3, streak(h, today, today, emptyList()))
        assertEquals(4, streak(h, today, today, listOf(action(1, DayCode.CHECK))))
    }

    @Test
    fun streakPicksTomorrowTableAfterMidnight() {
        val tomorrow = today.plusDays(1)
        val h = habit(days = done, streakToday = listOf(3, 4), streakTomorrow = table)
        assertEquals(4, streak(h, tomorrow, today, emptyList()))
        assertEquals(5, streak(h, tomorrow, today, listOf(action(1, DayCode.CHECK, date = tomorrow))))
        assertEquals(3, streak(h, tomorrow, today, listOf(action(1, DayCode.NONE))))
    }

    @Test
    fun widgetOnlyTickingKeepsCounting() {
        val h = habit(days = done, streakToday = listOf(3, 4), streakTomorrow = table)
        assertEquals(7, streak(h, today.plusDays(3), today, ticks(listOf(1, 2, 3))))
        assertEquals(6, streak(h, today.plusDays(3), today, ticks(listOf(1, 2))))
    }

    @Test
    fun missedDayRestartsAtOne() {
        val h = habit(days = done, streakToday = listOf(3, 4), streakTomorrow = table)
        assertEquals(1, streak(h, today.plusDays(3), today, ticks(listOf(1, 3))))
    }

    @Test
    fun failEndsStreakUnlessTwoDayRuleBridgesIt() {
        val fail2 = action(8, DayCode.FAIL, date = today.plusDays(2))
        val plain = habit(days = done, streakToday = listOf(3, 4), streakTomorrow = table)
        assertEquals(0, streak(plain, today.plusDays(2), today, ticks(listOf(1)) + fail2))

        val rule = habit(days = done, streakToday = listOf(3, 4), streakTomorrow = table, twoDayRule = true)
        val bridged = ticks(listOf(1)) + fail2 + action(9, DayCode.CHECK, date = today.plusDays(3))
        assertEquals(6, streak(rule, today.plusDays(3), today, bridged))
        val twoFails = listOf(action(8, DayCode.FAIL, date = today.plusDays(1)), fail2.copy(seq = 9))
        assertEquals(0, streak(rule, today.plusDays(2), today, twoFails))
    }

    @Test
    fun formatsAmounts() {
        assertEquals("10", formatAmount(10.0))
        assertEquals("2.5", formatAmount(2.5))
    }
}
