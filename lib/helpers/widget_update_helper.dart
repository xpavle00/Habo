import 'package:flutter/material.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/services/home_widget_service.dart';
import 'package:habo/widgets/habo_home_widget.dart';
import 'package:habo/widgets/home_widget_data.dart';
import 'package:habo/generated/l10n.dart';

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

      final lightTextColor = Colors.black.withValues(alpha: 0.85);
      final darkTextColor = Colors.white.withValues(alpha: 0.92);

      // Create current state widgets for both light/dark system themes.
      final currentWidgetLight = HaboHomeWidget(
        data: currentData,
        textColor: lightTextColor,
        date: DateTime.now(),
        title: S.of(context).habitsToday,
      );

      final currentWidgetDark = HaboHomeWidget(
        data: currentData,
        textColor: darkTextColor,
        date: DateTime.now(),
        title: S.of(context).habitsToday,
      );

      // Create empty state widgets for next day.
      final emptyWidgetLight = HaboHomeWidget(
        data: emptyData,
        textColor: lightTextColor,
        date: DateTime.now().add(const Duration(days: 1)),
        title: S.of(context).habitsToday,
      );

      final emptyWidgetDark = HaboHomeWidget(
        data: emptyData,
        textColor: darkTextColor,
        date: DateTime.now().add(const Duration(days: 1)),
        title: S.of(context).habitsToday,
      );

      // Update the home widget with both states and both themes.
      await HomeWidgetService.updateWidget(
        currentWidgetLight,
        currentWidgetDark,
        emptyWidgetLight,
        emptyWidgetDark,
      );
    } catch (e) {
      debugPrint('Error updating home widget: $e');
    }
  }
}
