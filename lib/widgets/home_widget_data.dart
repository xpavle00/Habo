import 'package:habo/constants.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/helpers.dart';

/// Data model for home widget
class HomeWidgetData {
  final int totalHabits;
  final int completedHabits;
  final int skippedHabits;
  final int failedHabits;
  final double completionPercentage;
  
  HomeWidgetData({
    required this.totalHabits,
    required this.completedHabits,
    this.skippedHabits = 0,
    this.failedHabits = 0,
  }) : completionPercentage = totalHabits > 0 
      ? (completedHabits / totalHabits * 100) 
      : 0.0;
}

/// Helper class to calculate widget data from habits
class HomeWidgetHelper {
  /// Calculate today's habit completion data
  static HomeWidgetData getTodayData(List<Habit> habits) {
    final today = DateTime.now();
    final todayDate = transformDate(today); // Use transformDate to match event keys
    
    // Filter out archived habits
    final activeHabits = habits.where((habit) => !habit.habitData.archived).toList();
    
    int totalHabits = activeHabits.length;
    int completedHabits = 0;
    int skippedHabits = 0;
    int failedHabits = 0;
    
    for (var habit in activeHabits) {
      final event = habit.habitData.events[todayDate];
      if (event != null && event.isNotEmpty) {
        final dayType = event[0] as DayType;
        // Count as completed if it's checked or 100% progress
        if (dayType == DayType.check) {
          completedHabits++;
        } else if (dayType == DayType.progress) {
          // Check if progress is 100% (>= targetValue)
          if (event.length > 2 && habit.habitData.isNumeric) {
            final progressValue = (event[2] as num?)?.toDouble() ?? 0.0;
            if (progressValue >= habit.habitData.targetValue) {
              completedHabits++;
            }
          }
        } else if (dayType == DayType.skip) {
          skippedHabits++;
        } else if (dayType == DayType.fail) {
          failedHabits++;
        }
      }
    }
    
    return HomeWidgetData(
      totalHabits: totalHabits,
      completedHabits: completedHabits,
      skippedHabits: skippedHabits,
      failedHabits: failedHabits,
    );
  }
}
