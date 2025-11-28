package com.pavlenko.Habo

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.net.Uri
import android.widget.RemoteViews
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import es.antonborri.home_widget.HomeWidgetPlugin
import java.io.File
import java.util.concurrent.TimeUnit

/**
 * Implementation of App Widget functionality.
 */
class HaboWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
        scheduleMidnightUpdate(context)
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)
        scheduleMidnightUpdate(context)
    }

    private fun scheduleMidnightUpdate(context: Context) {
        val now = java.time.LocalDateTime.now()
        val midnight = now.toLocalDate().plusDays(1).atStartOfDay()
        val initialDelay = java.time.Duration.between(now, midnight).toMinutes()

        val midnightWork = PeriodicWorkRequestBuilder<WidgetUpdateWorker>(
            24, TimeUnit.HOURS
        )
            .setInitialDelay(initialDelay, TimeUnit.MINUTES)
            .build()

        WorkManager.getInstance(context).enqueueUniquePeriodicWork(
            "midnightUpdate",
            ExistingPeriodicWorkPolicy.UPDATE,
            midnightWork
        )
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    // Get data from HomeWidget
    val widgetData = HomeWidgetPlugin.getData(context)
    val filenameCurrent = widgetData.getString("filename", null)
    val filenameEmpty = widgetData.getString("filename_empty", null)
    val lastUpdateDateString = widgetData.getString("lastUpdateDate", null)
    
    // Determine which image to show based on date
    var shouldShowEmpty = false
    if (lastUpdateDateString != null) {
        try {
            val lastDay = try {
                val lastUpdateInstant = java.time.Instant.parse(lastUpdateDateString)
                java.time.LocalDate.ofInstant(lastUpdateInstant, java.time.ZoneId.systemDefault())
            } catch (parseInstant: java.time.format.DateTimeParseException) {
                val lastUpdateLocalDateTime = java.time.LocalDateTime.parse(
                    lastUpdateDateString,
                    java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME
                )
                lastUpdateLocalDateTime.toLocalDate()
            }
            val today = java.time.LocalDate.now()
            shouldShowEmpty = today.isAfter(lastDay)
        } catch (e: Throwable) {
            // If parsing fails, use current state
            shouldShowEmpty = false
        }
    }
    
    // Choose the appropriate filename
    val filename = if (shouldShowEmpty && filenameEmpty != null) filenameEmpty else filenameCurrent

    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.habo_widget)
    
    // Create intent to open the app when widget is clicked
    val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
    val pendingIntent = PendingIntent.getActivity(
        context,
        0,
        intent,
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )
    views.setOnClickPendingIntent(R.id.widget_image, pendingIntent)
    
    // Try to load the image from the filename
    if (filename != null) {
        val imageFile = File(filename)
        if (imageFile.exists()) {
            try {
                // Load the bitmap from file
                val bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                if (bitmap != null) {
                    // Set the image to the ImageView
                    views.setImageViewBitmap(R.id.widget_image, bitmap)
                } else {
                    // Failed to decode bitmap, show placeholder
                    views.setImageViewResource(R.id.widget_image, android.R.drawable.ic_menu_gallery)
                }
            } catch (e: Exception) {
                // Error loading image, show placeholder
                views.setImageViewResource(R.id.widget_image, android.R.drawable.ic_menu_gallery)
            }
        } else {
            // File doesn't exist, show placeholder
            views.setImageViewResource(R.id.widget_image, android.R.drawable.ic_menu_gallery)
        }
    } else {
        // No filename, show placeholder
        views.setImageViewResource(R.id.widget_image, android.R.drawable.ic_menu_gallery)
    }

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}