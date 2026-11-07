import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';

const String _habitPrefix = '/habit/';

/// Resolves a `/habit/<uuid>` route (from `habo://habit/<uuid>`, used by
/// home-screen widgets) to the habit it names, or null.
///
/// The prefix matches case-insensitively; the uuid keeps its case.
HabitData? resolveHabitDeepLink(String path, List<Habit> habits) {
  if (!path.toLowerCase().startsWith(_habitPrefix)) return null;
  final uuid = path.substring(_habitPrefix.length);
  if (uuid.isEmpty) return null;
  for (final habit in habits) {
    if (habit.habitData.uuid == uuid) return habit.habitData;
  }
  return null;
}
