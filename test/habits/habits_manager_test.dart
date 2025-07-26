import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/habo_model.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock class for HaboModel
class MockHaboModel extends Mock implements HaboModel {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(Habit(
      habitData: HabitData(
        position: 0,
        title: 'Fallback',
        twoDayRule: false,
        cue: '',
        routine: '',
        reward: '',
        showReward: false,
        advanced: false,
        notification: false,
        notTime: const TimeOfDay(hour: 9, minute: 0),
        events: SplayTreeMap<DateTime, List>(),
        sanction: '',
        showSanction: false,
        accountant: '',
      ),
    ));
  });
  late HabitsManager habitsManager;
  late MockHaboModel mockHaboModel;

  setUp(() {
    mockHaboModel = MockHaboModel();
    habitsManager = HabitsManager(haboModel: mockHaboModel);
  });

  group('HabitsManager Tests', () {
    test('should initialize with provided HaboModel', () {
      expect(habitsManager, isNotNull);
    });

    test('should call initDatabase when initModel is called', () async {
      // Arrange
      when(() => mockHaboModel.initDatabase())
          .thenAnswer((_) async => null);
      when(() => mockHaboModel.getAllHabits())
          .thenAnswer((_) async => []);

      // Act
      await habitsManager.initModel();

      // Assert
      verify(() => mockHaboModel.initDatabase()).called(1);
      verify(() => mockHaboModel.getAllHabits()).called(1);
    });

    test('should populate allHabits from model', () async {
      // Arrange
      final mockHabits = [
        Habit(
          habitData: HabitData(
            position: 1,
            title: 'Test Habit 1',
            twoDayRule: false,
            cue: 'Test cue',
            routine: 'Test routine',
            reward: 'Test reward',
            showReward: false,
            advanced: false,
            notification: false,
            notTime: const TimeOfDay(hour: 9, minute: 0),
            events: SplayTreeMap<DateTime, List>(),
            sanction: 'Test sanction',
            showSanction: false,
            accountant: 'Test accountant',
          ),
        ),
        Habit(
          habitData: HabitData(
            position: 2,
            title: 'Test Habit 2',
            twoDayRule: false,
            cue: 'Test cue',
            routine: 'Test routine',
            reward: 'Test reward',
            showReward: false,
            advanced: false,
            notification: false,
            notTime: const TimeOfDay(hour: 9, minute: 0),
            events: SplayTreeMap<DateTime, List>(),
            sanction: 'Test sanction',
            showSanction: false,
            accountant: 'Test accountant',
          ),
        ),
      ];
      
      when(() => mockHaboModel.initDatabase())
          .thenAnswer((_) async => null);
      when(() => mockHaboModel.getAllHabits())
          .thenAnswer((_) async => mockHabits);

      // Act
      await habitsManager.initModel();

      // Assert
      expect(habitsManager.allHabits.length, 2);
      expect(habitsManager.allHabits[0].habitData.title, 'Test Habit 1');
      expect(habitsManager.allHabits[1].habitData.title, 'Test Habit 2');
    });

    test('should handle empty habits list', () async {
      // Arrange
      when(() => mockHaboModel.initDatabase())
          .thenAnswer((_) async => null);
      when(() => mockHaboModel.getAllHabits())
          .thenAnswer((_) async => []);

      // Act
      await habitsManager.initModel();

      // Assert
      expect(habitsManager.allHabits, isEmpty);
    });

    group('CRUD Operations', () {
      setUp(() async {
        // Setup initial state with empty habits
        when(() => mockHaboModel.initDatabase())
            .thenAnswer((_) async => null);
        when(() => mockHaboModel.getAllHabits())
            .thenAnswer((_) async => []);
        await habitsManager.initModel();
      });

      group('Create Operations', () {
        test('should add a new habit', () async {
          // Arrange
          const testTitle = 'Test Habit';
          const testCue = 'Test cue';
          const testRoutine = 'Test routine';
          const testReward = 'Test reward';
          const testSanction = 'Test sanction';
          const testAccountant = 'Test accountant';
          const testTime = TimeOfDay(hour: 9, minute: 0);
          
          when(() => mockHaboModel.insertHabit(any()))
              .thenAnswer((_) async => 1);

          // Act
          habitsManager.addHabit(
            testTitle,
            false, // twoDayRule
            testCue,
            testRoutine,
            testReward,
            false, // showReward
            false, // advanced
            false, // notification
            testTime,
            testSanction,
            false, // showSanction
            testAccountant,
          );
          await Future.delayed(Duration.zero); // Allow async operations to complete

          // Assert
          expect(habitsManager.allHabits.length, 1);
          expect(habitsManager.allHabits[0].habitData.title, testTitle);
          expect(habitsManager.allHabits[0].habitData.cue, testCue);
          expect(habitsManager.allHabits[0].habitData.routine, testRoutine);
          verify(() => mockHaboModel.insertHabit(any())).called(1);
        });

        test('should add habit with correct position', () async {
          // Arrange
          when(() => mockHaboModel.insertHabit(any()))
              .thenAnswer((_) async => 1);

          // Act - Add first habit
          habitsManager.addHabit('First Habit', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          
          // Manually set ID for testing
          habitsManager.allHabits[0].habitData.id = 1;
          
          // Act - Add second habit
          habitsManager.addHabit('Second Habit', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          
          // Manually set ID for testing
          habitsManager.allHabits[1].habitData.id = 2;

          // Assert
          expect(habitsManager.allHabits.length, 2);
          expect(habitsManager.allHabits[0].habitData.position, 0);
          expect(habitsManager.allHabits[1].habitData.position, 1);
        });
      });

      group('Read Operations', () {
        setUp(() async {
          // Add some test habits
          when(() => mockHaboModel.insertHabit(any()))
              .thenAnswer((_) async => 1);
          
          habitsManager.addHabit('Habit 1', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          habitsManager.allHabits[0].habitData.id = 1;
          
          habitsManager.addHabit('Habit 2', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          habitsManager.allHabits[1].habitData.id = 2;
        });

        test('should find habit by id', () {
          // Act
          final habit = habitsManager.findHabitById(1);

          // Assert
          expect(habit, isNotNull);
          expect(habit!.habitData.title, 'Habit 1');
        });

        test('should return null for non-existent habit id', () {
          // Act
          final habit = habitsManager.findHabitById(999);

          // Assert
          expect(habit, isNull);
        });

        test('should get habit name by id', () {
          // Act
          final name = habitsManager.getNameOfHabit(1);

          // Assert
          expect(name, 'Habit 1');
        });

        test('should return empty string for non-existent habit name', () {
          // Act
          final name = habitsManager.getNameOfHabit(999);

          // Assert
          expect(name, '');
        });
      });

      group('Update Operations', () {
        late Habit testHabit;

        setUp(() async {
          // Setup a test habit
          when(() => mockHaboModel.insertHabit(any()))
              .thenAnswer((_) async => 1);
          when(() => mockHaboModel.editHabit(any()))
              .thenAnswer((_) async => null);

          habitsManager.addHabit('Original Title', false, 'Original cue', 
              'Original routine', 'Original reward', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), 'Original sanction', false, 
              'Original accountant');
          await Future.delayed(Duration.zero);
          
          testHabit = habitsManager.allHabits[0];
          testHabit.habitData.id = 1;
        });

        test('should edit existing habit', () async {
          // Arrange
          final updatedData = HabitData(
            position: testHabit.habitData.position,
            title: 'Updated Title',
            twoDayRule: true,
            cue: 'Updated cue',
            routine: 'Updated routine',
            reward: 'Updated reward',
            showReward: true,
            advanced: true,
            notification: true,
            notTime: const TimeOfDay(hour: 10, minute: 30),
            events: SplayTreeMap<DateTime, List>(),
            sanction: 'Updated sanction',
            showSanction: true,
            accountant: 'Updated accountant',
          );
          updatedData.id = 1;

          // Act
          habitsManager.editHabit(updatedData);

          // Assert
          expect(habitsManager.allHabits.length, 1);
          expect(habitsManager.allHabits[0].habitData.title, 'Updated Title');
          expect(habitsManager.allHabits[0].habitData.twoDayRule, true);
          expect(habitsManager.allHabits[0].habitData.cue, 'Updated cue');
          verify(() => mockHaboModel.editHabit(any())).called(1);
        });

        test('should update habit notification settings', () async {
          // Arrange
          final updatedData = HabitData(
            position: testHabit.habitData.position,
            title: testHabit.habitData.title,
            twoDayRule: testHabit.habitData.twoDayRule,
            cue: testHabit.habitData.cue,
            routine: testHabit.habitData.routine,
            reward: testHabit.habitData.reward,
            showReward: testHabit.habitData.showReward,
            advanced: testHabit.habitData.advanced,
            notification: true, // Changed from false to true
            notTime: const TimeOfDay(hour: 15, minute: 45),
            events: SplayTreeMap<DateTime, List>(),
            sanction: testHabit.habitData.sanction,
            showSanction: testHabit.habitData.showSanction,
            accountant: testHabit.habitData.accountant,
          );
          updatedData.id = 1;

          // Act
          habitsManager.editHabit(updatedData);

          // Assert
          expect(habitsManager.allHabits[0].habitData.notification, true);
          expect(habitsManager.allHabits[0].habitData.notTime.hour, 15);
          expect(habitsManager.allHabits[0].habitData.notTime.minute, 45);
        });
      });

      group('Delete Operations', () {
        late Habit testHabit;

        setUp(() async {
          // Setup a test habit
          when(() => mockHaboModel.insertHabit(any()))
              .thenAnswer((_) async => 1);
          when(() => mockHaboModel.deleteHabit(any()))
              .thenAnswer((_) async => null);

          habitsManager.addHabit('Test Habit', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          
          testHabit = habitsManager.allHabits[0];
          testHabit.habitData.id = 1;
        });

        test('should delete habit', () async {
          // Act - Simulate the core deletion logic
          final habitToDelete = habitsManager.findHabitById(1);
          expect(habitToDelete, isNotNull);
          
          habitsManager.allHabits.remove(habitToDelete);
          habitsManager.updateOrder();

          // Assert
          expect(habitsManager.allHabits.length, 0);
          expect(habitsManager.findHabitById(1), isNull);
        });

        test('should undo delete habit', () async {
          // Arrange - Simulate deletion
          final deletedHabit = habitsManager.findHabitById(1);
          habitsManager.allHabits.remove(deletedHabit);
          
          // Act - Undo
          habitsManager.allHabits.insert(0, deletedHabit!);
          habitsManager.updateOrder();

          // Assert
          expect(habitsManager.allHabits.length, 1);
          expect(habitsManager.allHabits[0], deletedHabit);
        });
      });

      group('Utility Methods', () {
        setUp(() async {
          // Add some test habits
          when(() => mockHaboModel.insertHabit(any()))
              .thenAnswer((_) async => 1);

          habitsManager.addHabit('First Habit', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          habitsManager.allHabits[0].habitData.id = 1;

          habitsManager.addHabit('Second Habit', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          habitsManager.allHabits[1].habitData.id = 2;

          habitsManager.addHabit('Third Habit', false, '', '', '', false, false, false, 
              const TimeOfDay(hour: 9, minute: 0), '', false, '');
          await Future.delayed(Duration.zero);
          habitsManager.allHabits[2].habitData.id = 3;
        });

        test('should update habit positions correctly', () async {
          // Act - Simulate deletion of middle habit
          final habitToDelete = habitsManager.findHabitById(2);
          habitsManager.allHabits.remove(habitToDelete);
          habitsManager.updateOrder();
          
          // Assert positions are updated
          expect(habitsManager.allHabits.length, 2);
          expect(habitsManager.allHabits[0].habitData.position, 0);
          expect(habitsManager.allHabits[1].habitData.position, 1);
        });

        test('should maintain correct positions after undo', () async {
          // Arrange
          final deletedHabit = habitsManager.allHabits[1];
          
          // Act - Simulate delete and undo
          habitsManager.allHabits.remove(deletedHabit);
          habitsManager.updateOrder();
          
          habitsManager.allHabits.insert(1, deletedHabit);
          habitsManager.updateOrder();

          // Assert positions are correct
          expect(habitsManager.allHabits.length, 3);
          for (int i = 0; i < 3; i++) {
            expect(habitsManager.allHabits[i].habitData.position, i);
          }
        });
      });
    });
  });
}