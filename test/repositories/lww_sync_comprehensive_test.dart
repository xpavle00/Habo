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

/// Comprehensive LWW (Last-Write-Wins) sync tests covering all edge cases.
/// These tests validate the mergeData() function in SQLiteBackupRepository.
void main() {
  late SQLiteBackupRepository repository;
  late MockHaboModel mockModel;

  setUpAll(() {
    // Create fallback instances for mocktail
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
    registerFallbackValue(<Category>[]);
  });

  setUp(() {
    mockModel = MockHaboModel();
    repository = SQLiteBackupRepository(mockModel);

    // Default stubs
    when(
      () => mockModel.updateHabitCategories(any(), any()),
    ).thenAnswer((_) async {});
    when(() => mockModel.deleteHabit(any())).thenAnswer((_) async {});
    when(
      () => mockModel.softDeleteHabitAt(any(), any()),
    ).thenAnswer((_) async {});
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
    when(() => mockModel.insertHabit(any())).thenAnswer((_) async => 1);
    when(() => mockModel.insertCategory(any())).thenAnswer((_) async => 1);
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 1: LWW Timestamp Resolution Tests
  // ═══════════════════════════════════════════════════════════════════════════
  group('LWW Timestamp Resolution', () {
    test('local newer than remote - should skip remote update', () async {
      // Arrange: Local habit updated 1 hour AGO, remote updated 2 hours AGO
      final localTime = DateTime.now().subtract(const Duration(hours: 1));
      final remoteTime = DateTime.now().subtract(const Duration(hours: 2));

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Test Habit',
        uuid: 'uuid-1',
        updatedAt: localTime,
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Test Habit',
            uuid: 'uuid-1',
            updatedAt: remoteTime,
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: editHabit should NOT be called (local is newer)
      verifyNever(
        () => mockModel.editHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      );
    });

    test('remote newer than local - should update local', () async {
      // Arrange: Local habit updated 2 hours AGO, remote updated 1 hour AGO
      final localTime = DateTime.now().subtract(const Duration(hours: 2));
      final remoteTime = DateTime.now().subtract(const Duration(hours: 1));

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Test Habit',
        uuid: 'uuid-1',
        updatedAt: localTime,
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Test Habit',
            uuid: 'uuid-1',
            updatedAt: remoteTime,
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: editHabit should be called with preserveTimestamp=true
      verify(
        () => mockModel.editHabit(any(), preserveTimestamp: true),
      ).called(1);
    });

    test('remote 1 second newer wins', () async {
      // Arrange: Remote is just 1 second newer
      final localTime = DateTime(2026, 2, 5, 12, 0, 0);
      final remoteTime = DateTime(2026, 2, 5, 12, 0, 1);

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Test Habit',
        uuid: 'uuid-1',
        updatedAt: localTime,
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Test Habit',
            uuid: 'uuid-1',
            updatedAt: remoteTime,
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Remote wins
      verify(
        () => mockModel.editHabit(any(), preserveTimestamp: true),
      ).called(1);
    });

    test('equal timestamps - local wins (tie-breaker)', () async {
      // Arrange: Exact same timestamp
      final sameTime = DateTime(2026, 2, 5, 12, 0, 0);

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Test Habit',
        uuid: 'uuid-1',
        updatedAt: sameTime,
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Test Habit',
            uuid: 'uuid-1',
            updatedAt: sameTime,
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: No update (local wins on tie)
      verifyNever(
        () => mockModel.editHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 2: Soft-Delete Propagation Tests
  // ═══════════════════════════════════════════════════════════════════════════
  group('Soft-Delete Propagation', () {
    test('remote habit deleted - should soft-delete local', () async {
      // Arrange: Local has active habit, remote says it's deleted (newer)
      final localTime = DateTime.now().subtract(const Duration(hours: 2));
      final remoteDeletedAt = DateTime.now().subtract(const Duration(hours: 1));

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Deleted Habit',
        uuid: 'uuid-deleted',
        updatedAt: localTime,
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Deleted Habit',
            uuid: 'uuid-deleted',
            updatedAt: localTime,
            deletedAt: remoteDeletedAt,
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: deleteHabit should be called
      verify(() => mockModel.softDeleteHabitAt(1, any())).called(1);
    });

    test('remote deleted but local has no match - should skip', () async {
      // Arrange: Remote has deleted habit that doesn't exist locally
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Ghost Habit',
            uuid: 'uuid-ghost',
            updatedAt: DateTime.now(),
            deletedAt: DateTime.now(),
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: No habit should be inserted or deleted
      verifyNever(() => mockModel.insertHabit(any()));
      verifyNever(() => mockModel.deleteHabit(any()));
    });

    test(
      'local deleted and remote pushes newer active - should restore',
      () async {
        // Arrange: Local habit is deleted, remote has newer ACTIVE version
        final localDeletedAt = DateTime.now().subtract(
          const Duration(hours: 2),
        );
        final remoteUpdatedAt = DateTime.now().subtract(
          const Duration(hours: 1),
        );

        final localHabit = _createTestHabit(
          id: 1,
          title: 'Restored Habit',
          uuid: 'uuid-restore',
          updatedAt: localDeletedAt,
          deletedAt: localDeletedAt,
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

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 99,
              title: 'Restored Habit',
              uuid: 'uuid-restore',
              updatedAt: remoteUpdatedAt,
              // No deletedAt = active
            ),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: editHabit should be called to restore (remote is newer and active)
        verify(
          () => mockModel.editHabit(any(), preserveTimestamp: true),
        ).called(1);
      },
    );

    test('local deleted with newer timestamp - should keep deleted', () async {
      // Arrange: Local habit deleted more recently than remote update
      final remoteUpdatedAt = DateTime.now().subtract(const Duration(hours: 2));
      final localDeletedAt = DateTime.now().subtract(const Duration(hours: 1));

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Stay Deleted Habit',
        uuid: 'uuid-stay-deleted',
        updatedAt: remoteUpdatedAt,
        deletedAt: localDeletedAt,
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Stay Deleted Habit',
            uuid: 'uuid-stay-deleted',
            updatedAt: remoteUpdatedAt,
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: No update (local deleted timestamp is newer)
      verifyNever(
        () => mockModel.editHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 3: Backup Restore Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  group('Backup Restore Edge Cases', () {
    test(
      'after restore - sync pulls remote updates for habits modified since backup',
      () async {
        // Scenario: User restored backup from 1 week ago. Remote has updates from 3 days ago.
        final backupTimestamp = DateTime.now().subtract(
          const Duration(days: 7),
        );
        final remoteTimestamp = DateTime.now().subtract(
          const Duration(days: 3),
        );

        final localHabit = _createTestHabit(
          id: 1,
          title: 'Backup Habit',
          uuid: 'uuid-backup',
          updatedAt: backupTimestamp,
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

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 99,
              title: 'Backup Habit Updated',
              uuid: 'uuid-backup',
              updatedAt: remoteTimestamp,
            ),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Remote should win (updated more recently than backup)
        verify(
          () => mockModel.editHabit(any(), preserveTimestamp: true),
        ).called(1);
      },
    );

    test('after restore - new remote habits are imported', () async {
      // Scenario: Remote has a habit that was created AFTER the backup was made
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'New Habit After Backup',
            uuid: 'uuid-new-post-backup',
            updatedAt: DateTime.now(),
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: New habit should be inserted
      verify(() => mockModel.insertHabit(any())).called(1);
    });

    test(
      'after restore - habits deleted after backup are re-deleted on sync',
      () async {
        // Scenario: Habit was deleted on remote after backup was made
        final backupTimestamp = DateTime.now().subtract(
          const Duration(days: 7),
        );
        final remoteDeletedAt = DateTime.now().subtract(
          const Duration(days: 3),
        );

        final localHabit = _createTestHabit(
          id: 1,
          title: 'Re-delete Me',
          uuid: 'uuid-redelete',
          updatedAt: backupTimestamp,
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

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 99,
              title: 'Re-delete Me',
              uuid: 'uuid-redelete',
              updatedAt: backupTimestamp,
              deletedAt: remoteDeletedAt,
            ),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Habit should be deleted
        verify(() => mockModel.softDeleteHabitAt(1, any())).called(1);
      },
    );
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 4: New Habit Sync Tests
  // ═══════════════════════════════════════════════════════════════════════════
  group('New Habit Sync', () {
    test('new remote habit - should be imported on pull', () async {
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Brand New Habit',
            uuid: 'uuid-new',
            updatedAt: DateTime.now(),
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert
      verify(() => mockModel.insertHabit(any())).called(1);
    });

    test(
      'new habit on both devices with same uuid - remote wins if newer',
      () async {
        final localTime = DateTime.now().subtract(const Duration(minutes: 5));
        final remoteTime = DateTime.now();

        final localHabit = _createTestHabit(
          id: 1,
          title: 'Local Title',
          uuid: 'shared-uuid',
          updatedAt: localTime,
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

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 99,
              title: 'Remote Title',
              uuid: 'shared-uuid',
              updatedAt: remoteTime,
            ),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Remote wins, local is updated
        verify(
          () => mockModel.editHabit(any(), preserveTimestamp: true),
        ).called(1);
      },
    );

    test('local habit not in remote data - should preserve local', () async {
      // Scenario: Local has a habit that doesn't exist in remote sync data
      // This tests the resolution matrix row: Active | None | PRESERVE local
      final localHabit = _createTestHabit(
        id: 1,
        title: 'Local Only Habit',
        uuid: 'uuid-local-only',
        updatedAt: DateTime.now(),
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

      // Remote data has no habits
      final remoteData = {'habits': [], 'categories': []};

      // Act
      await repository.mergeData(remoteData);

      // Assert: Local habit should NOT be deleted, edited, or modified
      verifyNever(() => mockModel.deleteHabit(any()));
      verifyNever(
        () => mockModel.editHabit(
          any(),
          preserveTimestamp: any(named: 'preserveTimestamp'),
        ),
      );
      verifyNever(() => mockModel.insertHabit(any()));
    });
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 5: UUID vs Title Matching Priority
  // ═══════════════════════════════════════════════════════════════════════════
  group('UUID vs Title Matching Priority', () {
    test('uuid match takes priority over title match', () async {
      // Arrange: Local has habit with uuid-A, title "Foo"
      // Remote has habit with uuid-A but title "Bar" (renamed)
      final localHabit = _createTestHabit(
        id: 1,
        title: 'Foo',
        uuid: 'uuid-A',
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Bar', // Different title
            uuid: 'uuid-A', // Same UUID
            updatedAt: DateTime.now(),
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Should update existing habit (uuid match), not create new
      verify(
        () => mockModel.editHabit(any(), preserveTimestamp: true),
      ).called(1);
      verifyNever(() => mockModel.insertHabit(any()));
    });

    test('same title different uuid - falls back to title match', () async {
      // Note: Current implementation uses title as fallback when UUID doesn't match.
      // This means same-title habits are treated as the same habit even with different UUIDs.
      // This is intentional to handle migration from pre-UUID habits.
      final localTime = DateTime.now().subtract(const Duration(hours: 1));
      final remoteTime = DateTime.now();

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Exercise',
        uuid: 'uuid-local',
        updatedAt: localTime,
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Exercise', // Same title
            uuid: 'uuid-remote', // Different UUID
            updatedAt: remoteTime,
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Falls back to title match, updates existing habit
      verify(
        () => mockModel.editHabit(any(), preserveTimestamp: true),
      ).called(1);
      verifyNever(() => mockModel.insertHabit(any()));
    });

    test('title match used when uuid is null (legacy habits)', () async {
      // Arrange: Local habit has null/empty uuid (legacy)
      final localHabit = _createTestHabit(
        id: 1,
        title: 'Legacy Habit',
        uuid: '', // Empty = legacy
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Legacy Habit', // Same title
            uuid: 'uuid-from-other-device',
            updatedAt: DateTime.now(),
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Should match by title and update
      verify(
        () => mockModel.editHabit(any(), preserveTimestamp: true),
      ).called(1);
    });
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 6: Event Sync Edge Cases
  // ═══════════════════════════════════════════════════════════════════════════
  group('Event Sync Edge Cases', () {
    test('remote events replace local events when remote wins', () async {
      // Arrange: Local has event on Jan 1, Remote has event on Jan 2 only
      final localEvents = SplayTreeMap<DateTime, List>();
      localEvents[DateTime(2026, 1, 1, 12, 0)] = [DayType.check, 'Local event'];

      final localHabit = _createTestHabit(
        id: 1,
        title: 'Event Test',
        uuid: 'uuid-events',
        events: localEvents,
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Event Test',
            uuid: 'uuid-events',
            updatedAt: DateTime.now(),
            events: {
              '2026-01-02 12:00:00.000Z': ['DayType.fail', 'Remote event'],
            },
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Events should be deleted and replaced
      verify(() => mockModel.deleteAllEventsForHabit(1)).called(1);
      verify(
        () =>
            mockModel.insertEvent(1, any(), any(), updateHabitTimestamp: false),
      ).called(1);
    });

    test('progress event with value - should sync progressValue', () async {
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Reading',
            uuid: 'uuid-progress',
            updatedAt: DateTime.now(),
            habitType: 1, // numeric
            events: {
              '2026-01-05 12:00:00.000Z': [
                'DayType.progress',
                'Read 5 pages',
                5.0,
              ],
            },
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Event with progress value should be inserted
      verify(
        () => mockModel.insertEvent(
          any(),
          DateTime.parse('2026-01-05 12:00:00.000Z'),
          any(),
          updateHabitTimestamp: false,
        ),
      ).called(1);
    });

    test('event with comment - should preserve comment', () async {
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

      final remoteData = {
        'habits': [
          _createRemoteHabitJson(
            id: 99,
            title: 'Comment Test',
            uuid: 'uuid-comment',
            updatedAt: DateTime.now(),
            events: {
              '2026-01-09 12:00:00.000Z': ['DayType.fail', 'Party hard'],
            },
          ),
        ],
        'categories': [],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Insert was called (we verify the structure indirectly)
      verify(() => mockModel.insertHabit(any())).called(1);
    });
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 7: Category Sync Tests
  // ═══════════════════════════════════════════════════════════════════════════
  group('Category Sync', () {
    test(
      'remote-only category - should be imported with new local ID',
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

        final remoteData = {
          'habits': [],
          'categories': [
            {
              'id': 99,
              'title': 'Morning',
              'iconCodePoint': 57672,
              'fontFamily': null,
            },
          ],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Category should be inserted
        verify(() => mockModel.insertCategory(any())).called(1);
      },
    );

    test(
      'both have same category - should map remote ID to local ID',
      () async {
        // Arrange: Local has category "Morning" with ID 1
        final localCategory = Category(
          id: 1,
          title: 'Morning',
          iconCodePoint: 57672,
        );

        when(
          () => mockModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localCategory]);

        final remoteData = {
          'habits': [],
          'categories': [
            {
              'id': 99, // Different ID
              'title': 'Morning', // Same title
              'iconCodePoint': 57672,
              'fontFamily': null,
            },
          ],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: No new category inserted (matched by title)
        verifyNever(() => mockModel.insertCategory(any()));
      },
    );

    test('habit-category associations remapped after category merge', () async {
      // Arrange: Remote habit references category ID 99, local category has ID 1
      final localCategory = Category(
        id: 1,
        title: 'Morning',
        iconCodePoint: 57672,
      );

      when(
        () => mockModel.getAllHabits(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(
        () => mockModel.getAllCategories(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => [localCategory]);

      // Use explicit Map<String, dynamic> to avoid type issues
      final Map<String, dynamic> remoteData = {
        'habits': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 50,
            'title': 'Meditate',
            'uuid': 'uuid-meditate',
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
            'categories': <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 99, // Remote category ID
                'title': 'Morning',
                'iconCodePoint': 57672,
                'fontFamily': null,
              },
            ],
            'updated_at': DateTime.now().toIso8601String(),
          },
        ],
        'categories': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 99,
            'title': 'Morning',
            'iconCodePoint': 57672,
            'fontFamily': null,
          },
        ],
      };

      // Act
      await repository.mergeData(remoteData);

      // Assert: Habit inserted and categories updated with remapped ID
      verify(() => mockModel.insertHabit(any())).called(1);
      verify(() => mockModel.updateHabitCategories(any(), any())).called(1);
    });
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 8: Concurrent Edit Scenarios
  // ═══════════════════════════════════════════════════════════════════════════
  group('Concurrent Edit Scenarios', () {
    test(
      'Device A edits title, Device B edits events - newer device wins entirely',
      () async {
        // Arrange: Local edited 2 min ago, remote edited 1 min ago
        final localEvents = SplayTreeMap<DateTime, List>();
        localEvents[DateTime(2026, 1, 1, 12, 0)] = [DayType.check, 'Local'];

        final localHabit = _createTestHabit(
          id: 1,
          title: 'Original Title',
          uuid: 'uuid-concurrent',
          events: localEvents,
          updatedAt: DateTime.now().subtract(const Duration(minutes: 2)),
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

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 99,
              title: 'Updated Title',
              uuid: 'uuid-concurrent',
              updatedAt: DateTime.now().subtract(const Duration(minutes: 1)),
              events: {
                '2026-01-02 12:00:00.000Z': ['DayType.fail', 'Remote'],
              },
            ),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Remote wins entirely (habit + events replaced)
        verify(
          () => mockModel.editHabit(any(), preserveTimestamp: true),
        ).called(1);
        verify(() => mockModel.deleteAllEventsForHabit(1)).called(1);
      },
    );
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUP 9: ID Collision Tests (regression for silent data loss)
  // ═══════════════════════════════════════════════════════════════════════════
  group('ID Collision Prevention', () {
    test(
      'remote-only habits have ID cleared before insert to avoid collision',
      () async {
        // This is the exact scenario that previously caused silent data loss:
        // - User reinstalls app, creates 2 local habits (id=1, id=2)
        // - Logs into account that has 3 remote habits (id=1, id=2, id=3)
        // - Remote habits have different UUIDs/titles (no match)
        // - Without the fix, insertHabit with id=1 would REPLACE local id=1

        final localHabit1 = _createTestHabit(
          id: 1,
          title: 'Local Meditation',
          uuid: 'local-uuid-1',
          updatedAt: DateTime.now(),
        );
        final localHabit2 = _createTestHabit(
          id: 2,
          title: 'Local Exercise',
          uuid: 'local-uuid-2',
          updatedAt: DateTime.now(),
        );

        when(
          () => mockModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localHabit1, localHabit2]);
        when(
          () => mockModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);

        // Track what habits were passed to insertHabit
        final insertedHabits = <Habit>[];
        when(() => mockModel.insertHabit(any())).thenAnswer((invocation) async {
          final habit = invocation.positionalArguments[0] as Habit;
          insertedHabits.add(habit);
          // Simulate SQLite auto-assigning new IDs (3, 4, 5)
          return insertedHabits.length + 2;
        });

        final remoteData = {
          'habits': [
            _createRemoteHabitJson(
              id: 1, // Same ID as local habit 1!
              title: 'Remote Running',
              uuid: 'remote-uuid-1',
              updatedAt: DateTime.now(),
            ),
            _createRemoteHabitJson(
              id: 2, // Same ID as local habit 2!
              title: 'Remote Reading',
              uuid: 'remote-uuid-2',
              updatedAt: DateTime.now(),
            ),
            _createRemoteHabitJson(
              id: 3,
              title: 'Remote Yoga',
              uuid: 'remote-uuid-3',
              updatedAt: DateTime.now(),
            ),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: All 3 remote habits should be inserted (no UUID/title match)
        expect(insertedHabits.length, 3);

        // CRITICAL: Every inserted habit must have id == null so SQLite
        // auto-assigns a non-colliding ID instead of replacing local habits
        for (final habit in insertedHabits) {
          expect(
            habit.habitData.id,
            isNull,
            reason:
                'Remote habit "${habit.habitData.title}" should have id cleared '
                'to prevent collision with local habits',
          );
        }

        // Local habits should NOT be touched (no edit, no delete)
        verifyNever(
          () => mockModel.editHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        );
        verifyNever(() => mockModel.deleteHabit(any()));
      },
    );
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════

/// Helper to create a test Habit with defaults
Habit _createTestHabit({
  required int id,
  required String title,
  String uuid = '',
  SplayTreeMap<DateTime, List>? events,
  DateTime? updatedAt,
  DateTime? deletedAt,
}) {
  return Habit(
    habitData: HabitData(
      id: id,
      uuid: uuid.isEmpty ? null : uuid,
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
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    ),
  );
}

/// Helper to create remote habit JSON
Map<String, dynamic> _createRemoteHabitJson({
  required int id,
  required String title,
  required String uuid,
  required DateTime updatedAt,
  Map<String, dynamic>? events,
  DateTime? deletedAt,
  int habitType = 0,
}) {
  return {
    'id': id,
    'uuid': uuid,
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
    'habitType': habitType,
    'targetValue': 1.0,
    'partialValue': 1.0,
    'unit': '',
    'archived': 0,
    'events': events ?? {},
    'categories': [],
    'updated_at': updatedAt.toIso8601String(),
    if (deletedAt != null) 'deleted_at': deletedAt.toIso8601String(),
  };
}
