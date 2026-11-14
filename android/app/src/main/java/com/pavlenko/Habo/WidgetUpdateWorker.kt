package com.pavlenko.Habo

import android.content.Context
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.pavlenko.Habo.widgets.HaboWidgets

/** Redraws every Habo widget: at midnight, and after a today-list row's hold ends. */
class WidgetUpdateWorker(
    private val context: Context,
    workerParams: WorkerParameters
) : Worker(context, workerParams) {

    override fun doWork(): Result {
        HaboWidgets.updateAll(context)
        return Result.success()
    }
}
