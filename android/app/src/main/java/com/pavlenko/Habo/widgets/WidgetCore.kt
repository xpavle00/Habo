package com.pavlenko.Habo.widgets

import org.json.JSONArray
import org.json.JSONObject
import java.time.Instant
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

/*
 * Kotlin port of ios/HaboWidgetCore. Both platforms read the same snapshot
 * and write the same pending-action queue, so behaviour must stay in step
 * with the Swift sources (and with `lib/home_widgets` in Dart).
 */

/**
 * Keys in the storage shared with the Flutter app. Each key has exactly one
 * writer: the app writes [SNAPSHOT] and [APPLIED_SEQ], widget code writes
 * [PENDING_ACTIONS] and [PENDING_SEQ]. Must match `WidgetKeys` in Dart.
 */
object SharedKeys {
    const val SNAPSHOT = "widget_snapshot"
    const val APPLIED_SEQ = "widget_applied_seq"
    const val PENDING_ACTIONS = "widget_pending_actions"
    const val PENDING_SEQ = "widget_pending_seq"
}

/** One day's state, encoded as a single character in the snapshot. */
enum class DayCode(val raw: Char) {
    NONE('.'),
    CHECK('c'),
    FAIL('f'),
    SKIP('s'),
    PROGRESS('p'),
    PROGRESS_DONE('P');

    val isDone: Boolean get() = this == CHECK || this == PROGRESS_DONE

    companion object {
        fun from(raw: Char): DayCode? = entries.firstOrNull { it.raw == raw }
    }
}

/** The app's "Widget theme" setting; [DEVICE] follows the phone. */
enum class WidgetTheme {
    DEVICE,
    LIGHT,
    DARK;

    companion object {
        /** Unknown or missing values (older snapshots) mean [DEVICE]. */
        fun from(raw: String?): WidgetTheme = when (raw) {
            "light" -> LIGHT
            "dark" -> DARK
            else -> DEVICE
        }
    }
}

data class Labels(
    val habitsToday: String,
    val chooseHabit: String,
    val noHabits: String,
    val months: List<String>,
)

data class Reminder(val hour: Int, val minute: Int)

data class TodayProgress(val value: Double, val target: Double)

/** See the Dart builder: `today = [ifNotDone, ifDone]`, `tomorrow[todayDone][tomorrowDone]`. */
data class StreakTable(val today: List<Int>, val tomorrow: List<List<Int>>)

data class SnapshotHabit(
    val uuid: String,
    val id: Int?,
    val title: String,
    val type: String,
    val target: Double,
    val partial: Double,
    val unit: String,
    val position: Int,
    val twoDayRule: Boolean,
    val reminder: Reminder?,
    val year: Int,
    val days: String,
    val today: TodayProgress?,
    val streak: StreakTable,
) {
    val isNumeric: Boolean get() = type == "numeric"

    /** Snapshot state for [date]; [DayCode.NONE] outside the snapshot's year. */
    fun code(date: LocalDate): DayCode {
        if (date.year != year) return DayCode.NONE
        val index = date.dayOfYear - 1
        if (index < 0 || index >= days.length) return DayCode.NONE
        return DayCode.from(days[index]) ?: DayCode.NONE
    }
}

data class Snapshot(
    val v: Int,
    val date: LocalDate,
    val weekStart: Int,
    val theme: WidgetTheme,
    val labels: Labels,
    val habits: List<SnapshotHabit>,
) {
    fun habit(uuid: String): SnapshotHabit? = habits.firstOrNull { it.uuid == uuid }

    companion object {
        /** Parses the snapshot the app wrote, or null if missing or unreadable. */
        fun parse(raw: String?): Snapshot? {
            if (raw == null) return null
            return try {
                val json = JSONObject(raw)
                val labels = json.getJSONObject("labels")
                Snapshot(
                    v = json.getInt("v"),
                    date = LocalDate.parse(json.getString("date")),
                    weekStart = json.getInt("weekStart"),
                    theme = WidgetTheme.from(json.optString("theme")),
                    labels = Labels(
                        habitsToday = labels.getString("habitsToday"),
                        chooseHabit = labels.getString("chooseHabit"),
                        noHabits = labels.getString("noHabits"),
                        months = labels.getJSONArray("months").strings(),
                    ),
                    habits = json.getJSONArray("habits").objects().map(::parseHabit),
                )
            } catch (e: Exception) {
                null
            }
        }

        private fun parseHabit(json: JSONObject): SnapshotHabit {
            val streak = json.getJSONObject("streak")
            val tomorrow = streak.getJSONArray("tomorrow")
            return SnapshotHabit(
                uuid = json.getString("uuid"),
                id = if (json.isNull("id")) null else json.getInt("id"),
                title = json.getString("title"),
                type = json.getString("type"),
                target = json.getDouble("target"),
                partial = json.getDouble("partial"),
                unit = json.optString("unit", ""),
                position = json.getInt("position"),
                twoDayRule = json.optBoolean("twoDayRule", false),
                reminder = json.optJSONObject("reminder")?.let {
                    Reminder(it.getInt("hour"), it.getInt("minute"))
                },
                year = json.getInt("year"),
                days = json.getString("days"),
                today = json.optJSONObject("today")?.let {
                    TodayProgress(it.getDouble("value"), it.getDouble("target"))
                },
                streak = StreakTable(
                    today = streak.getJSONArray("today").ints(),
                    tomorrow = (0 until tomorrow.length()).map { tomorrow.getJSONArray(it).ints() },
                ),
            )
        }
    }
}

private fun JSONArray.strings(): List<String> = (0 until length()).map { getString(it) }
private fun JSONArray.ints(): List<Int> = (0 until length()).map { getInt(it) }
private fun JSONArray.objects(): List<JSONObject> = (0 until length()).map { getJSONObject(it) }

/** Minimal key-value storage, so the queue is testable without Android. */
interface KeyValueStore {
    fun getString(key: String): String?
    fun getInt(key: String): Int
    fun putString(key: String, value: String)
    fun putInt(key: String, value: Int)
}

/**
 * A widget tap waiting for the app to apply it. [code] is the resulting
 * state for [date], not a toggle, so it stays correct if data changes
 * before the app drains it.
 */
data class PendingAction(
    val seq: Int,
    val uuid: String,
    val date: LocalDate,
    val code: DayCode,
    val value: Double?,
    val target: Double?,
    val at: String,
) {
    fun toJson(): JSONObject = JSONObject().apply {
        put("at", at)
        put("code", code.raw.toString())
        put("date", date.toString())
        put("seq", seq)
        put("uuid", uuid)
        if (value != null) put("value", value)
        if (target != null) put("target", target)
    }

    companion object {
        fun fromJson(json: JSONObject): PendingAction? {
            val code = json.optString("code").singleOrNull()?.let(DayCode::from) ?: return null
            return try {
                PendingAction(
                    seq = json.getInt("seq"),
                    uuid = json.getString("uuid"),
                    date = LocalDate.parse(json.getString("date")),
                    code = code,
                    value = if (json.has("value") && !json.isNull("value")) json.getDouble("value") else null,
                    target = if (json.has("target") && !json.isNull("target")) json.getDouble("target") else null,
                    at = json.optString("at", ""),
                )
            } catch (e: Exception) {
                null
            }
        }
    }
}

/**
 * Owns `widget_pending_actions` and `widget_pending_seq`. Reads, never
 * writes, the app-owned `widget_applied_seq`.
 */
class PendingActionStore(private val store: KeyValueStore) {
    private fun all(): List<PendingAction> {
        val raw = store.getString(SharedKeys.PENDING_ACTIONS) ?: return emptyList()
        return try {
            val array = JSONArray(raw)
            (0 until array.length()).mapNotNull { PendingAction.fromJson(array.getJSONObject(it)) }
        } catch (e: Exception) {
            emptyList()
        }
    }

    /** Actions not yet applied by the app, in seq order. */
    fun pending(): List<PendingAction> {
        val applied = store.getInt(SharedKeys.APPLIED_SEQ)
        return all().filter { it.seq > applied }.sortedBy { it.seq }
    }

    fun append(
        uuid: String,
        date: LocalDate,
        code: DayCode,
        value: Double?,
        target: Double?,
        at: Instant,
    ): PendingAction {
        val seq = maxOf(store.getInt(SharedKeys.PENDING_SEQ), all().maxOfOrNull { it.seq } ?: 0) + 1
        val stamp = DateTimeFormatter.ISO_INSTANT.format(at.truncatedTo(ChronoUnit.SECONDS))
        val action = PendingAction(seq, uuid, date, code, value, target, stamp)
        val list = JSONArray()
        (pending() + action).forEach { list.put(it.toJson()) }
        store.putString(SharedKeys.PENDING_ACTIONS, list.toString())
        store.putInt(SharedKeys.PENDING_SEQ, seq)
        return action
    }
}

private fun latest(pending: List<PendingAction>, uuid: String, date: LocalDate): PendingAction? =
    pending.filter { it.uuid == uuid && it.date == date }.maxByOrNull { it.seq }

/** The state widgets show for [habit] on [date]: the newest pending tap, else the app's snapshot. */
fun effectiveCode(habit: SnapshotHabit, date: LocalDate, pending: List<PendingAction>): DayCode =
    latest(pending, habit.uuid, date)?.code ?: habit.code(date)

/** Today's numeric progress, including pending taps. */
fun effectiveTodayValue(
    habit: SnapshotHabit,
    today: LocalDate,
    snapshotDate: LocalDate,
    pending: List<PendingAction>,
): Double {
    latest(pending, habit.uuid, today)?.let { action ->
        action.value?.let { return it }
        return if (action.code.isDone) habit.today?.target ?: habit.target else 0.0
    }
    if (today != snapshotDate) return 0.0
    return habit.today?.value ?: 0.0
}

/** Target for today's numeric progress. */
fun effectiveTodayTarget(habit: SnapshotHabit, today: LocalDate, snapshotDate: LocalDate): Double =
    if (today == snapshotDate) habit.today?.target ?: habit.target else habit.target

data class NextState(val code: DayCode, val value: Double?, val target: Double?)

/**
 * The state a tap on the check-in widget moves to.
 *
 * Boolean: done -> cleared, anything else -> checked.
 * Numeric: adds the habit's partial value; done once it reaches the target.
 */
fun nextState(habit: SnapshotHabit, current: DayCode, currentValue: Double?, target: Double? = null): NextState {
    if (habit.isNumeric) {
        val goal = target ?: habit.today?.target ?: habit.target
        val value = (currentValue ?: 0.0) + habit.partial
        return NextState(if (value >= goal) DayCode.PROGRESS_DONE else DayCode.PROGRESS, value, goal)
    }
    return NextState(if (current == DayCode.CHECK) DayCode.NONE else DayCode.CHECK, null, null)
}

/**
 * Current streak shown on widgets.
 *
 * Up to the day after the snapshot it comes from the app's precomputed
 * table. Beyond that the app hasn't run, so it is carried forward day by
 * day over the widget's own taps, following the app's streak rules: a done
 * day extends the run (restarting at 1 after a day with nothing logged),
 * skip and partial progress hold it, and a fail ends it (with the two-day
 * rule, only a second fail in a row does).
 */
fun streak(habit: SnapshotHabit, today: LocalDate, snapshotDate: LocalDate, pending: List<PendingAction>): Int {
    val table = habit.streak
    fun code(date: LocalDate) = effectiveCode(habit, date, pending)

    val snapshotDayDone = if (code(snapshotDate).isDone) 1 else 0
    if (!today.isAfter(snapshotDate)) {
        return table.today.getOrNull(snapshotDayDone) ?: 0
    }
    val tomorrow = snapshotDate.plusDays(1)
    val row = table.tomorrow.getOrNull(snapshotDayDone) ?: emptyList()
    var current = row.getOrNull(if (code(tomorrow).isDone) 1 else 0) ?: 0
    var previous = code(tomorrow)
    var day = tomorrow.plusDays(1)
    while (!day.isAfter(today)) {
        val dayCode = code(day)
        when (dayCode) {
            DayCode.CHECK, DayCode.PROGRESS_DONE ->
                current = if (previous == DayCode.NONE) 1 else current + 1
            DayCode.FAIL ->
                if (!habit.twoDayRule || previous == DayCode.FAIL) current = 0
            DayCode.SKIP, DayCode.PROGRESS, DayCode.NONE -> Unit
        }
        previous = dayCode
        day = day.plusDays(1)
    }
    return current
}

/** `10` for whole numbers, `2.5` otherwise. */
fun formatAmount(value: Double): String =
    if (Math.rint(value) == value) value.toLong().toString() else String.format(java.util.Locale.US, "%.1f", value)

/** Counts for "habits today". Same rules as the Swift `todaySummary`. */
data class TodaySummary(val total: Int, val completed: Int, val skipped: Int, val failed: Int) {
    /** Habits handled today: completed + skipped + failed. */
    val done: Int get() = completed + skipped + failed
}

fun todaySummary(habits: List<SnapshotHabit>, today: LocalDate, pending: List<PendingAction>): TodaySummary {
    var completed = 0
    var skipped = 0
    var failed = 0
    for (habit in habits) {
        when (effectiveCode(habit, today, pending)) {
            DayCode.CHECK, DayCode.PROGRESS_DONE -> completed++
            DayCode.SKIP -> skipped++
            DayCode.FAIL -> failed++
            DayCode.NONE, DayCode.PROGRESS -> Unit
        }
    }
    return TodaySummary(habits.size, completed, skipped, failed)
}

/** Done, failed or skipped. Partial numeric progress still waits for more. */
private fun DayCode.isHandled(): Boolean =
    this == DayCode.CHECK || this == DayCode.PROGRESS_DONE || this == DayCode.FAIL || this == DayCode.SKIP

/** When a just-tapped row's hold ends, or null if [action] didn't handle a habit today. */
private fun holdEnd(action: PendingAction, today: LocalDate, holdSeconds: Long): Instant? {
    if (action.date != today || !action.code.isHandled()) return null
    val tapped = try {
        Instant.parse(action.at)
    } catch (e: Exception) {
        return null
    }
    return tapped.plusSeconds(holdSeconds)
}

/**
 * The habits the large "today" list shows, in app order. Mirrors the Swift
 * `todayListHabits`: everything when it fits; otherwise habits still waiting
 * first, handled ones filling rows left over, and a just-tapped row keeping
 * its place for [holdSeconds].
 */
fun todayListHabits(
    habits: List<SnapshotHabit>,
    today: LocalDate,
    pending: List<PendingAction>,
    now: Instant,
    capacity: Int,
    holdSeconds: Long,
): List<SnapshotHabit> {
    if (habits.size <= capacity) return habits

    val held = pending
        .filter { it.date == today }
        .groupBy { it.uuid }
        .mapNotNull { (uuid, actions) ->
            val newest = actions.maxBy { it.seq }
            val end = holdEnd(newest, today, holdSeconds)
            if (end != null && end.isAfter(now)) uuid else null
        }
        .toSet()

    fun waits(habit: SnapshotHabit) =
        habit.uuid in held || !effectiveCode(habit, today, pending).isHandled()

    val waiting = habits.filter(::waits)
    if (waiting.size >= capacity) return waiting.take(capacity)

    val fillers = habits.filterNot(::waits).take(capacity - waiting.size)
    val chosen = (waiting + fillers).map { it.uuid }.toSet()
    return habits.filter { it.uuid in chosen }
}

/** Future moments when a held row is released, soonest first. */
fun todayListReleaseTimes(
    pending: List<PendingAction>,
    today: LocalDate,
    now: Instant,
    holdSeconds: Long,
): List<Instant> =
    pending.mapNotNull { holdEnd(it, today, holdSeconds) }.filter { it.isAfter(now) }.sorted()
