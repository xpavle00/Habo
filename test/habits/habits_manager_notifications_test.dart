import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/repositories/habit_repository.dart';
import 'package:habo/repositories/event_repository.dart';
import 'package:habo/repositories/category_repository.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/ui_feedback_service.dart';
import 'package:habo/habits/habit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/constants.dart';

class MockHabitRepository extends Mock implements HabitRepository {}
class MockEventRepository extends Mock implements EventRepository {}
class MockCategoryRepository extends Mock implements CategoryRepository {}
class MockBackupService extends Mock implements BackupService {}
class MockNotificationService extends Mock implements NotificationService {}
class MockUIFeedbackService extends Mock implements UIFeedbackService {}

void main() {
  late HabitsManager habitsManager;
  late MockHabitRepository mockHabitRepository;
  late MockEventRepository mockEventRepository;
  late MockCategoryRepository mockCategoryRepository;
  late MockBackupService mockBackupService;
  late MockNotificationService mockNotificationService;
  late MockUIFeedbackService mockUIFeedbackService;

  setUpAll(() {
    registerFallbackValue(Habit(
      habitData: HabitData(
        position: 0,
        title: '',
        twoDayRule: false,
        cue: '',
        routine: '',
        reward: '',
        showReward: false,
        advanced: false,
        events: SplayTreeMap<DateTime, List>(),
        notification: false,
        notTime: const TimeOfDay(hour: 0, minute: 0),
        sanction: '',
        showSanction: false,
        accountant: '',
      ),
    ));
    registerFallbackValue(HabitData(
      position: 0,
      title: '',
      twoDayRule: false,
      cue: '',
      routine: '',
      reward: '',
      showReward: false,
      advanced: false,
      events: SplayTreeMap<DateTime, List>(),
      notification: false,
      notTime: const TimeOfDay(hour: 0, minute: 0),
      sanction: '',
      showSanction: false,
      accountant: '',
    ));
    registerFallbackValue(const TimeOfDay(hour: 0, minute: 0));
  });

  setUp(() {
    mockHabitRepository = MockHabitRepository();
    mockEventRepository = MockEventRepository();
    mockCategoryRepository = MockCategoryRepository();
    mockBackupService = MockBackupService();
    mockNotificationService = MockNotificationService();
    mockUIFeedbackService = MockUIFeedbackService();

    // Setup mock returns
    when(() => mockEventRepository.insertEvent(any(), any(), any()))
        .thenAnswer((_) => Future.value());
    when(() => mockEventRepository.deleteEvent(any(), any()))
        .thenAnswer((_) => Future.value());
    when(() => mockEventRepository.getEventsForHabit(any()))
        .thenAnswer((_) => Future.value([]));

    habitsManager = HabitsManager(
      habitRepository: mockHabitRepository,
      eventRepository: mockEventRepository,
      categoryRepository: mockCategoryRepository,
      backupService: mockBackupService,
      notificationService: mockNotificationService,
      uiFeedbackService: mockUIFeedbackService,
    );
  });

  group('Notification Tests', () {
    test('should schedule notifications for habits', () async {
      // Arrange
      final testHabit = Habit(
        habitData: HabitData(
          position: 0,
          title: 'Test Habit',
          twoDayRule: false,
          cue: '',
          routine: '',
          reward: '',
          showReward: false,
          advanced: false,
          events: SplayTreeMap<DateTime, List>(),
          notification: true,
          notTime: const TimeOfDay(hour: 9, minute: 0),
          sanction: '',
          showSanction: false,
          accountant: '',
        ),
      );
      
      when(() => mockHabitRepository.getAllHabits()).thenAnswer((_) async => [testHabit]);
      
      // Act
      habitsManager.resetNotifications([testHabit]);

      // Assert
      verify(() => mockNotificationService.resetNotifications(any())).called(1);
    });

    test('should handle habit event addition', () async {
      // Arrange
      final today = DateTime.now();
      final event = [DayType.check];
      
      // Act
      habitsManager.addEvent(1, today, event);
      
      // Assert
      verify(() => mockEventRepository.insertEvent(1, today, event)).called(1);
    });

    test('should handle habit event deletion', () async {
      // Arrange
      final today = DateTime.now();
      
      // Act
      habitsManager.deleteEvent(1, today);
      
      // Assert
      verify(() => mockEventRepository.deleteEvent(1, today)).called(1);
    });
  });
}
