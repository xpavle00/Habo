import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/constants.dart';
import 'dart:collection';

void main() {
  group('NotificationService', () {
    late NotificationService notificationService;

    setUp(() {
      notificationService = NotificationService();
    });

    test('should create instance successfully', () {
      expect(notificationService, isNotNull);
    });

    test('resetNotifications should handle empty habits list', () {
      expect(() => notificationService.resetNotifications([]), returnsNormally);
    });

    test('removeNotifications should handle empty habits list', () {
      expect(() => notificationService.removeNotifications([]), returnsNormally);
    });

    test('setHabitNotification should delegate to global function', () {
      // This test verifies the method exists and can be called
      expect(() => notificationService.setHabitNotification(
        1, 
        const TimeOfDay(hour: 9, minute: 0), 
        'Test Title', 
        'Test Description'
      ), returnsNormally);
    });

    test('disableHabitNotification should delegate to global function', () {
      // This test verifies the method exists and can be called
      expect(() => notificationService.disableHabitNotification(1), returnsNormally);
    });

    test('handleHabitEventAdded should handle habit completion today', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final event = [DayType.check];
      
      // This test verifies the method exists and can be called
      expect(() => notificationService.handleHabitEventAdded(1, today, event), returnsNormally);
    });

    test('handleHabitEventAdded should handle habit completion on different day', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final event = [DayType.check];
      
      // This test verifies the method exists and can be called
      expect(() => notificationService.handleHabitEventAdded(1, yesterday, event), returnsNormally);
    });

    test('handleHabitEventDeleted should handle event deletion today', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      // This test verifies the method exists and can be called
      expect(() => notificationService.handleHabitEventDeleted(1, today), returnsNormally);
    });

    test('handleHabitEventDeleted should handle event deletion on different day', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      
      // This test verifies the method exists and can be called
      expect(() => notificationService.handleHabitEventDeleted(1, yesterday), returnsNormally);
    });

    group('with sample habits', () {
      late List<Habit> sampleHabits;

      setUp(() {
        sampleHabits = [
          Habit(
            habitData: HabitData(
              id: 1,
              position: 0,
              title: 'Test Habit 1',
              twoDayRule: false,
              cue: 'Test cue',
              routine: 'Test routine',
              reward: 'Test reward',
              showReward: false,
              advanced: false,
              events: SplayTreeMap<DateTime, List>(),
              notification: true,
              notTime: const TimeOfDay(hour: 9, minute: 0),
              sanction: '',
              showSanction: false,
              accountant: '',
            ),
          ),
          Habit(
            habitData: HabitData(
              id: 2,
              position: 1,
              title: 'Test Habit 2',
              twoDayRule: false,
              cue: 'Test cue 2',
              routine: 'Test routine 2',
              reward: 'Test reward 2',
              showReward: false,
              advanced: false,
              events: SplayTreeMap<DateTime, List>(),
              notification: false,
              notTime: const TimeOfDay(hour: 10, minute: 0),
              sanction: '',
              showSanction: false,
              accountant: '',
            ),
          ),
        ];
      });

      test('resetNotifications should handle habits with notifications enabled', () {
        expect(() => notificationService.resetNotifications(sampleHabits), returnsNormally);
      });

      test('removeNotifications should handle multiple habits', () {
        expect(() => notificationService.removeNotifications(sampleHabits), returnsNormally);
      });
    });
  });
}
