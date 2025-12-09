import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import '../mocks/mock_repositories.dart';

void main() {
  group('Repository Pattern Tests', () {
    setUpAll(() {
      // Register fallback values for mocktail
      registerFallbackValue(Habit(
          habitData: HabitData(
        title: 'Test Habit',
        position: 0,
        twoDayRule: false,
        cue: '',
        routine: '',
        reward: '',
        showReward: false,
        advanced: false,
        events: SplayTreeMap<DateTime, List>(),
        notification: false,
        notTime: const TimeOfDay(hour: 9, minute: 0),
        sanction: '',
        showSanction: false,
        accountant: '',
      )));
    });

    group('Mock Repository Tests', () {
      late MockHabitRepository mockHabitRepository;
      late MockEventRepository mockEventRepository;
      late MockBackupRepository mockBackupRepository;

      setUp(() {
        mockHabitRepository = MockHabitRepository();
        mockEventRepository = MockEventRepository();
        mockBackupRepository = MockBackupRepository();
      });

      test('should create mock repositories', () {
        expect(mockHabitRepository, isNotNull);
        expect(mockEventRepository, isNotNull);
        expect(mockBackupRepository, isNotNull);
      });

      test('mock habit repository should work', () async {
        final habit = Habit(
            habitData: HabitData(
          title: 'Mock Test Habit',
          position: 0,
          twoDayRule: false,
          cue: '',
          routine: '',
          reward: '',
          showReward: false,
          advanced: false,
          events: SplayTreeMap<DateTime, List>(),
          notification: false,
          notTime: const TimeOfDay(hour: 9, minute: 0),
          sanction: '',
          showSanction: false,
          accountant: '',
        ));

        // Setup mock behavior
        when(() => mockHabitRepository.getAllHabits())
            .thenAnswer((_) async => [habit]);
        when(() => mockHabitRepository.createHabit(any()))
            .thenAnswer((_) async => 1);

        // Test mock behavior
        final id = await mockHabitRepository.createHabit(habit);
        final habits = await mockHabitRepository.getAllHabits();

        expect(id, equals(1));
        expect(habits.length, equals(1));
        expect(habits.first.habitData.title, equals('Mock Test Habit'));

        verify(() => mockHabitRepository.createHabit(habit)).called(1);
        verify(() => mockHabitRepository.getAllHabits()).called(1);
      });

      test('mock event repository should work', () async {
        const habitId = 1;
        final date = DateTime.now();
        final eventsMap = SplayTreeMap<DateTime, List>();
        eventsMap[date] = [1];

        // Setup mock behavior
        when(() => mockEventRepository.insertEvent(any(), any(), any()))
            .thenAnswer((_) async {});
        when(() => mockEventRepository.getEventsMapForHabit(any()))
            .thenAnswer((_) async => eventsMap);

        // Test mock behavior
        await mockEventRepository.insertEvent(habitId, date, [1]);
        final result = await mockEventRepository.getEventsMapForHabit(habitId);

        expect(result.isNotEmpty, isTrue);
        expect(result[date], equals([1]));

        verify(() => mockEventRepository.insertEvent(habitId, date, [1]))
            .called(1);
        verify(() => mockEventRepository.getEventsMapForHabit(habitId))
            .called(1);
      });

      test('mock backup repository should work', () async {
        final testData = {
          'habits': [],
          'events': {},
          'version': 3,
        };

        // Setup mock behavior
        when(() => mockBackupRepository.exportAllData())
            .thenAnswer((_) async => testData);
        when(() => mockBackupRepository.getHabitCount())
            .thenAnswer((_) async => 0);
        when(() => mockBackupRepository.validateDatabaseIntegrity())
            .thenAnswer((_) async => true);

        // Test mock behavior
        final exportedData = await mockBackupRepository.exportAllData();
        final habitCount = await mockBackupRepository.getHabitCount();
        final isValid = await mockBackupRepository.validateDatabaseIntegrity();

        expect(exportedData['version'], equals(3));
        expect(habitCount, equals(0));
        expect(isValid, isTrue);

        verify(() => mockBackupRepository.exportAllData()).called(1);
        verify(() => mockBackupRepository.getHabitCount()).called(1);
        verify(() => mockBackupRepository.validateDatabaseIntegrity())
            .called(1);
      });
    });

    group('In-Memory Repository Tests', () {
      test('InMemoryHabitRepository should work correctly', () async {
        final inMemoryRepo = InMemoryHabitRepository();

        final habit = Habit(
            habitData: HabitData(
          title: 'In-Memory Test',
          position: 0,
          twoDayRule: false,
          cue: '',
          routine: '',
          reward: '',
          showReward: false,
          advanced: false,
          events: SplayTreeMap<DateTime, List>(),
          notification: false,
          notTime: const TimeOfDay(hour: 9, minute: 0),
          sanction: '',
          showSanction: false,
          accountant: '',
        ));

        await inMemoryRepo.createHabit(habit);
        final habits = await inMemoryRepo.getAllHabits();
        expect(habits.length, equals(1));
        expect(habits.first.habitData.title, equals('In-Memory Test'));

        // Test update
        habit.habitData.title = 'Updated Title';
        await inMemoryRepo.updateHabit(habit);
        final updatedHabits = await inMemoryRepo.getAllHabits();
        expect(updatedHabits.first.habitData.title, equals('Updated Title'));

        // Test delete
        await inMemoryRepo.deleteHabit(habit.habitData.id!);
        final emptyHabits = await inMemoryRepo.getAllHabits();
        expect(emptyHabits.length, equals(0));
      });

      test('InMemoryEventRepository should work correctly', () async {
        final inMemoryRepo = InMemoryEventRepository();

        const habitId = 1;
        final date = DateTime.now();
        await inMemoryRepo.insertEvent(habitId, date, [1]);

        final eventsMap = await inMemoryRepo.getEventsMapForHabit(habitId);
        expect(eventsMap.isNotEmpty, isTrue);
        expect(eventsMap[date], equals([1]));

        // Test remove event
        await inMemoryRepo.deleteEvent(habitId, date);
        final emptyEventsMap = await inMemoryRepo.getEventsMapForHabit(habitId);
        expect(emptyEventsMap.isEmpty, isTrue);
      });
    });
  });
}
