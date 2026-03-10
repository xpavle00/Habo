import 'package:flutter_test/flutter_test.dart';
import 'package:habo/model/habo_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

void main() {
  late HaboModel haboModel;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    haboModel = HaboModel();
    await haboModel.initDatabase(testPath: inMemoryDatabasePath);
  });

  tearDown(() async {
    await haboModel.db.close();
  });

  test('getAllHabits includes deletedAt when includeDeleted is true', () async {
    // 1. Create a habit
    final habitId = await haboModel.insertHabit(
      Habit(
        habitData: HabitData(
          position: 0,
          title: 'To Be Deleted',
          twoDayRule: false,
          cue: '',
          routine: '',
          reward: '',
          showReward: false,
          advanced: false,
          notification: false,
          notTime: const TimeOfDay(hour: 0, minute: 0),
          events: SplayTreeMap(),
          sanction: '',
          showSanction: false,
          accountant: '',
        ),
      ),
    );

    // 2. Delete the habit
    await haboModel.deleteHabit(habitId);

    // 3. Fetch all habits including deleted
    final habits = await haboModel.getAllHabits(includeDeleted: true);

    // 4. Verify deleted habit exists and has deletedAt set
    final deletedHabit = habits.firstWhere((h) => h.habitData.id == habitId);
    expect(deletedHabit.habitData.deletedAt, isNotNull);

    // Verify fetching active habits excludes it
    final activeHabits = await haboModel.getAllHabits(includeDeleted: false);
    expect(activeHabits.any((h) => h.habitData.id == habitId), isFalse);
  });
}
