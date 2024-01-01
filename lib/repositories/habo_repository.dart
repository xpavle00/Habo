import 'package:flutter/foundation.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/repositories/habo_repo_interface.dart';

class HaboRepository implements HaboRepoInterface {
  final HaboRepoInterface _localRepo;
  final HaboRepoInterface _remoteRepo;

  //in-memory cache here to improve performance
  List<Habit> allHabits = [];

  HaboRepository(
      {required HaboRepoInterface localRepo,
      required HaboRepoInterface remoteRepo})
      : _localRepo = localRepo,
        _remoteRepo = remoteRepo {
    // getAllHabits().then((value) => allHabits = value);
  }

  @override
  Future<void> clearDatabase() async {
    await _localRepo.clearDatabase();
    await _localRepo.clearDatabase();
  }

  @override
  Future<void> deleteEvent(int id, DateTime dateTime) async {
    await _localRepo.deleteEvent(id, dateTime);
    await _remoteRepo.deleteEvent(id, dateTime);
  }

  @override
  Future<void> deleteHabit(int id) async {
    await _localRepo.deleteHabit(id);
    await _remoteRepo.deleteHabit(id);
  }

  @override
  Future<void> editHabit(Habit habit) async {
    await _localRepo.editHabit(habit);
    await _remoteRepo.editHabit(habit);
  }

  @override
  Future<List<Habit>> getAllHabits() async {
    if (allHabits.isEmpty) {
      allHabits = await _localRepo.getAllHabits();
      if (allHabits.isEmpty) {
        allHabits = await _remoteRepo.getAllHabits();
      }
    }
    return allHabits;
  }

  @override
  Future<void> insertEvent(int id, DateTime date, List event) async {
    await _localRepo.insertEvent(id, date, event);
    await _remoteRepo.insertEvent(id, date, event);
  }

  @override
  Future<int> insertHabit(Habit habit) async {
    int id = await _localRepo.insertHabit(habit);
    habit.setId = id;
    await _remoteRepo.insertHabit(habit);
    debugPrint("new id: $id");
    return id;
  }

  @override
  Future<void> updateOrder(List<Habit> habits) async {
    await _localRepo.updateOrder(habits);
    await _remoteRepo.updateOrder(habits);
  }

  @override
  Future<void> useBackup(List<Habit> habits) async {
    await _localRepo.useBackup(habits);
    await _remoteRepo.useBackup(habits);
  }
}
