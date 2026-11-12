package com.pavlenko.Habo.widgets

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import com.pavlenko.Habo.R
import com.pavlenko.Habo.WidgetUpdateWorker
import es.antonborri.home_widget.HomeWidgetPlugin
import java.time.Duration
import java.time.Instant
import java.time.LocalDate
import java.time.LocalDateTime
import java.util.concurrent.TimeUnit
import kotlin.math.roundToInt

/** [KeyValueStore] over the preferences the Flutter app writes through `home_widget`. */
class PrefsStore(private val prefs: SharedPreferences) : KeyValueStore {
    override fun getString(key: String): String? = prefs.all[key] as? String

    // Dart ints arrive as Int or Long depending on size.
    override fun getInt(key: String): Int = (prefs.all[key] as? Number)?.toInt() ?: 0

    override fun putString(key: String, value: String) {
        prefs.edit().putString(key, value).commit()
    }

    override fun putInt(key: String, value: Int) {
        prefs.edit().putInt(key, value).commit()
    }
}

/** Everything a native Habo widget renders: the app's snapshot plus pending taps. */
class WidgetData(val snapshot: Snapshot?, val pending: List<PendingAction>, val today: LocalDate) {
    companion object {
        fun load(context: Context): WidgetData {
            val store = PrefsStore(HomeWidgetPlugin.getData(context))
            return WidgetData(
                snapshot = Snapshot.parse(store.getString(SharedKeys.SNAPSHOT)),
                pending = PendingActionStore(store).pending(),
                today = LocalDate.now(),
            )
        }
    }
}

/** Which habit each placed widget shows. Owned by the widget code only. */
object WidgetSelection {
    private const val PREFS = "habo_widget_selection"

    private fun prefs(context: Context) = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    fun get(context: Context, appWidgetId: Int): String? =
        prefs(context).getString("habit_$appWidgetId", null)

    fun set(context: Context, appWidgetId: Int, uuid: String) {
        prefs(context).edit().putString("habit_$appWidgetId", uuid).apply()
    }

    fun clear(context: Context, appWidgetIds: IntArray) {
        val editor = prefs(context).edit()
        appWidgetIds.forEach { editor.remove("habit_$it") }
        editor.apply()
    }

    /**
     * The habit a widget shows: its stored choice, or the first habit when
     * nothing was chosen. A stored choice that no longer exists resolves to
     * null so the widget says "choose a habit" rather than switching habit.
     */
    fun resolve(context: Context, appWidgetId: Int, snapshot: Snapshot): SnapshotHabit? {
        val stored = get(context, appWidgetId) ?: return snapshot.habits.firstOrNull()
        return snapshot.habit(stored)
    }
}

object HaboWidgets {
    private const val MIDNIGHT_WORK = "midnightUpdate"

    private val providers = listOf(CheckInWidgetProvider::class.java, YearWidgetProvider::class.java)

    /** Redraws every placed check-in and year widget. */
    fun updateAll(context: Context) {
        val manager = AppWidgetManager.getInstance(context)
        for (provider in providers) {
            val ids = manager.getAppWidgetIds(ComponentName(context, provider))
            if (ids.isEmpty()) continue
            context.sendBroadcast(
                Intent(context, provider)
                    .setAction(AppWidgetManager.ACTION_APPWIDGET_UPDATE)
                    .putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids),
            )
        }
    }

    /** Daily refresh so "today" rolls over without the app running. */
    fun scheduleMidnightUpdate(context: Context) {
        val now = LocalDateTime.now()
        val midnight = now.toLocalDate().plusDays(1).atStartOfDay()
        val work = PeriodicWorkRequestBuilder<WidgetUpdateWorker>(24, TimeUnit.HOURS)
            .setInitialDelay(Duration.between(now, midnight).toMinutes() + 1, TimeUnit.MINUTES)
            .build()
        WorkManager.getInstance(context)
            .enqueueUniquePeriodicWork(MIDNIGHT_WORK, ExistingPeriodicWorkPolicy.UPDATE, work)
    }

    /** Opens Habo's main screen. */
    fun openAppIntent(context: Context): PendingIntent? {
        val launch = context.packageManager.getLaunchIntentForPackage(context.packageName) ?: return null
        return PendingIntent.getActivity(
            context, 0, launch, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }
}

/**
 * Base for widgets drawn as bitmaps from the shared snapshot.
 *
 * The layout holds a light and a dark image; resources make only the one
 * matching the launcher's theme visible, so a theme switch needs no redraw.
 */
abstract class SnapshotWidgetProvider : AppWidgetProvider() {
    protected abstract val layoutId: Int
    protected abstract val defaultWidthDp: Int
    protected abstract val defaultHeightDp: Int

    /** Draws one widget for one theme. */
    protected abstract fun render(
        context: Context,
        renderer: WidgetRenderer,
        width: Int,
        height: Int,
        data: WidgetData,
        appWidgetId: Int,
    ): Bitmap

    /** Hook for click targets beyond "tap opens the app". */
    protected open fun bindClicks(context: Context, views: RemoteViews, appWidgetId: Int) = Unit

    override fun onUpdate(context: Context, manager: AppWidgetManager, appWidgetIds: IntArray) {
        val data = WidgetData.load(context)
        appWidgetIds.forEach { update(context, manager, it, data) }
        HaboWidgets.scheduleMidnightUpdate(context)
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        manager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle,
    ) {
        update(context, manager, appWidgetId, WidgetData.load(context))
    }

    override fun onDeleted(context: Context, appWidgetIds: IntArray) {
        WidgetSelection.clear(context, appWidgetIds)
    }

    private fun update(context: Context, manager: AppWidgetManager, appWidgetId: Int, data: WidgetData) {
        val density = context.resources.displayMetrics.density
        val options = manager.getAppWidgetOptions(appWidgetId)
        // Portrait size: narrowest width, tallest height.
        val widthDp = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH).takeIf { it > 0 } ?: defaultWidthDp
        val heightDp = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT).takeIf { it > 0 } ?: defaultHeightDp
        val width = (widthDp * density).roundToInt().coerceIn(1, MAX_SIDE_PX)
        val height = (heightDp * density).roundToInt().coerceIn(1, MAX_SIDE_PX)

        fun bitmap(dark: Boolean) =
            render(context, WidgetRenderer(context, dark), width, height, data, appWidgetId)

        val views = RemoteViews(context.packageName, layoutId)
        when (data.snapshot?.theme ?: WidgetTheme.DEVICE) {
            WidgetTheme.DEVICE -> {
                views.setImageViewBitmap(R.id.image_light, bitmap(dark = false))
                views.setImageViewBitmap(R.id.image_dark, bitmap(dark = true))
            }
            // Forced theme: the same image whichever one the launcher shows,
            // on a background that ignores the phone's appearance.
            WidgetTheme.LIGHT -> forceTheme(views, bitmap(dark = false), R.drawable.habo_native_widget_bg_light)
            WidgetTheme.DARK -> forceTheme(views, bitmap(dark = true), R.drawable.habo_native_widget_bg_dark)
        }
        views.setOnClickPendingIntent(android.R.id.background, HaboWidgets.openAppIntent(context))
        bindClicks(context, views, appWidgetId)
        manager.updateAppWidget(appWidgetId, views)
    }

    private fun forceTheme(views: RemoteViews, image: Bitmap, backgroundRes: Int) {
        views.setImageViewBitmap(R.id.image_light, image)
        views.setImageViewBitmap(R.id.image_dark, image)
        views.setInt(android.R.id.background, "setBackgroundResource", backgroundRes)
    }

    /** Text for a widget that has no habit to show. */
    protected fun emptyMessage(data: WidgetData): String {
        val snapshot = data.snapshot ?: return "Add a habit in Habo"
        return if (snapshot.habits.isEmpty()) snapshot.labels.noHabits else snapshot.labels.chooseHabit
    }

    private companion object {
        const val MAX_SIDE_PX = 1400
    }
}

/**
 * Small widget for one habit: tap the tile to check it (or add progress)
 * without opening Habo. Tapping elsewhere opens the app.
 */
class CheckInWidgetProvider : SnapshotWidgetProvider() {
    override val layoutId = R.layout.habo_checkin_widget
    override val defaultWidthDp = 160
    override val defaultHeightDp = 160

    override fun render(
        context: Context,
        renderer: WidgetRenderer,
        width: Int,
        height: Int,
        data: WidgetData,
        appWidgetId: Int,
    ): Bitmap {
        val snapshot = data.snapshot
        val habit = snapshot?.let { WidgetSelection.resolve(context, appWidgetId, it) }
            ?: return renderer.message(width, height, emptyMessage(data))
        val today = data.today
        val model = CheckInModel(
            title = habit.title,
            streak = streak(habit, today, snapshot.date, data.pending),
            isNumeric = habit.isNumeric,
            code = effectiveCode(habit, today, data.pending),
            value = effectiveTodayValue(habit, today, snapshot.date, data.pending),
            target = effectiveTodayTarget(habit, today, snapshot.date),
            unit = habit.unit,
            today = today,
            recent = (6 downTo 1).map { effectiveCode(habit, today.minusDays(it.toLong()), data.pending) },
        )
        return renderer.checkIn(width, height, model)
    }

    override fun bindClicks(context: Context, views: RemoteViews, appWidgetId: Int) {
        val tap = Intent(context, CheckInWidgetProvider::class.java)
            .setAction(ACTION_TAP)
            .setData(Uri.parse("habo://widget-tap/$appWidgetId"))
            .putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
        views.setOnClickPendingIntent(
            R.id.tile_hit,
            PendingIntent.getBroadcast(
                context, appWidgetId, tap, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            ),
        )
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == ACTION_TAP) {
            val id = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
            if (id != AppWidgetManager.INVALID_APPWIDGET_ID) handleTap(context, id)
            return
        }
        super.onReceive(context, intent)
    }

    /**
     * Records the resulting state for today as a pending action (the app
     * applies it on next launch or resume), then redraws every Habo widget
     * so they all show the tap at once.
     */
    private fun handleTap(context: Context, appWidgetId: Int) {
        val store = PrefsStore(HomeWidgetPlugin.getData(context))
        val snapshot = Snapshot.parse(store.getString(SharedKeys.SNAPSHOT)) ?: return
        val habit = WidgetSelection.resolve(context, appWidgetId, snapshot) ?: return
        val today = LocalDate.now()
        val actions = PendingActionStore(store)
        val pending = actions.pending()
        val current = effectiveCode(habit, today, pending)
        val value = effectiveTodayValue(habit, today, snapshot.date, pending)
        val target = effectiveTodayTarget(habit, today, snapshot.date)
        val next = nextState(habit, current, value, target)
        actions.append(habit.uuid, today, next.code, next.value, next.target, Instant.now())
        HaboWidgets.updateAll(context)
    }

    companion object {
        const val ACTION_TAP = "com.pavlenko.Habo.widgets.TAP"
    }
}

/** Medium widget: the current calendar year for one habit, one row per month. */
class YearWidgetProvider : SnapshotWidgetProvider() {
    override val layoutId = R.layout.habo_year_widget
    override val defaultWidthDp = 320
    override val defaultHeightDp = 160

    override fun render(
        context: Context,
        renderer: WidgetRenderer,
        width: Int,
        height: Int,
        data: WidgetData,
        appWidgetId: Int,
    ): Bitmap {
        val snapshot = data.snapshot
        val habit = snapshot?.let { WidgetSelection.resolve(context, appWidgetId, it) }
            ?: return renderer.message(width, height, emptyMessage(data))
        val today = data.today
        val codes = mutableMapOf<LocalDate, DayCode>()
        var date = LocalDate.of(today.year, 1, 1)
        while (!date.isAfter(today)) {
            codes[date] = effectiveCode(habit, date, data.pending)
            date = date.plusDays(1)
        }
        val model = YearModel(
            title = habit.title,
            streak = streak(habit, today, snapshot.date, data.pending),
            year = today.year,
            today = today,
            doneDays = codes.values.count { it.isDone },
            codes = codes,
            monthLabels = snapshot.labels.months,
        )
        return renderer.year(width, height, model)
    }
}
