package com.pavlenko.Habo

import android.content.Context
import android.graphics.Bitmap
import com.pavlenko.Habo.widgets.SnapshotWidgetProvider
import com.pavlenko.Habo.widgets.WidgetData
import com.pavlenko.Habo.widgets.WidgetRenderer
import com.pavlenko.Habo.widgets.todaySummary

/**
 * "Habits today" ring, drawn natively from the shared snapshot so it shows
 * widget taps at once, like the other Habo widgets. The class name is kept
 * from the old Flutter-rendered image widget so placed widgets keep working.
 */
class HaboWidget : SnapshotWidgetProvider() {
    override val layoutId = R.layout.habo_widget
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
        // Right after an update, before Habo has run once and written the
        // snapshot: don't show a misleading 0/0.
        val snapshot = data.snapshot
            ?: return renderer.message(width, height, context.getString(R.string.habo_widget_open_app))
        return renderer.today(
            width,
            height,
            snapshot.labels.habitsToday,
            todaySummary(snapshot.habits, data.today, data.pending),
        )
    }
}
