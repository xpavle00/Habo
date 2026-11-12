package com.pavlenko.Habo.widgets

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
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
            val radius = 24 * u
            stroke.strokeWidth = 5 * u
            stroke.strokeCap = Paint.Cap.ROUND
            stroke.color = 0x4DFFFFFF
            canvas.drawCircle(cx, cy, radius, stroke)
            stroke.color = 0xFFFFFFFF.toInt()
            canvas.drawArc(cx - radius, cy - radius, cx + radius, cy + radius, -90f, 360f * fraction, false, stroke)
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
            icon(canvas, icon, cx, cy, 40 * u, 0xFFFFFFFF.toInt())
        } else {
            // Unchecked: the day of the month, weekends in red, as in the app.
            text.typeface = extraBold
            text.textSize = 30 * u
            text.color = if (model.today.dayOfWeek.value > 5) HaboPalette.WEEKEND else primaryText
            centred(canvas, model.today.dayOfMonth.toString(), cx, cy)
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
