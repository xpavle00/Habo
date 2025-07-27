import 'package:habo/model/habo_model.dart';
import 'package:habo/habits/habit.dart';
import 'backup_repository.dart';

/// SQLite implementation of the BackupRepository interface.
/// This class wraps the existing HaboModel to provide backup functionality
/// through the repository pattern while maintaining backward compatibility.
class SQLiteBackupRepository implements BackupRepository {
  final HaboModel _haboModel;

  SQLiteBackupRepository(this._haboModel);

  @override
  Future<Map<String, dynamic>> exportAllData() async {
    final habits = await _haboModel.getAllHabits();
    final data = <String, dynamic>{
      'habits': <dynamic>[],
      'events': <String, dynamic>{},
    };

    for (final habit in habits) {
      // Use the habit's toJson method which includes events
      (data['habits'] as List).add(habit.toJson());
    }

    return data;
  }

  @override
  Future<void> importData(Map<String, dynamic> data) async {
    // Clear existing data
    final habits = await _haboModel.getAllHabits();
    for (final habit in habits) {
      await _haboModel.deleteHabit(habit.habitData.id!);
    }

    final habitsData = data['habits'] as List;
    
    for (final habitJson in habitsData) {
      // Create habit from JSON and insert it
      final habit = Habit.fromJson(habitJson);
      await _haboModel.insertHabit(habit);
    }
  }

  @override
  Future<int> getDatabaseVersion() async {
    return 1;
  }

  @override
  Future<String> getDatabasePath() async {
    return 'habo_database.db';
  }

  @override
  Future<void> closeDatabase() async {
    // HaboModel doesn't have explicit close method
    // This is handled by the existing HaboModel lifecycle
  }

  @override
  Future<void> reopenDatabase() async {
    // HaboModel doesn't have explicit reopen method
    // This is handled by the existing HaboModel lifecycle
  }

  @override
  Future<int> getHabitCount() async {
    final habits = await _haboModel.getAllHabits();
    return habits.length;
  }

  @override
  Future<int> getEventCount() async {
    final habits = await _haboModel.getAllHabits();
    int eventCount = 0;
    for (final habit in habits) {
      eventCount += habit.habitData.events.length;
    }
    return eventCount;
  }

  @override
  Future<bool> validateDatabaseIntegrity() async {
    try {
      await _haboModel.getAllHabits();
      return true;
    } catch (e) {
      return false;
    }
  }
}
