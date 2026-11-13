package com.pavlenko.Habo.widgets

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.TextView
import com.pavlenko.Habo.R
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Lets the user pick which habit a check-in or year widget shows. Opened
 * by the launcher when a widget is added or reconfigured.
 */
class HabitPickerActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Backing out must leave the widget as it was.
        setResult(RESULT_CANCELED)

        val appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID,
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID
        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish()
            return
        }

        val snapshot = Snapshot.parse(HomeWidgetPlugin.getData(this).getString(SharedKeys.SNAPSHOT, null))
        val habits = snapshot?.habits.orEmpty()
        title = snapshot?.labels?.chooseHabit ?: getString(R.string.habo_widget_choose_habit)

        if (habits.isEmpty()) {
            setContentView(
                TextView(this).apply {
                    text = snapshot?.labels?.noHabits ?: getString(R.string.habo_widget_no_habits)
                    val pad = (24 * resources.displayMetrics.density).toInt()
                    setPadding(pad, pad, pad, pad)
                },
            )
            return
        }

        val list = ListView(this)
        list.choiceMode = ListView.CHOICE_MODE_SINGLE
        list.adapter = ArrayAdapter(
            this,
            android.R.layout.simple_list_item_single_choice,
            habits.map { it.title },
        )
        val current = WidgetSelection.get(this, appWidgetId) ?: habits.first().uuid
        habits.indexOfFirst { it.uuid == current }.takeIf { it >= 0 }?.let { list.setItemChecked(it, true) }
        list.setOnItemClickListener { _, _, position, _ ->
            WidgetSelection.set(this, appWidgetId, habits[position].uuid)
            HaboWidgets.updateAll(this)
            setResult(RESULT_OK, Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId))
            finish()
        }
        setContentView(list)
    }
}
