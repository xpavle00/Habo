import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/repositories/habit_repository.dart';
import 'package:habo/repositories/event_repository.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/ui_feedback_service.dart';
import 'package:mocktail/mocktail.dart';

class MockHabitRepository extends Mock implements HabitRepository {}
class MockEventRepository extends Mock implements EventRepository {}
class MockBackupService extends Mock implements BackupService {}
class MockNotificationService extends Mock implements NotificationService {}
class MockUIFeedbackService extends Mock implements UIFeedbackService {}

void main() {
  late HabitsManager habitsManager;
  late MockHabitRepository mockHabitRepository;
  late MockEventRepository mockEventRepository;
  late MockBackupService mockBackupService;
  late MockNotificationService mockNotificationService;
  late MockUIFeedbackService mockUIFeedbackService;

  setUpAll(() {
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
    registerFallbackValue(TimeOfDay.now());
    registerFallbackValue(Colors.grey);
  });

  setUp(() {
    mockHabitRepository = MockHabitRepository();
    mockEventRepository = MockEventRepository();
    mockBackupService = MockBackupService();
    mockNotificationService = MockNotificationService();
    mockUIFeedbackService = MockUIFeedbackService();

    habitsManager = HabitsManager(
      habitRepository: mockHabitRepository,
      eventRepository: mockEventRepository,
      backupService: mockBackupService,
      notificationService: mockNotificationService,
      // Don't pass uiFeedbackService to avoid localization
    );
  });

  group('HabitsManager Tests', () {
    test('should initialize with provided repositories', () {
      expect(habitsManager, isNotNull);
    });

    test('should populate allHabits from repository', () async {
      // Arrange
      final mockHabits = [
        Habit(
          habitData: HabitData(
            id: 1,
            position: 0,
            title: 'Test Habit',
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
        ),
      ];
      
      when(() => mockHabitRepository.getAllHabits())
          .thenAnswer((_) async => mockHabits);

      // Act
      await habitsManager.initModel();

      // Assert
      verify(() => mockHabitRepository.getAllHabits()).called(1);
    });

    group('CRUD Operations', () {
      test('should add habit', () async {
        // Arrange
        
        when(() => mockHabitRepository.createHabit(any()))
            .thenAnswer((_) async => 1);

        // Act
        habitsManager.addHabit(
          'Test Habit',
          false,
          'Test cue',
          'Test routine',
          'Test reward',
          false,
          false,
          false,
          const TimeOfDay(hour: 9, minute: 0),
          'Test sanction',
          false,
          'Test accountant',
        );

        // Assert
        verify(() => mockHabitRepository.createHabit(any())).called(1);
      });

      test('should edit habit', () async {
        // Setup
        final testHabit = Habit(
          habitData: HabitData(
            id: 1,
            position: 0,
            title: 'Test Habit',
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
        );

        // Add habit to internal state
        habitsManager.allHabits.add(testHabit);
        when(() => mockHabitRepository.updateHabit(any()))
            .thenAnswer((_) async => null);

        // Act
        habitsManager.editHabit(testHabit.habitData);

        // Assert
        verify(() => mockHabitRepository.updateHabit(any())).called(1);
      });

      test('should delete habit', () async {
        // Setup
        final testHabit = Habit(
          habitData: HabitData(
            id: 1,
            position: 0,
            title: 'Test Habit',
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
        );

        // Add habit to internal state
        habitsManager.allHabits.add(testHabit);
        when(() => mockHabitRepository.deleteHabit(any()))
            .thenAnswer((_) async => null);
        when(() => mockUIFeedbackService.showMessageWithAction(
          message: any(named: 'message'),
          actionLabel: any(named: 'actionLabel'),
          onActionPressed: any(named: 'onActionPressed'),
          backgroundColor: any(named: 'backgroundColor'),
        )).thenReturn(null);
        
        // Act
        habitsManager.deleteHabit(1);
        
        // Assert - verify internal state changes immediately
        expect(habitsManager.allHabits.length, 0);
        expect(habitsManager.toDelete.length, 1);
      });
    });
  });
}
