package com.pavlenko.Habo.widgets

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.graphics.RectF
import android.graphics.Typeface
import android.text.TextPaint
import android.text.TextUtils
import java.time.LocalDate
import kotlin.math.max
import kotlin.math.min
import kotlin.math.roundToInt

/** Colours from the app's `HaboColors` (lib/constants.dart). */
object HaboPalette {
    const val PRIMARY = 0xFF09BF30.toInt()
    const val RED = 0xFFF44336.toInt()
    const val SKIP = 0xFFFBC02D.toInt()
    const val PROGRESS = 0xFF2196F3.toInt()
    /** Flutter `Colors.red[300]`, the app's weekend day number. */
    const val WEEKEND = 0xFFE57373.toInt()
    /** Flutter `Colors.grey`, without alpha. */
    private const val GREY = 0x9E9E9E

    fun grey(alpha: Float): Int = ((alpha * 255).roundToInt() shl 24) or GREY

    /**
     * Fill colour of a day tile, as in the app's calendar row. `null` (a day
     * that hasn't happened yet) is fainter than an empty day.
     */
    fun tile(code: DayCode?): Int = when (code) {
        DayCode.CHECK, DayCode.PROGRESS_DONE -> PRIMARY
        DayCode.FAIL -> RED
        DayCode.SKIP -> SKIP
        DayCode.PROGRESS -> PROGRESS
        DayCode.NONE -> grey(0.28f)
        null -> grey(0.12f)
    }
}

/** What the check-in widget shows for one habit today. */
data class CheckInModel(
    val title: String,
    val streak: Int,
    val isNumeric: Boolean,
    val code: DayCode,
    val value: Double,
    val target: Double,
    val unit: String,
    val today: LocalDate,
    /** The six days before today, oldest first. */
    val recent: List<DayCode>,
)

/** One row of the large today list. */
data class TodayListRow(
    val uuid: String,
    /** Drawn as the row's button; `title` is the habit name. */
    val tile: CheckInModel,
    /** "10 / 30 min" for numeric habits, else null. */
    val amount: String?,
    /** The five days before today, oldest first. */
    val recent: List<DayCode>,
)

/** What the large today list shows. */
data class TodayListModel(val title: String, val date: String, val count: String, val rows: List<TodayListRow>)

/**
 * Geometry shared by [WidgetRenderer.todayList] and the layout's row tap
 * targets (`habo_today_list_widget.xml`), in dp. Keep them in step.
 */
object TodayListLayout {
    const val ROWS = 6
    /** Header height including the gap below it. */
    const val HEADER_DP = 30
    /** Width of the button column at the right of each row. */
    const val BUTTON_DP = 44
}

/** What the year widget shows for one habit. */
data class YearModel(
    val title: String,
    val streak: Int,
    val year: Int,
    val today: LocalDate,
    val doneDays: Int,
    /** State of every day of [year] up to [today]; later days are absent. */
    val codes: Map<LocalDate, DayCode>,
    val monthLabels: List<String>,
)

/** The Material icons the app uses on day buttons, as 24x24 outlines. */
private enum class MaterialIcon(val polygons: List<FloatArray>) {
    CHECK(listOf(floatArrayOf(9f, 16.17f, 4.83f, 12f, 3.41f, 13.41f, 9f, 19f, 21f, 7f, 19.59f, 5.59f))),
    CLOSE(
        listOf(
            floatArrayOf(
                19f, 6.41f, 17.59f, 5f, 12f, 10.59f, 6.41f, 5f, 5f, 6.41f, 10.59f, 12f,
                5f, 17.59f, 6.41f, 19f, 12f, 13.41f, 17.59f, 19f, 19f, 17.59f, 13.41f, 12f,
            ),
        ),
    ),
    LAST_PAGE(
        listOf(
            floatArrayOf(5.59f, 7.41f, 10.18f, 12f, 5.59f, 16.59f, 7f, 18f, 13f, 12f, 7f, 6f),
            floatArrayOf(16f, 6f, 18f, 6f, 18f, 18f, 16f, 18f),
        ),
    ),
    ADD(
        listOf(
            floatArrayOf(
                19f, 13f, 13f, 13f, 13f, 19f, 11f, 19f, 11f, 13f, 5f, 13f,
                5f, 11f, 11f, 11f, 11f, 5f, 13f, 5f, 13f, 11f, 19f, 11f,
            ),
        ),
    ),
}

/**
 * Draws the Habo widgets into bitmaps. Geometry, type and colours mirror the
 * SwiftUI views in ios/HaboWidget so both platforms look the same; all sizes
 * below are the iOS point values, scaled to the widget's actual size.
 */
class WidgetRenderer(context: Context, private val dark: Boolean) {
    private val density = context.resources.displayMetrics.density
    private val bold = loadFont(context, "Nunito-Bold.ttf")
    private val extraBold = loadFont(context, "Nunito-ExtraBold.ttf")

    private val primaryText = if (dark) 0xFFFFFFFF.toInt() else 0xFF000000.toInt()
    private val secondaryText = if (dark) 0x99EBEBF5.toInt() else 0x993C3C43.toInt()

    private val fill = Paint(Paint.ANTI_ALIAS_FLAG).apply { style = Paint.Style.FILL }
    private val stroke = Paint(Paint.ANTI_ALIAS_FLAG).apply { style = Paint.Style.STROKE }
    private val text = TextPaint(Paint.ANTI_ALIAS_FLAG)

    /** The app's typeface ships in the Flutter asset bundle. */
    private fun loadFont(context: Context, file: String): Typeface = try {
        Typeface.createFromAsset(context.assets, "flutter_assets/assets/google_fonts/$file")
    } catch (e: Exception) {
        Typeface.DEFAULT_BOLD
    }

    /** One iOS point in pixels for a widget whose reference side is [sidePx]. */
    private fun unit(sidePx: Int): Float {
        val reference = REFERENCE_SIDE * density
        return density * (sidePx / reference).coerceIn(0.75f, 1.6f)
    }

    fun checkIn(width: Int, height: Int, model: CheckInModel): Bitmap = draw(width, height) { canvas ->
        val u = unit(min(width, height))
        val pad = PADDING * u
        val content = RectF(pad, pad, width - pad, height - pad)

        header(canvas, content, u, model.title, model.streak, detail = null)

        val footerTop = content.bottom - 14 * u
        val footerMid = footerTop + 7 * u
        if (model.isNumeric) {
            val label = "${formatAmount(model.value)} / ${formatAmount(model.target)} ${model.unit}".trim()
            text.typeface = bold
            text.textSize = 12 * u
            text.color = secondaryText
            val fitted = TextUtils.ellipsize(label, text, content.width(), TextUtils.TruncateAt.END).toString()
            centred(canvas, fitted, content.centerX(), footerMid)
        } else {
            val size = 13 * u
            val gap = 4 * u
            var x = content.centerX() - (6 * size + 5 * gap) / 2
            for (code in model.recent) {
                fill.color = HaboPalette.tile(code)
                canvas.drawRoundRect(x, footerMid - size / 2, x + size, footerMid + size / 2, 4 * u, 4 * u, fill)
                x += size + gap
            }
        }

        val tileSize = 68 * u
        val centreY = (content.top + 20 * u + footerTop) / 2
        tile(canvas, content.centerX(), centreY, tileSize, u, model)
    }

    private fun tile(canvas: Canvas, cx: Float, cy: Float, size: Float, u: Float, model: CheckInModel) {
        // Sizes below are for the check-in widget's 68pt tile; smaller tiles scale down.
        val s = size / (68 * u)
        // Small tiles have no room for the percentage: a thicker ring alone.
        val compact = s < 50f / 68f
        val fraction = if (model.target > 0) (model.value / model.target).coerceIn(0.0, 1.0).toFloat() else 0f
        val showsRing = model.isNumeric && !model.code.isDone &&
            model.code != DayCode.FAIL && model.code != DayCode.SKIP && model.value > 0
        val isFilled = model.code != DayCode.NONE || showsRing

        fill.color = when {
            showsRing -> HaboPalette.PROGRESS
            model.code == DayCode.NONE -> HaboPalette.grey(0.18f)
            else -> HaboPalette.tile(model.code)
        }
        val rect = RectF(cx - size / 2, cy - size / 2, cx + size / 2, cy + size / 2)
        canvas.drawRoundRect(rect, size * 0.27f, size * 0.27f, fill)

        if (showsRing) {
            val radius = (if (compact) 22 else 24) * u * s
            stroke.strokeWidth = (if (compact) 3.5f else 5f) * u
            stroke.strokeCap = Paint.Cap.ROUND
            stroke.color = 0x4DFFFFFF
            canvas.drawCircle(cx, cy, radius, stroke)
            stroke.color = 0xFFFFFFFF.toInt()
            canvas.drawArc(cx - radius, cy - radius, cx + radius, cy + radius, -90f, 360f * fraction, false, stroke)
            if (compact) return
            text.typeface = extraBold
            text.textSize = 13 * u
            text.color = 0xFFFFFFFF.toInt()
            centred(canvas, "${(fraction * 100).roundToInt()}%", cx, cy)
            return
        }

        val icon = when (model.code) {
            DayCode.FAIL -> MaterialIcon.CLOSE
            DayCode.SKIP -> MaterialIcon.LAST_PAGE
            DayCode.CHECK, DayCode.PROGRESS_DONE -> MaterialIcon.CHECK
            DayCode.PROGRESS -> MaterialIcon.ADD
            DayCode.NONE -> null
        }
        if (icon != null && isFilled) {
            icon(canvas, icon, cx, cy, 40 * u * s, 0xFFFFFFFF.toInt())
        } else {
            // Unchecked: the day of the month, weekends in red, as in the app.
            text.typeface = extraBold
            text.textSize = max(15f, 30 * s) * u
            text.color = if (model.today.dayOfWeek.value > 5) HaboPalette.WEEKEND else primaryText
            centred(canvas, model.today.dayOfMonth.toString(), cx, cy)
        }
    }

    /**
     * Large list of today's habits. Drawn at fixed dp sizes (not scaled to
     * the widget) so the row tap targets in the layout line up with it; see
     * [TodayListLayout].
     */
    fun todayList(width: Int, height: Int, model: TodayListModel): Bitmap = draw(width, height) { canvas ->
        val u = density
        val pad = PADDING * u
        val content = RectF(pad, pad, width - pad, height - pad)

        // Header: title, date, and the count pill.
        val midY = content.top + 11 * u
        text.typeface = bold
        text.textSize = 13 * u
        val pillWidth = max(28 * u, text.measureText(model.count) + 18 * u)
        fill.color = HaboPalette.PRIMARY
        canvas.drawRoundRect(content.right - pillWidth, midY - 10 * u, content.right, midY + 10 * u, 10 * u, 10 * u, fill)
        text.color = 0xFFFFFFFF.toInt()
        centred(canvas, model.count, content.right - pillWidth / 2, midY)

        text.typeface = extraBold
        text.textSize = 17 * u
        text.color = primaryText
        val titleRoom = content.width() - pillWidth - 8 * u
        val title = TextUtils.ellipsize(model.title, text, titleRoom, TextUtils.TruncateAt.END).toString()
        canvas.drawText(title, content.left, baseline(midY), text)
        val dateX = content.left + text.measureText(title) + 6 * u
        text.typeface = bold
        text.textSize = 12 * u
        text.color = secondaryText
        val dateRoom = content.right - pillWidth - 6 * u - dateX
        if (dateRoom > 0) {
            val date = TextUtils.ellipsize(model.date, text, dateRoom, TextUtils.TruncateAt.END).toString()
            canvas.drawText(date, dateX, baseline(midY), text)
        }

        // Rows: fixed height, so fewer habits leave space rather than stretch.
        val rowsTop = content.top + TodayListLayout.HEADER_DP * u
        val rowHeight = (content.bottom - rowsTop) / TodayListLayout.ROWS
        model.rows.forEachIndexed { index, row ->
            val top = rowsTop + index * rowHeight
            val mid = top + rowHeight / 2
            if (index > 0) {
                fill.color = HaboPalette.grey(0.25f)
                canvas.drawRect(content.left, top, content.right, top + 0.5f * u, fill)
            }

            // Today's button, right-aligned.
            val buttonSize = 36 * u
            val buttonCx = content.right - TodayListLayout.BUTTON_DP * u / 2
            tile(canvas, buttonCx, mid, buttonSize, u, row.tile)

            // The five days before today, oldest faintest.
            val square = 11 * u
            val gap = 3 * u
            val squaresRight = content.right - TodayListLayout.BUTTON_DP * u - 8 * u
            var x = squaresRight - 5 * square - 4 * gap
            val squaresLeft = x
            row.recent.forEachIndexed { i, code ->
                fill.color = HaboPalette.tile(code)
                fill.alpha = ((0.3f + i * 0.175f) * Color.alpha(fill.color)).roundToInt()
                canvas.drawRoundRect(x, mid - square / 2, x + square, mid + square / 2, 3.5f * u, 3.5f * u, fill)
                x += square + gap
            }
            fill.alpha = 255

            // Name, and the amount under it for numeric habits.
            val nameRoom = squaresLeft - 8 * u - content.left
            text.typeface = extraBold
            text.textSize = 15 * u
            text.color = primaryText
            val name = TextUtils.ellipsize(row.tile.title, text, nameRoom, TextUtils.TruncateAt.END).toString()
            if (row.amount == null) {
                canvas.drawText(name, content.left, baseline(mid), text)
            } else {
                canvas.drawText(name, content.left, baseline(mid - 7 * u), text)
                text.typeface = bold
                text.textSize = 11 * u
                text.color = secondaryText
                val amount = TextUtils.ellipsize(row.amount, text, nameRoom, TextUtils.TruncateAt.END).toString()
                canvas.drawText(amount, content.left, baseline(mid + 9 * u), text)
            }
        }
    }

    fun year(width: Int, height: Int, model: YearModel): Bitmap = draw(width, height) { canvas ->
        val u = unit(height)
        val pad = PADDING * u
        val content = RectF(pad, pad, width - pad, height - pad)

        header(canvas, content, u, model.title, model.streak, detail = model)

        val grid = RectF(content.left, content.top + 28 * u, content.right, content.bottom)
        val labelWidth = 11 * u
        val pitchY = grid.height() / 12
        // Columns may breathe a little more than rows, but tiles stay square.
        val pitchX = min((grid.width() - labelWidth) / 31, pitchY * 1.2f)
        val cell = max(1f, min(pitchX, pitchY) * 0.84f)
        val radius = cell * 0.3f
        val top = (pitchY - cell) / 2

        text.typeface = bold
        text.textSize = min(8 * u, pitchY)
        text.color = secondaryText
        stroke.strokeWidth = max(1f, cell * 0.16f)
        stroke.strokeCap = Paint.Cap.BUTT
        stroke.color = primaryText

        for (month in 1..12) {
            val y = grid.top + (month - 1) * pitchY + top
            model.monthLabels.getOrNull(month - 1)?.take(1)?.let { label ->
                val metrics = text.fontMetrics
                canvas.drawText(label, grid.left, y + cell / 2 - (metrics.ascent + metrics.descent) / 2, text)
            }
            val length = LocalDate.of(model.year, month, 1).lengthOfMonth()
            for (day in 1..length) {
                val date = LocalDate.of(model.year, month, day)
                val x = grid.left + labelWidth + (day - 1) * pitchX
                fill.color = HaboPalette.tile(model.codes[date])
                canvas.drawRoundRect(x, y, x + cell, y + cell, radius, radius, fill)
                if (date == model.today) {
                    canvas.drawRoundRect(x, y, x + cell, y + cell, radius, radius, stroke)
                }
            }
        }
    }

    /** Small centred text shown when a widget has nothing to render. */
    fun message(width: Int, height: Int, message: String): Bitmap = draw(width, height) { canvas ->
        val u = unit(min(width, height))
        text.typeface = bold
        text.textSize = 13 * u
        text.color = secondaryText
        val fitted = TextUtils.ellipsize(message, text, width - 2 * PADDING * u, TextUtils.TruncateAt.END).toString()
        centred(canvas, fitted, width / 2f, height / 2f)
    }

    /**
     * Habit title on the left, streak pill on the right. The year widget
     * adds the year after the title and the days-done count before the pill.
     */
    private fun header(canvas: Canvas, content: RectF, u: Float, title: String, streak: Int, detail: YearModel?) {
        val midY = content.top + 10 * u
        var right = content.right

        if (streak > 0) {
            val label = streak.toString()
            text.typeface = bold
            text.textSize = 13 * u
            val pillWidth = max(28 * u, text.measureText(label) + 18 * u)
            fill.color = HaboPalette.PRIMARY
            canvas.drawRoundRect(right - pillWidth, midY - 10 * u, right, midY + 10 * u, 10 * u, 10 * u, fill)
            text.color = 0xFFFFFFFF.toInt()
            centred(canvas, label, right - pillWidth / 2, midY)
            right -= pillWidth + 6 * u
        }

        var yearLabel: String? = null
        var yearWidth = 0f
        if (detail != null) {
            text.typeface = bold
            text.textSize = 12 * u
            text.color = secondaryText
            val count = detail.doneDays.toString()
            val countWidth = text.measureText(count)
            canvas.drawText(count, right - countWidth, baseline(midY), text)
            right -= countWidth + 3 * u
            icon(canvas, MaterialIcon.CHECK, right - 6.5f * u, midY, 13 * u, secondaryText)
            right -= 13 * u + 8 * u

            yearLabel = detail.year.toString()
            yearWidth = text.measureText(yearLabel) + 6 * u
        }

        // Title: shrink to 85% before truncating, as on iOS.
        text.typeface = extraBold
        text.color = primaryText
        text.textSize = 15 * u
        val available = max(0f, right - content.left - yearWidth)
        val natural = text.measureText(title)
        if (natural > available) {
            text.textSize = 15 * u * max(0.85f, available / natural)
        }
        val fitted = TextUtils.ellipsize(title, text, available, TextUtils.TruncateAt.END).toString()
        canvas.drawText(fitted, content.left, baseline(midY), text)

        if (yearLabel != null) {
            val x = content.left + text.measureText(fitted) + 6 * u
            text.typeface = bold
            text.textSize = 12 * u
            text.color = secondaryText
            canvas.drawText(yearLabel, x, baseline(midY), text)
        }
    }

    private fun icon(canvas: Canvas, icon: MaterialIcon, cx: Float, cy: Float, size: Float, color: Int) {
        val scale = size / 24
        val path = Path()
        for (polygon in icon.polygons) {
            for (i in polygon.indices step 2) {
                val x = cx + (polygon[i] - 12) * scale
                val y = cy + (polygon[i + 1] - 12) * scale
                if (i == 0) path.moveTo(x, y) else path.lineTo(x, y)
            }
            path.close()
        }
        fill.color = color
        canvas.drawPath(path, fill)
    }

    /** Baseline that vertically centres the current [text] style on [midY]. */
    private fun baseline(midY: Float): Float {
        val metrics = text.fontMetrics
        return midY - (metrics.ascent + metrics.descent) / 2
    }

    private fun centred(canvas: Canvas, label: String, cx: Float, cy: Float) {
        canvas.drawText(label, cx - text.measureText(label) / 2, baseline(cy), text)
    }

    private inline fun draw(width: Int, height: Int, block: (Canvas) -> Unit): Bitmap {
        val bitmap = Bitmap.createBitmap(max(1, width), max(1, height), Bitmap.Config.ARGB_8888)
        block(Canvas(bitmap))
        return bitmap
    }

    companion object {
        /** Side of the iOS small widget, in points; the layout's reference size. */
        const val REFERENCE_SIDE = 158f
        const val PADDING = 16f
    }
}
