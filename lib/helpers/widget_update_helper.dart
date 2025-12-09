import 'package:flutter/material.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/services/home_widget_service.dart';
import 'package:habo/widgets/habo_home_widget.dart';
import 'package:habo/widgets/home_widget_data.dart';

/// Helper class to update the home widget
class WidgetUpdateHelper {
  /// Update the home widget with current habits data
  static Future<void> updateHomeWidget(
    BuildContext context,
    List<Habit> habits,
  ) async {
    try {
      // Calculate today's data (current progress)
      final currentData = HomeWidgetHelper.getTodayData(habits);

      // Create empty data for next day (all zeros)
      final emptyData = HomeWidgetData(
        totalHabits: currentData.totalHabits,
        completedHabits: 0,
        skippedHabits: 0,
        failedHabits: 0,
      );

      // Use a dark semi-transparent color that works on both light and dark iOS widget backgrounds
      // iOS widget has its own light/dark mode independent from the app
      final textColor = Colors.black.withValues(alpha: 0.85);

      // Create current state widget
      final currentWidget = HaboHomeWidget(
        data: currentData,
        textColor: textColor,
      );

      // Create empty state widget for next day
      final emptyWidget = HaboHomeWidget(
        data: emptyData,
        textColor: textColor,
      );

      // Update the home widget with both states
      await HomeWidgetService.updateWidget(currentWidget, emptyWidget);
    } catch (e) {
      debugPrint('Error updating home widget: $e');
    }
  }
}
