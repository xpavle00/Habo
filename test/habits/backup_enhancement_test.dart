import 'dart:convert';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:intl/intl.dart';

void main() {
  group('Backup Enhancement Tests', () {
    group('Timestamp format', () {
      test('should use correct timestamp format', () {
        final now = DateTime(2023, 12, 25, 15, 30, 45);
        final formatted = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);
        expect(formatted, '2023-12-25_15-30-45');
      });

      test('should handle different times correctly', () {
        final morning = DateTime(2023, 1, 1, 9, 0, 0);
        final formatted = DateFormat('yyyy-MM-dd_HH-mm-ss').format(morning);
        expect(formatted, '2023-01-01_09-00-00');
      });
    });

    group('Backup structure', () {
      test('should create backup with correct structure', () async {
        final testHabits = [
          Habit(
            habitData: HabitData(
              position: 0,
              title: 'Test Habit',
              twoDayRule: true,
              cue: 'Morning coffee',
              routine: '10 pushups',
              reward: 'Feel energized',
              showReward: true,
              advanced: true,
              notification: true,
              notTime: const TimeOfDay(hour: 8, minute: 0),
              events: SplayTreeMap<DateTime, List<dynamic>>(),
              sanction: 'No dessert',
              showSanction: true,
              accountant: 'self',
            ),
          )
        ];
        
        // Test JSON serialization directly
        final jsonData = jsonEncode(testHabits);
        expect(jsonData, isNotEmpty);
        expect(jsonData, contains('Test Habit'));
        expect(jsonData, contains('pushups'));
        
        final restoredHabits = jsonDecode(jsonData);
        expect(restoredHabits, isList);
        expect(restoredHabits.length, 1);
      });

      test('should handle empty habits list', () async {
        final emptyHabits = <Habit>[];
        
        // Test JSON serialization directly
        final jsonData = jsonEncode(emptyHabits);
        expect(jsonData, isNotEmpty);
        expect(jsonDecode(jsonData), isEmpty);
      });
    });
  });
}
