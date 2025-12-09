import 'dart:collection';
import 'package:habo/model/habo_model.dart';
import 'event_repository.dart';

/// SQLite implementation of the EventRepository interface.
/// This class wraps the existing HaboModel to provide event data access
/// through the repository pattern while maintaining backward compatibility.
class SQLiteEventRepository implements EventRepository {
  final HaboModel _haboModel;

  /// Creates a new SQLiteEventRepository instance.
  ///
  /// [haboModel] The HaboModel instance to use for database operations.
  SQLiteEventRepository(this._haboModel);

  @override
  Future<List<List>> getEventsForHabit(int habitId) async {
    final habits = await _haboModel.getAllHabits();
    final habit = habits.firstWhere((h) => h.habitData.id == habitId);

    // Convert events map to List format
    final eventsMap = habit.habitData.events;
    final events = <List>[];

    eventsMap.forEach((dateTime, data) {
      events.add([dateTime, data[0], data[1]]);
    });

    return events;
  }

  @override
  Future<SplayTreeMap<DateTime, List>> getEventsMapForHabit(int habitId) async {
    final habits = await _haboModel.getAllHabits();
    final habit = habits.firstWhere((h) => h.habitData.id == habitId);
    return habit.habitData.events;
  }

  @override
  Future<void> insertEvent(int habitId, DateTime date, List event) async {
    await _haboModel.insertEvent(habitId, date, event);
  }

  @override
  Future<void> deleteEvent(int habitId, DateTime date) async {
    await _haboModel.deleteEvent(habitId, date);
  }

  @override
  Future<void> deleteAllEventsForHabit(int habitId) async {
    // Get the habit and clear its events
    final habits = await _haboModel.getAllHabits();
    final habit = habits.firstWhere((h) => h.habitData.id == habitId);

    // Clear events by clearing the events map
    habit.habitData.events.clear();
    await _haboModel.editHabit(habit);
  }

  @override
  Future<void> insertEventsForHabit(
      int habitId, Map<DateTime, List> events) async {
    for (final entry in events.entries) {
      await insertEvent(habitId, entry.key, entry.value);
    }
  }

  @override
  Future<void> deleteAllEvents() async {
    // Clear events from all habits
    final habits = await _haboModel.getAllHabits();

    for (final habit in habits) {
      habit.habitData.events.clear();
      await _haboModel.editHabit(habit);
    }
  }
}
