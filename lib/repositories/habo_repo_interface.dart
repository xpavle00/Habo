import 'package:habo/habits/habit.dart';

abstract class HaboRepoInterface {
  Future<void> deleteEvent(int id, DateTime dateTime);
  Future<void> deleteHabit(int id);

  // equavlent of Future<void> emptyTables() for the current version
  Future<void> clearDatabase();
  Future<void> useBackup(List<Habit> habits);
  Future<void> editHabit(Habit habit);
  Future<List<Habit>> getAllHabits();
  Future<void> insertEvent(int id, DateTime date, List event);
  Future<int> insertHabit(Habit habit);
  Future<void> updateOrder(List<Habit> habits); 
  
}
