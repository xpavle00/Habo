import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/repositories/sqlite_backup_repository.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/category.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/constants.dart';
import 'package:mocktail/mocktail.dart';

class MockHaboModel extends Mock implements HaboModel {}

/// Tests for the LWW (Last-Write-Wins) merge functionality in SQLiteBackupRepository.
void main() {
  late SQLiteBackupRepository repository;
  late MockHaboModel mockModel;

  setUpAll(() {
    // Create real fallback instances for mocktail
    final fallbackHabit = Habit(
      habitData: HabitData(
        id: 0,
        title: 'Fallback',
        position: 0,
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
        habitType: HabitType.boolean,
        targetValue: 1.0,
        partialValue: 1.0,
        unit: '',
        categories: [],
        archived: false,
      ),
    );
    registerFallbackValue(fallbackHabit);
    registerFallbackValue(Category(title: 'Fallback', iconCodePoint: 0xe88a));
    registerFallbackValue(DateTime.now());
    registerFallbackValue(<dynamic>[]);
  });

  setUp(() {
    mockModel = MockHaboModel();
    repository = SQLiteBackupRepository(mockModel);

    // Default stubs to prevent 'Null is not subtype of Future' errors
    when(
      () => mockModel.updateHabitCategories(any(), any()),
    ).thenAnswer((_) async {});
    when(() => mockModel.deleteHabit(any())).thenAnswer((_) async {});
    when(
      () => mockModel.deleteAllEventsForHabit(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockModel.insertEvent(
        any(),
        any(),
        any(),
        updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockModel.editHabit(
        any(),
        preserveTimestamp: any(named: 'preserveTimestamp'),
      ),
    ).thenAnswer((_) async {});
  });

  group('mergeData - LWW Merge Tests', () {
    test('mergeData adds remote-only habits to local', () async {
      // Arrange: Local is empty, remote has one habit
      when(
        () => mockModel.getAllHabits(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(
        () => mockModel.getAllCategories(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(
        () => mockModel.insertHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      ).thenAnswer((_) async => 1);
      when(
        () => mockModel.insertEvent(
          any(),
          any(),
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).thenAnswer((_) async {});

      final remoteData = {
        'habits': [
          {
            'id': 1,
            'title': 'Remote Habit',
            'position': 0,
            'twoDayRule': 0,
            'cue': '',
            'routine': '',
            'reward': '',
            'showReward': 0,
            'advanced': 0,
            'notification': 0,
            'notTime': '9:0',
            'sanction': '',
            'showSanction': 0,
            'accountant': '',
            'habitType': 0,
            'targetValue': 1.0,
            'partialValue': 1.0,
            'unit': '',
            'archived': 0,
            'events': <String, dynamic>{},
            'categories': <dynamic>[],
            'uuid': 'remote-uuid-1',
            'updated_at': DateTime.now().toIso8601String(),
          },
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: insertHabit should be called for the remote habit
      verify(
        () => mockModel.insertHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      ).called(1);
    });

    test('mergeData preserves local-only habits', () async {
      // Arrange: Local has a habit, remote is empty
      final localHabit = _createTestHabit(id: 1, title: 'Local Habit');
      when(
        () => mockModel.getAllHabits(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => [localHabit]);
      when(
        () => mockModel.getAllCategories(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);

      final remoteData = {'habits': [], 'categories': []};

      // Act
      await repository.mergeData(remoteData);

      // Assert: No insertHabit calls (local habit is preserved, not touched)
      verifyNever(
        () => mockModel.insertHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      );
    });

    test('mergeData merges events from remote for existing habit', () async {
      // Arrange: Local has habit with event on Day 1, remote has same habit with event on Day 2
      final localEvents = SplayTreeMap<DateTime, List>();
      localEvents[DateTime(2024, 1, 1)] = [DayType.check, 'Day 1 comment'];

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Shared Habit',
        events: localEvents,
      );

      when(
        () => mockModel.getAllHabits(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => [localHabit]);
      when(
        () => mockModel.getAllCategories(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(
        () => mockModel.insertEvent(
          any(),
          any(),
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockModel.editHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      ).thenAnswer((_) async {});

      final remoteData = {
        'habits': [
          {
            'id': 99, // Different ID (different device)
            'title': 'Shared Habit', // Same title = same habit
            'position': 0,
            'twoDayRule': 0,
            'cue': '',
            'routine': '',
            'reward': '',
            'showReward': 0,
            'advanced': 0,
            'notification': 0,
            'notTime': '9:0',
            'sanction': '',
            'showSanction': 0,
            'accountant': '',
            'habitType': 0,
            'targetValue': 1.0,
            'partialValue': 1.0,
            'unit': '',
            'archived': 0,
            'events': {
              // Remote has Day 2 event, not Day 1
              '2024-01-02 00:00:00.000': ['DayType.fail', 'Day 2 from remote'],
            },
            'categories': [],
            'uuid': 'shared-uuid-1',
            'updated_at': DateTime.now()
                .add(const Duration(hours: 1))
                .toIso8601String(),
          },
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Day 2 event should be inserted (new date)
      verify(
        () => mockModel.insertEvent(
          1,
          DateTime(2024, 1, 2),
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).called(1);
    });

    test(
      'mergeData overwrites local event when both have same date (Remote Wins)',
      () async {
        // Arrange: Both local and remote have event on same date
        final localEvents = SplayTreeMap<DateTime, List>();
        localEvents[DateTime(2024, 1, 1)] = [DayType.check, 'Local version'];

        final localHabit = _createTestHabit(
          id: 1,
          title: 'Shared Habit',
          events: localEvents,
        );

        when(
          () => mockModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localHabit]);
        when(
          () => mockModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);

        // Mock insertEvent which replaces data
        when(
          () => mockModel.insertEvent(
            any(),
            any(),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockModel.editHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        ).thenAnswer((_) async {}); // Mock editHabit call

        final remoteData = {
          'habits': [
            {
              'id': 99,
              'title': 'Shared Habit',
              'position': 0,
              'twoDayRule': 0,
              'cue': '',
              'routine': '',
              'reward': '',
              'showReward': 0,
              'advanced': 0,
              'notification': 0,
              'notTime': '9:0',
              'sanction': '',
              'showSanction': 0,
              'accountant': '',
              'habitType': 0,
              'targetValue': 1.0,
              'partialValue': 1.0,
              'unit': '',
              'archived': 0,
              'events': {
                // Same date as local
                '2024-01-01 00:00:00.000': ['DayType.fail', 'Remote version'],
              },
              'categories': [],
              'uuid': 'shared-uuid-1',
              'updated_at': DateTime.now()
                  .add(const Duration(hours: 1))
                  .toIso8601String(),
            },
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: insertEvent called (Remote Wins overwrites)
        verify(
          () => mockModel.insertEvent(
            1,
            DateTime(2024, 1, 1),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).called(1);
      },
    );

    test('mergeData adds remote-only categories', () async {
      // Arrange
      when(
        () => mockModel.getAllHabits(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(
        () => mockModel.getAllCategories(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(() => mockModel.insertCategory(any())).thenAnswer((_) async => 1);

      final remoteData = {
        'habits': [],
        'categories': [
          {
            'id': 5,
            'title': 'Remote Category',
            'iconCodePoint': 58123,
            'fontFamily': 'MaterialIcons',
          },
        ],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert
      verify(() => mockModel.insertCategory(any())).called(1);
    });

    test('mergeData handles empty remote data gracefully', () async {
      // Arrange
      final remoteData = <String, dynamic>{};

      // Act & Assert: Should not throw
      await expectLater(repository.mergeData(remoteData), completes);
    });

    test('mergeData handles missing habits key gracefully', () async {
      // Arrange
      final remoteData = {'categories': []};

      // Act & Assert: Should complete without error
      await expectLater(repository.mergeData(remoteData), completes);
    });
  });

  group('mergeData - Complex Scenarios', () {
    test('multiple habits merge correctly', () async {
      // Arrange: Local has Habit A, Remote has Habit A and Habit B
      final localHabit = _createTestHabit(id: 1, title: 'Habit A');
      when(
        () => mockModel.getAllHabits(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => [localHabit]);
      when(
        () => mockModel.getAllCategories(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(
        () => mockModel.insertHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      ).thenAnswer((_) async => 2);
      when(
        () => mockModel.insertEvent(
          any(),
          any(),
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockModel.editHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      ).thenAnswer((_) async {});

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(id: 10, title: 'Habit A'), // Exists locally
          _createRemoteHabitJson(id: 11, title: 'Habit B'), // New
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Only Habit B should be inserted
      verify(
        () => mockModel.insertHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      ).called(1);
      // Assert: Habit A should be updated (editHabit)
      verify(
        () => mockModel.editHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      ).called(1);
    });

    test(
      'soft-deleted local habits do not match remote habits by title',
      () async {
        // Scenario: Local has deleted "Exercise" (UUID-B1), remote has active
        // "Exercise" (UUID-A1). They should NOT match by title — the remote
        // should be treated as a new habit and inserted.
        final deletedLocalHabit = _createTestHabit(
          id: 1,
          title: 'Exercise',
          uuid: 'local-uuid-1',
          deletedAt: DateTime.now().subtract(const Duration(hours: 1)),
        );

        when(
          () => mockModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [deletedLocalHabit]);
        when(
          () => mockModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockModel.insertHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        ).thenAnswer((_) async => 2);

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 10,
              title: 'Exercise',
              uuid: 'remote-uuid-1',
            ),
          ],
          'categories': [],
        };

        await repository.mergeData(remoteData);

        // Should INSERT the remote habit (not editHabit) because the
        // soft-deleted local habit should not be in the title map.
        verify(
          () => mockModel.insertHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        ).called(1);
        verifyNever(
          () => mockModel.editHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        );
      },
    );

    test(
      'insertHabit during merge is called with preserveTimestamp: true',
      () async {
        when(
          () => mockModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockModel.insertHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        ).thenAnswer((_) async => 1);

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 1,
              title: 'Test Habit',
              uuid: 'test-uuid',
            ),
          ],
          'categories': [],
        };

        await repository.mergeData(remoteData);

        // Verify preserveTimestamp: true was passed
        verify(
          () => mockModel.insertHabit(
            any(),
            preserveTimestamp: true,
          ),
        ).called(1);
      },
    );
  });
}

/// Helper to create a test Habit with defaults
Habit _createTestHabit({
  required int id,
  required String title,
  String? uuid,
  SplayTreeMap<DateTime, List>? events,
  DateTime? deletedAt,
}) {
  return Habit(
    habitData: HabitData(
      id: id,
      uuid: uuid,
      title: title,
      position: 0,
      twoDayRule: false,
      cue: '',
      routine: '',
      reward: '',
      showReward: false,
      advanced: false,
      notification: false,
      notTime: const TimeOfDay(hour: 9, minute: 0),
      events: events ?? SplayTreeMap<DateTime, List>(),
      sanction: '',
      showSanction: false,
      accountant: '',
      habitType: HabitType.boolean,
      targetValue: 1.0,
      partialValue: 1.0,
      unit: '',
      categories: [],
      archived: false,
      deletedAt: deletedAt,
    ),
  );
}

/// Helper to create remote habit JSON
Map<String, dynamic> _createRemoteHabitJson({
  required int id,
  required String title,
  String? uuid,
  Map<String, List>? events,
}) {
  return {
    'id': id,
    'title': title,
    'position': 0,
    'twoDayRule': 0,
    'cue': '',
    'routine': '',
    'reward': '',
    'showReward': 0,
    'advanced': 0,
    'notification': 0,
    'notTime': '9:0',
    'sanction': '',
    'showSanction': 0,
    'accountant': '',
    'habitType': 0,
    'targetValue': 1.0,
    'partialValue': 1.0,
    'unit': '',
    'archived': 0,
    'events': events ?? {},
    'categories': [],
    'uuid': uuid ?? 'remote-$id-$title',
    'updated_at': DateTime.now()
        .add(const Duration(hours: 1))
        .toIso8601String(),
  };
}
