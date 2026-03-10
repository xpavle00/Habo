import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/category.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/constants.dart';
import 'package:habo/repositories/sqlite_backup_repository.dart';

class MockHaboModel extends Mock implements HaboModel {}

void main() {
  late SQLiteBackupRepository repository;
  late MockHaboModel mockHaboModel;

  // Test fixtures
  Habit createTestHabit({
    int? id,
    required String title,
    DateTime? deletedAt,
    SplayTreeMap<DateTime, List>? events,
    List<Category>? categories,
  }) {
    return Habit(
      habitData: HabitData(
        id: id,
        title: title,
        position: 0,
        twoDayRule: false,
        cue: 'Test cue',
        routine: 'Test routine',
        reward: 'Test reward',
        showReward: false,
        advanced: false,
        events: events ?? SplayTreeMap<DateTime, List>(),
        notification: false,
        notTime: const TimeOfDay(hour: 9, minute: 0),
        sanction: '',
        showSanction: false,
        accountant: '',
        deletedAt: deletedAt,
        categories: categories ?? [],
      ),
    );
  }

  setUp(() {
    mockHaboModel = MockHaboModel();
    repository = SQLiteBackupRepository(mockHaboModel);

    // Register fallback values
    registerFallbackValue(createTestHabit(title: 'Fallback'));
    registerFallbackValue(Category(title: 'Fallback', iconCodePoint: 0xe047));
  });

  group('SQLiteBackupRepository.mergeData Tests', () {
    group('Habit Merge Scenarios', () {
      test('merges new remote habit when local is empty', () async {
        // Arrange: No local habits
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async => 1);
        when(
          () => mockHaboModel.insertEvent(
            any(),
            any(),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.updateHabitCategories(any(), any()),
        ).thenAnswer((_) async {});

        final remoteData = {
          'habits': [createTestHabit(id: 100, title: 'Remote Habit').toJson()],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert
        verify(() => mockHaboModel.insertHabit(any())).called(1);
      });

      test('updates local habit when remote exists with same title', () async {
        // Arrange: Local habit with same title
        final localHabit = createTestHabit(id: 1, title: 'Shared Habit');
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localHabit]);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.editHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.deleteAllEventsForHabit(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.insertEvent(
            any(),
            any(),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.updateHabitCategories(any(), any()),
        ).thenAnswer((_) async {});

        final remoteData = {
          'habits': [createTestHabit(id: 200, title: 'Shared Habit').toJson()],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Should update (editHabit), not insert
        verify(
          () => mockHaboModel.editHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        ).called(1);
        verifyNever(() => mockHaboModel.insertHabit(any()));
      });

      test('deletes local habit when remote is marked as deleted', () async {
        // Arrange: Local habit exists
        final localHabit = createTestHabit(id: 1, title: 'To Be Deleted');
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localHabit]);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(() => mockHaboModel.deleteHabit(any())).thenAnswer((_) async {});

        final remoteData = {
          'habits': [
            createTestHabit(
              id: 200,
              title: 'To Be Deleted',
              deletedAt: DateTime.now(),
            ).toJson(),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert
        verify(() => mockHaboModel.softDeleteHabitAt(1, any())).called(1);
      });

      test('ignores remote deleted habit if not present locally', () async {
        // Arrange: No local habits
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);

        final remoteData = {
          'habits': [
            createTestHabit(
              id: 200,
              title: 'Already Deleted',
              deletedAt: DateTime.now(),
            ).toJson(),
          ],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: No insertions or deletions
        verifyNever(() => mockHaboModel.insertHabit(any()));
        verifyNever(() => mockHaboModel.deleteHabit(any()));
      });
    });

    group('Event Merge Scenarios', () {
      test('merges remote events into local habit', () async {
        // Arrange
        final localHabit = createTestHabit(id: 1, title: 'Habit With Events');
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localHabit]);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.editHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.deleteAllEventsForHabit(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.insertEvent(
            any(),
            any(),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.updateHabitCategories(any(), any()),
        ).thenAnswer((_) async {});

        // Remote habit with events - use DayType enum values
        final events = SplayTreeMap<DateTime, List>();
        events[DateTime(2024, 1, 1)] = [DayType.check, 'comment'];
        events[DateTime(2024, 1, 2)] = [DayType.fail, ''];
        final remoteHabit = createTestHabit(
          id: 200,
          title: 'Habit With Events',
          events: events,
        );

        final remoteData = {
          'habits': [remoteHabit.toJson()],
          'categories': [],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Two events should be inserted
        verify(
          () => mockHaboModel.insertEvent(
            1,
            any(),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).called(2);
      });
    });

    group('Category Merge Scenarios', () {
      test('merges new remote category', () async {
        // Arrange
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.insertCategory(any()),
        ).thenAnswer((_) async => 10);

        final remoteData = {
          'habits': [],
          'categories': [
            Category(
              id: 1,
              title: 'New Category',
              iconCodePoint: 0xe047,
            ).toJson(),
          ],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert
        verify(() => mockHaboModel.insertCategory(any())).called(1);
      });

      test('existing category just maps ID without update', () async {
        // Arrange: With LWW, existing categories are matched by title and ID is mapped
        // but we don't update the category properties (simplification for categories)
        final localCategory = Category(
          id: 5,
          title: 'Shared Category',
          iconCodePoint: 0xe047,
        );
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localCategory]);
        when(
          () => mockHaboModel.updateCategory(any()),
        ).thenAnswer((_) async {});

        final remoteData = {
          'habits': [],
          'categories': [
            Category(
              id: 100,
              title: 'Shared Category',
              iconCodePoint: 0xe050,
            ).toJson(),
          ],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: No insert, but update called because icon code differs
        verifyNever(() => mockHaboModel.insertCategory(any()));
        verify(() => mockHaboModel.updateCategory(any())).called(1);
      });

      test('maps remote category IDs to local when linking habits', () async {
        // Arrange
        final localCategory = Category(
          id: 5,
          title: 'Work',
          iconCodePoint: 0xe047,
        );
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localCategory]);
        when(
          () => mockHaboModel.updateCategory(any()),
        ).thenAnswer((_) async {});
        when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async => 1);
        when(
          () => mockHaboModel.insertEvent(
            any(),
            any(),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.updateHabitCategories(any(), any()),
        ).thenAnswer((_) async {});

        // Remote habit linked to remote category ID 99
        final remoteCategory = Category(
          id: 99,
          title: 'Work',
          iconCodePoint: 0xe047,
        );
        final remoteHabit = createTestHabit(
          id: 200,
          title: 'New Remote Habit',
          categories: [remoteCategory],
        );

        final remoteData = {
          'habits': [remoteHabit.toJson()],
          'categories': [remoteCategory.toJson()],
        };

        // Act
        await repository.mergeData(remoteData);

        // Assert: Habit should be linked using local category ID (5), not remote (99)
        verify(() => mockHaboModel.updateHabitCategories(1, any())).called(1);
      });
    });

    group('Edge Cases', () {
      test('handles empty remote data gracefully', () async {
        // Arrange
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);

        final remoteData = <String, dynamic>{'habits': [], 'categories': []};

        // Act
        await repository.mergeData(remoteData);

        // Assert: No operations
        verifyNever(() => mockHaboModel.insertHabit(any()));
        verifyNever(
          () => mockHaboModel.editHabit(
            any(),
            preserveTimestamp: any(named: 'preserveTimestamp'),
          ),
        );
      });

      test('handles missing habits key in remote data', () async {
        // Act & Assert: Should return early without error
        await repository.mergeData({'categories': []});

        verifyNever(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        );
      });

      test('local-only habits are preserved during merge', () async {
        // Arrange: Local habit not in remote
        final localHabit = createTestHabit(id: 1, title: 'Local Only Habit');
        when(
          () => mockHaboModel.getAllHabits(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => [localHabit]);
        when(
          () => mockHaboModel.getAllCategories(
            includeDeleted: any(named: 'includeDeleted'),
          ),
        ).thenAnswer((_) async => []);

        final remoteData = {
          'habits': [
            createTestHabit(id: 200, title: 'Different Remote Habit').toJson(),
          ],
          'categories': [],
        };

        when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async => 2);
        when(
          () => mockHaboModel.insertEvent(
            any(),
            any(),
            any(),
            updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockHaboModel.updateHabitCategories(any(), any()),
        ).thenAnswer((_) async {});

        // Act
        await repository.mergeData(remoteData);

        // Assert: Remote habit inserted, local preserved (no delete)
        verify(() => mockHaboModel.insertHabit(any())).called(1);
        verifyNever(() => mockHaboModel.deleteHabit(1));
      });
    });
  });

  group('SQLiteBackupRepository.importData Tests', () {
    setUp(() {
      // importData snapshots existing habits before clearing
      when(
        () => mockHaboModel.getAllHabits(
          includeDeleted: any(named: 'includeDeleted'),
        ),
      ).thenAnswer((_) async => []);
      when(() => mockHaboModel.deleteHabit(any())).thenAnswer((_) async {});
      when(
        () => mockHaboModel.softDeleteHabitAt(any(), any()),
      ).thenAnswer((_) async {});
      registerFallbackValue(DateTime.now());
    });
    test('calls emptyTables for hard delete before import', () async {
      // Arrange
      when(() => mockHaboModel.emptyTables()).thenAnswer((_) async {});
      when(
        () => mockHaboModel.insertCategory(any()),
      ).thenAnswer((_) async => 1);
      when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async => 1);
      when(
        () => mockHaboModel.insertEvent(
          any(),
          any(),
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockHaboModel.updateHabitCategories(any(), any()),
      ).thenAnswer((_) async {});

      final backupData = {
        'habits': [],
        'categories': [],
        'habit_categories': [],
      };

      // Act
      await repository.importData(backupData);

      // Assert: emptyTables called for hard delete
      verify(() => mockHaboModel.emptyTables()).called(1);
    });

    test('imports categories and builds ID mapping', () async {
      // Arrange
      when(() => mockHaboModel.emptyTables()).thenAnswer((_) async {});
      when(
        () => mockHaboModel.insertCategory(any()),
      ).thenAnswer((_) async => 10); // New ID assigned
      when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async => 1);
      when(
        () => mockHaboModel.updateHabitCategories(any(), any()),
      ).thenAnswer((_) async {});

      final backupData = {
        'habits': [],
        'categories': [
          {'id': 1, 'title': 'Category 1', 'iconCodePoint': 0xe047},
          {'id': 2, 'title': 'Category 2', 'iconCodePoint': 0xe048},
        ],
        'habit_categories': [],
      };

      // Act
      await repository.importData(backupData);

      // Assert: Both categories imported
      verify(() => mockHaboModel.insertCategory(any())).called(2);
    });

    test('imports habits with their events', () async {
      // Arrange
      when(() => mockHaboModel.emptyTables()).thenAnswer((_) async {});
      when(
        () => mockHaboModel.insertCategory(any()),
      ).thenAnswer((_) async => 1);
      when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async => 100);
      when(
        () => mockHaboModel.insertEvent(
          any(),
          any(),
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockHaboModel.updateHabitCategories(any(), any()),
      ).thenAnswer((_) async {});

      final testDate = DateTime(2025, 1, 1);
      final habitWithEvents = createTestHabit(
        id: 1,
        title: 'Habit With Events',
        events: SplayTreeMap<DateTime, List>.from({
          testDate: [DayType.check, 'Test comment'],
        }),
      );

      final backupData = {
        'habits': [habitWithEvents.toJson()],
        'categories': [],
        'habit_categories': [],
      };

      // Act
      await repository.importData(backupData);

      // Assert: Habit and event imported
      verify(() => mockHaboModel.insertHabit(any())).called(1);
      verify(
        () => mockHaboModel.insertEvent(
          100,
          testDate,
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).called(1);
    });

    test('imports habit-category associations with remapped IDs', () async {
      // Arrange
      int categoryInsertCount = 0;
      when(() => mockHaboModel.emptyTables()).thenAnswer((_) async {});
      when(() => mockHaboModel.insertCategory(any())).thenAnswer((_) async {
        categoryInsertCount++;
        return categoryInsertCount * 100; // New IDs: 100, 200, etc.
      });

      int habitInsertCount = 0;
      when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async {
        habitInsertCount++;
        return habitInsertCount * 10; // New IDs: 10, 20, etc.
      });

      when(
        () => mockHaboModel.insertEvent(
          any(),
          any(),
          any(),
          updateHabitTimestamp: any(named: 'updateHabitTimestamp'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockHaboModel.addHabitToCategory(any(), any()),
      ).thenAnswer((_) async {});

      final backupData = {
        'habits': [createTestHabit(id: 1, title: 'Test Habit').toJson()],
        'categories': [
          {'id': 5, 'title': 'Old Category', 'iconCodePoint': 0xe047},
        ],
        'habit_categories': [
          {'habit_id': 1, 'category_id': 5}, // Old IDs
        ],
      };

      // Act
      await repository.importData(backupData);

      // Assert: addHabitToCategory called with new remapped IDs
      // Old habit_id 1 -> new 10, old category_id 5 -> new 100
      verify(() => mockHaboModel.addHabitToCategory(10, 100)).called(1);
    });

    test('handles empty backup gracefully', () async {
      // Arrange
      when(() => mockHaboModel.emptyTables()).thenAnswer((_) async {});

      final backupData = {
        'habits': [],
        'categories': [],
        'habit_categories': [],
      };

      // Act & Assert: Should not throw
      await expectLater(repository.importData(backupData), completes);

      verify(() => mockHaboModel.emptyTables()).called(1);
      verifyNever(() => mockHaboModel.insertHabit(any()));
      verifyNever(() => mockHaboModel.insertCategory(any()));
    });
  });
}
