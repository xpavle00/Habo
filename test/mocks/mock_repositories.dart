import 'dart:collection';
import 'package:mocktail/mocktail.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/repositories/habit_repository.dart';
import 'package:habo/repositories/event_repository.dart';
import 'package:habo/repositories/backup_repository.dart';

/// Mock implementation of HabitRepository for testing
class MockHabitRepository extends Mock implements HabitRepository {}

/// Mock implementation of EventRepository for testing  
class MockEventRepository extends Mock implements EventRepository {}

/// Mock implementation of BackupRepository for testing
class MockBackupRepository extends Mock implements BackupRepository {}

/// In-memory implementation of HabitRepository for testing
/// 
/// Provides a real implementation that stores data in memory
/// instead of a database, useful for integration testing.
class InMemoryHabitRepository implements HabitRepository {
  final List<Habit> _habits = [];
  int _nextId = 1;

  @override
  Future<List<Habit>> getAllHabits() async {
    return List.from(_habits);
  }

  @override
  Future<int> createHabit(Habit habit) async {
    final id = _nextId++;
    habit.setId = id;
    _habits.add(habit);
    return id;
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final index = _habits.indexWhere((h) => h.habitData.id == habit.habitData.id);
    if (index != -1) {
      _habits[index] = habit;
    }
  }

  @override
  Future<void> deleteHabit(int id) async {
    _habits.removeWhere((habit) => habit.habitData.id == id);
  }

  @override
  Future<Habit?> findHabitById(int id) async {
    try {
      return _habits.firstWhere((habit) => habit.habitData.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateHabitsOrder(List<Habit> habits) async {
    // Update positions in memory
    for (int i = 0; i < habits.length; i++) {
      habits[i].habitData.position = i;
    }
  }

  @override
  Future<void> deleteAllHabits() async {
    _habits.clear();
  }

  @override
  Future<void> insertHabits(List<Habit> habits) async {
    _habits.clear();
    for (final habit in habits) {
      if (habit.habitData.id == null) {
        habit.setId = _nextId++;
      } else {
        _nextId = habit.habitData.id! + 1;
      }
      _habits.add(habit);
    }
  }

  /// Test helper method to clear all data
  void clear() {
    _habits.clear();
    _nextId = 1;
  }

  /// Test helper method to get habit count
  int get habitCount => _habits.length;
}

/// In-memory implementation of EventRepository for testing
class InMemoryEventRepository implements EventRepository {
  final Map<int, SplayTreeMap<DateTime, List>> _events = {};

  @override
  Future<List<List>> getEventsForHabit(int habitId) async {
    final eventsMap = _events[habitId] ?? SplayTreeMap<DateTime, List>();
    final events = <List>[];
    
    eventsMap.forEach((dateTime, data) {
      events.add([dateTime, data[0], data[1]]);
    });
    
    return events;
  }

  @override
  Future<SplayTreeMap<DateTime, List>> getEventsMapForHabit(int habitId) async {
    return _events[habitId] ?? SplayTreeMap<DateTime, List>();
  }

  @override
  Future<void> insertEvent(int habitId, DateTime date, List event) async {
    _events[habitId] ??= SplayTreeMap<DateTime, List>();
    _events[habitId]![date] = event;
  }

  @override
  Future<void> deleteEvent(int habitId, DateTime date) async {
    _events[habitId]?.remove(date);
  }

  @override
  Future<void> deleteAllEventsForHabit(int habitId) async {
    _events[habitId]?.clear();
  }

  @override
  Future<void> insertEventsForHabit(int habitId, Map<DateTime, List> events) async {
    _events[habitId] ??= SplayTreeMap<DateTime, List>();
    _events[habitId]!.addAll(events);
  }

  @override
  Future<void> deleteAllEvents() async {
    _events.clear();
  }

  /// Test helper method to clear all data
  void clear() {
    _events.clear();
  }

  /// Test helper method to get event count for a habit
  int getEventCountForHabit(int habitId) {
    return _events[habitId]?.length ?? 0;
  }
}

/// In-memory implementation of BackupRepository for testing
class InMemoryBackupRepository implements BackupRepository {
  final List<Habit> _backupHabits = [];
  final Map<int, Map<DateTime, List>> _backupEvents = {};
  bool _isDatabaseOpen = true;

  @override
  Future<Map<String, dynamic>> exportAllData() async {
    return {
      'habits': _backupHabits.map((h) => h.toJson()).toList(),
      'events': _backupEvents,
      'version': 3,
    };
  }

  @override
  Future<void> importData(Map<String, dynamic> data) async {
    _backupHabits.clear();
    _backupEvents.clear();
    
    if (data['habits'] != null) {
      for (var habitJson in data['habits']) {
        _backupHabits.add(Habit.fromJson(habitJson));
      }
    }
    
    if (data['events'] != null) {
      _backupEvents.addAll(Map<int, Map<DateTime, List>>.from(data['events']));
    }
  }

  @override
  Future<int> getDatabaseVersion() async {
    return 3;
  }

  @override
  Future<String> getDatabasePath() async {
    return '/test/path/habo_test.db';
  }

  @override
  Future<void> closeDatabase() async {
    _isDatabaseOpen = false;
  }

  @override
  Future<void> reopenDatabase() async {
    _isDatabaseOpen = true;
  }

  @override
  Future<int> getHabitCount() async {
    return _backupHabits.length;
  }

  @override
  Future<int> getEventCount() async {
    int count = 0;
    for (var events in _backupEvents.values) {
      count += events.length;
    }
    return count;
  }

  @override
  Future<bool> validateDatabaseIntegrity() async {
    // Simple validation - check if habits have required fields
    for (final habit in _backupHabits) {
      if (habit.habitData.id == null || habit.habitData.title.isEmpty) {
        return false;
      }
    }
    return _isDatabaseOpen;
  }

  /// Test helper method to clear all data
  void clear() {
    _backupHabits.clear();
    _backupEvents.clear();
  }

  /// Test helper method to get backup habit count
  int get backupHabitCount => _backupHabits.length;

  /// Test helper method to check if database is open
  bool get isDatabaseOpen => _isDatabaseOpen;
}
