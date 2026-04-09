package com.pavlenko.Habo

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.res.Configuration
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
    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)

        if (intent.action == Intent.ACTION_CONFIGURATION_CHANGED) {
            updateAllWidgets(context)
        }
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        updateAllWidgets(context)
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

    private fun updateAllWidgets(context: Context) {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(
            ComponentName(context, HaboWidget::class.java)
        )

        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    // Get data from HomeWidget
    val widgetData = HomeWidgetPlugin.getData(context)
    val filenameCurrentLight = widgetData.getString("filename_light", null)
        ?: widgetData.getString("filename", null)
    val filenameCurrentDark = widgetData.getString("filename_dark", null)
        ?: filenameCurrentLight
    val filenameEmptyLight = widgetData.getString("filename_empty_light", null)
        ?: widgetData.getString("filename_empty", null)
    val filenameEmptyDark = widgetData.getString("filename_empty_dark", null)
        ?: filenameEmptyLight
    val lastUpdateDateString = widgetData.getString("lastUpdateDate", null)
    val isDarkMode =
        (context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) ==
            Configuration.UI_MODE_NIGHT_YES
    
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
    
    // Choose themed image based on system light/dark mode.
    val filename = if (shouldShowEmpty) {
        if (isDarkMode) filenameEmptyDark else filenameEmptyLight
    } else {
        if (isDarkMode) filenameCurrentDark else filenameCurrentLight
    }

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