import 'package:habo/habits/habit.dart';

/// Abstract repository interface for habit-related database operations.
/// This interface defines the contract for all habit data access operations.
abstract class HabitRepository {
  /// Retrieves all habits from the database, ordered by position.
  ///
  /// Returns a [Future] containing a [List] of [Habit] objects.
  /// Habits include their complete data including events and metadata.
  Future<List<Habit>> getAllHabits();

  /// Creates a new habit in the database.
  ///
  /// [habit] The habit to be created, including all its properties.
  /// Returns a [Future] containing the ID of the newly created habit.
  Future<int> createHabit(Habit habit);

  /// Updates an existing habit in the database.
  ///
  /// [habit] The habit to be updated with new properties.
  /// Returns a [Future] that completes when the update is successful.
  Future<void> updateHabit(Habit habit);

  /// Deletes a habit from the database.
  ///
  /// [id] The ID of the habit to be deleted.
  /// Returns a [Future] that completes when the deletion is successful.
  Future<void> deleteHabit(int id);

  /// Finds a specific habit by its ID.
  ///
  /// [id] The ID of the habit to find.
  /// Returns a [Future] containing the [Habit] if found, null otherwise.
  Future<Habit?> findHabitById(int id);

  /// Updates the order/position of multiple habits.
  ///
  /// [habits] The list of habits with updated positions.
  /// Returns a [Future] that completes when the order update is successful.
  Future<void> updateHabitsOrder(List<Habit> habits);

  /// Deletes all habits from the database.
  ///
  /// This is primarily used for backup/restore operations.
  /// Returns a [Future] that completes when all habits are deleted.
  Future<void> deleteAllHabits();

  /// Insits multiple habits into the database.
  ///
  /// [habits] The list of habits to be inserted.
  /// This is primarily used for backup/restore operations.
  /// Returns a [Future] that completes when all habits are inserted.
  Future<void> insertHabits(List<Habit> habits);
}
