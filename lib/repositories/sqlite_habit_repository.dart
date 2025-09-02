import 'package:habo/habits/habit.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/repositories/habit_repository.dart';

/// SQLite implementation of the HabitRepository interface.
/// This class wraps the existing HaboModel to provide habit data access
/// through the repository pattern while maintaining backward compatibility.
class SQLiteHabitRepository implements HabitRepository {
  final HaboModel _haboModel;

  /// Creates a new SQLiteHabitRepository instance.
  ///
  /// [haboModel] The HaboModel instance to use for database operations.
  SQLiteHabitRepository(this._haboModel);

  @override
  Future<List<Habit>> getAllHabits() async {
    return await _haboModel.getAllHabits();
  }

  @override
  Future<int> createHabit(Habit habit) async {
    final habitId = await _haboModel.insertHabit(habit);
    return habitId;
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    await _haboModel.editHabit(habit);
  }

  @override
  Future<void> deleteHabit(int id) async {
    await _haboModel.deleteHabit(id);
  }

  @override
  Future<Habit?> findHabitById(int id) async {
    final habits = await _haboModel.getAllHabits();
    try {
      return habits.firstWhere((habit) => habit.habitData.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateHabitsOrder(List<Habit> habits) async {
    await _haboModel.updateOrder(habits);
  }

  @override
  Future<void> deleteAllHabits() async {
    await _haboModel.emptyTables();
  }

  @override
  Future<void> insertHabits(List<Habit> habits) async {
    await _haboModel.useBackup(habits);
  }
}
