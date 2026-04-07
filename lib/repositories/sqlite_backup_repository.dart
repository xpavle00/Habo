import 'package:flutter/material.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/category.dart';
import 'backup_repository.dart';

/// SQLite implementation of the BackupRepository interface.
/// This class wraps the existing HaboModel to provide backup functionality
/// through the repository pattern while maintaining backward compatibility.
class SQLiteBackupRepository implements BackupRepository {
  final HaboModel _haboModel;

  SQLiteBackupRepository(this._haboModel);

  @override
  Future<Map<String, dynamic>> exportAllData() async {
    try {
      final habits = await _haboModel.getAllHabits(includeDeleted: true);
      final categories = await _haboModel.getAllCategories(
        includeDeleted: true,
      );

      final data = <String, dynamic>{
        'habits': <dynamic>[],
        'events': <String, dynamic>{},
        'categories': <dynamic>[],
        'habit_categories': <dynamic>[],
        'metadata': {
          'export_timestamp': DateTime.now().toIso8601String(),
          'version': '1.0',
          'total_habits': habits.length,
          'total_categories': categories.length,
        },
      };

      // Export habits with their events
      debugPrint('\n--- EXPORT START (${habits.length} habits) ---');
      for (final habit in habits) {
        try {
          debugPrint(
            'EXPORT: id=${habit.habitData.id} '
            '"${habit.habitData.title}" '
            'uuid=${habit.habitData.uuid} '
            'pos=${habit.habitData.position} '
            'deleted=${habit.habitData.deletedAt != null} '
            'updatedAt=${habit.habitData.updatedAt.toIso8601String()} '
            'events=${habit.habitData.events.length}',
          );
          // Use the habit's toJson method which includes events
          (data['habits'] as List).add(habit.toJson());
        } catch (e) {
          debugPrint(
            'Warning: Failed to export habit ${habit.habitData.id}: $e',
          );
        }
      }
      debugPrint('--- EXPORT END ---\n');

      // Export categories
      for (final category in categories) {
        try {
          (data['categories'] as List).add(category.toJson());
        } catch (e) {
          debugPrint('Warning: Failed to export category ${category.id}: $e');
        }
      }

      // Export habit-category associations
      int associationCount = 0;
      for (final habit in habits) {
        if (habit.habitData.id != null) {
          try {
            // Get categories directly from database to ensure we have all associations
            final habitCategories = await _haboModel.getCategoriesForHabit(
              habit.habitData.id!,
            );
            for (final category in habitCategories) {
              if (category.id != null) {
                (data['habit_categories'] as List).add({
                  'habit_id': habit.habitData.id,
                  'category_id': category.id,
                });
                associationCount++;
              }
            }
          } catch (e) {
            debugPrint(
              'Warning: Failed to export categories for habit ${habit.habitData.id}: $e',
            );
          }
        }
      }

      // Update metadata with actual counts
      (data['metadata'] as Map<String, dynamic>)['total_associations'] =
          associationCount;

      debugPrint(
        'Backup export completed: ${habits.length} habits, ${categories.length} categories, $associationCount associations',
      );
      return data;
    } catch (e) {
      debugPrint('Error during backup export: $e');
      rethrow;
    }
  }

  @override
  Future<void> importData(Map<String, dynamic> data) async {
    try {
      debugPrint('Starting backup import...');

      // Validate backup data structure
      if (!data.containsKey('habits') || !data.containsKey('categories')) {
        throw Exception('Invalid backup format: missing required sections');
      }

      // Log metadata if available
      if (data.containsKey('metadata')) {
        final metadata = data['metadata'] as Map<String, dynamic>;
        debugPrint(
          'Importing backup from ${metadata['export_timestamp']} with ${metadata['total_habits']} habits and ${metadata['total_categories']} categories',
        );
      }

      // ─── Snapshot existing habits BEFORE clearing ───
      // We need to know what existed so we can create soft-delete records
      // for habits that are missing from the backup. This ensures deletions
      // propagate to other devices via LWW sync.
      final existingHabits = await _haboModel.getAllHabits(
        includeDeleted: true,
      );
      final existingByUuid = <String, Habit>{};
      final existingByTitle = <String, Habit>{};
      for (final h in existingHabits) {
        final uuid = h.habitData.uuid;
        if (uuid.isNotEmpty) {
          existingByUuid[uuid] = h;
        }
        existingByTitle[h.habitData.title] = h;
      }
      debugPrint(
        'Snapshot: ${existingHabits.length} pre-existing habits captured',
      );

      // Clear existing data - HARD DELETE (not soft delete)
      // This ensures a complete replacement with backup data
      debugPrint('Clearing existing data (hard delete)...');
      await _haboModel.emptyTables(); // Deletes all data tables

      // Map to track old category ID -> new category ID
      final Map<int, int> categoryIdMapping = {};

      // Import categories first and build ID mapping
      debugPrint('Importing categories...');
      final categoriesData = data['categories'] as List;
      int importedCategories = 0;

      for (final categoryJson in categoriesData) {
        try {
          final category = Category.fromJson(categoryJson);
          final oldId = category.id;

          // Create category without ID so database assigns new one, but preserve UUID
          final categoryToInsert = Category(
            uuid: category.uuid,
            title: category.title,
            iconCodePoint: category.iconCodePoint,
            fontFamily: category.fontFamily,
          );

          // Insert category and get the new ID
          final newId = await _haboModel.insertCategory(categoryToInsert);

          // Map old ID to new ID if old ID existed
          if (oldId != null) {
            categoryIdMapping[oldId] = newId;
          }

          importedCategories++;
        } catch (e) {
          debugPrint('Warning: Failed to import category: $e');
        }
      }

      debugPrint('Imported $importedCategories categories');

      // Map to track old habit ID -> new habit ID
      final Map<int, int> habitIdMapping = {};

      // Track which pre-existing habits are present in the backup
      final importedUuids = <String>{};
      final importedTitles = <String>{};

      // Import habits (including their events)
      debugPrint('Importing habits...');
      final habitsData = data['habits'] as List;
      int importedHabits = 0;
      int importedEvents = 0;

      for (final habitJson in habitsData) {
        try {
          // Create habit from JSON
          final habit = Habit.fromJson(habitJson);
          final oldHabitId = habit.habitData.id;

          // Track this habit's identity for the soft-delete pass later
          final uuid = habit.habitData.uuid;
          if (uuid.isNotEmpty) {
            importedUuids.add(uuid);
          }
          importedTitles.add(habit.habitData.title);

          // Insert habit and get the new ID
          final newHabitId = await _haboModel.insertHabit(habit);

          // If the backup habit was soft-deleted, preserve the original
          // deletedAt timestamp so LWW resolution remains correct across
          // devices. Using deleteHabit() here would stamp DateTime.now()
          // and corrupt the original deletion time.
          if (habit.habitData.deletedAt != null) {
            await _haboModel.softDeleteHabitAt(
              newHabitId,
              habit.habitData.deletedAt!,
            );
          }

          // Map old habit ID to new habit ID if old ID existed
          if (oldHabitId != null) {
            habitIdMapping[oldHabitId] = newHabitId;
          }

          // Insert events for this habit using the NEW habit ID
          if (habit.habitData.events.isNotEmpty) {
            for (final entry in habit.habitData.events.entries) {
              try {
                await _haboModel.insertEvent(
                  newHabitId,
                  entry.key,
                  entry.value,
                );
                importedEvents++;
              } catch (e) {
                debugPrint(
                  'Warning: Failed to import event for habit $newHabitId at ${entry.key}: $e',
                );
              }
            }
          }

          importedHabits++;
        } catch (e) {
          debugPrint('Warning: Failed to import habit: $e');
        }
      }

      // ─── Create soft-delete records for missing habits ───
      // Habits that existed before the restore but are NOT in the backup
      // need explicit soft-delete records so the deletion propagates to
      // other devices via LWW sync.
      int softDeletedMissing = 0;
      for (final existing in existingHabits) {
        final uuid = existing.habitData.uuid;
        final title = existing.habitData.title;

        // Check if already imported (by UUID or title)
        final foundByUuid = uuid.isNotEmpty && importedUuids.contains(uuid);
        final foundByTitle = importedTitles.contains(title);

        if (!foundByUuid && !foundByTitle) {
          // This habit was NOT in the backup — create a soft-delete record
          // so other devices know to delete it
          try {
            final deletedHabitId = await _haboModel.insertHabit(existing);
            await _haboModel.deleteHabit(deletedHabitId);
            softDeletedMissing++;
            debugPrint(
              'Created soft-delete record for missing habit: "$title" (uuid=$uuid)',
            );
          } catch (e) {
            debugPrint(
              'Warning: Failed to create soft-delete for missing habit "$title": $e',
            );
          }
        }
      }

      debugPrint(
        'Imported $importedHabits habits, $importedEvents events, soft-deleted $softDeletedMissing missing habits',
      );

      // Import habit-category associations using the ID mappings
      if (data.containsKey('habit_categories')) {
        debugPrint('Importing habit-category associations...');
        final habitCategoriesData = data['habit_categories'] as List;
        int importedAssociations = 0;

        for (final association in habitCategoriesData) {
          try {
            final oldHabitId = association['habit_id'] as int;
            final oldCategoryId = association['category_id'] as int;

            // Get the new IDs from our mappings
            final newHabitId = habitIdMapping[oldHabitId];
            final newCategoryId = categoryIdMapping[oldCategoryId];

            // Only add association if both IDs were successfully mapped
            if (newHabitId != null && newCategoryId != null) {
              await _haboModel.addHabitToCategory(newHabitId, newCategoryId);
              importedAssociations++;
            } else {
              debugPrint(
                'Warning: Skipping association - habit ID $oldHabitId -> $newHabitId, category ID $oldCategoryId -> $newCategoryId',
              );
            }
          } catch (e) {
            debugPrint(
              'Warning: Failed to import habit-category association: $e',
            );
          }
        }

        debugPrint(
          'Imported $importedAssociations habit-category associations',
        );
      }

      debugPrint('Backup import completed successfully!');
    } catch (e) {
      debugPrint('Error during backup import: $e');
      rethrow;
    }
  }

  @override
  Future<int> getDatabaseVersion() async {
    return 1;
  }

  @override
  Future<String> getDatabasePath() async {
    return 'habo_database.db';
  }

  @override
  Future<void> closeDatabase() async {
    // HaboModel doesn't have explicit close method
    // This is handled by the existing HaboModel lifecycle
  }

  @override
  Future<void> reopenDatabase() async {
    // HaboModel doesn't have explicit reopen method
    // This is handled by the existing HaboModel lifecycle
  }

  @override
  Future<int> getHabitCount() async {
    final habits = await _haboModel.getAllHabits();
    return habits.length;
  }

  @override
  Future<int> getEventCount() async {
    final habits = await _haboModel.getAllHabits();
    int eventCount = 0;
    for (final habit in habits) {
      eventCount += habit.habitData.events.length;
    }
    return eventCount;
  }

  /// Get the total number of categories in the database
  Future<int> getCategoryCount() async {
    final categories = await _haboModel.getAllCategories();
    return categories.length;
  }

  /// Get the total number of habit-category associations
  Future<int> getHabitCategoryAssociationCount() async {
    final habits = await _haboModel.getAllHabits();
    int associationCount = 0;
    for (final habit in habits) {
      if (habit.habitData.id != null) {
        final habitCategories = await _haboModel.getCategoriesForHabit(
          habit.habitData.id!,
        );
        associationCount += habitCategories.length;
      }
    }
    return associationCount;
  }

  @override
  Future<bool> validateDatabaseIntegrity() async {
    try {
      await _haboModel.getAllHabits();
      await _haboModel.getAllCategories();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> mergeData(Map<String, dynamic> remoteData) async {
    try {
      debugPrint('\n--- LWW MERGE START ---');

      if (!remoteData.containsKey('habits')) {
        debugPrint('MERGE: No habits in remote data, skipping merge.');
        return;
      }

      // Get ALL local habits including deleted (for proper conflict resolution)
      final localHabits = await _haboModel.getAllHabits(includeDeleted: true);
      debugPrint('MERGE: ${localHabits.length} local habits (incl. deleted):');
      for (int i = 0; i < localHabits.length; i++) {
        final h = localHabits[i];
        debugPrint(
          '  LOCAL[$i]: id=${h.habitData.id} '
          '"${h.habitData.title}" uuid=${h.habitData.uuid} '
          'updatedAt=${h.habitData.updatedAt.toIso8601String()} '
          'deletedAt=${h.habitData.deletedAt?.toIso8601String()} '
          'events=${h.habitData.events.length}',
        );
      }

      // Build maps for quick lookup - prefer uuid, fallback to title
      final localHabitsByUuid = <String, Habit>{};
      final localHabitsByTitle = <String, Habit>{};
      for (final habit in localHabits) {
        localHabitsByUuid[habit.habitData.uuid] = habit;
        // Only index NON-DELETED habits by title to prevent false matches
        // between soft-deleted local habits and unrelated remote habits
        // that happen to share the same title.
        if (habit.habitData.deletedAt == null) {
          localHabitsByTitle[habit.habitData.title] = habit;
        }
      }

      // Get local categories as a map by uuid and title (include deleted for matching)
      final localCategories = await _haboModel.getAllCategories(
        includeDeleted: true,
      );
      final localCategoriesByUuid = <String, Category>{};
      final localCategoriesByTitle = <String, Category>{};
      for (final cat in localCategories) {
        localCategoriesByUuid[cat.uuid] = cat;
        if (!cat.isDeleted) {
          localCategoriesByTitle[cat.title] = cat;
        }
      }

      // Track category ID mappings (remote ID -> local ID)
      final Map<int, int> categoryIdMapping = {};
      int mergedCategories = 0;

      // Merge categories first
      if (remoteData.containsKey('categories')) {
        final remoteCategories = remoteData['categories'] as List;
        for (final remoteCatJson in remoteCategories) {
          try {
            final remoteCategory = Category.fromJson(remoteCatJson);
            final oldRemoteId = remoteCategory.id;

            // Match by UUID first, then fallback to title
            Category? localCategory =
                localCategoriesByUuid[remoteCategory.uuid];
            localCategory ??= localCategoriesByTitle[remoteCategory.title];

            if (localCategory == null) {
              // Remote-only: import it (but skip if it's already deleted remotely)
              if (!remoteCategory.isDeleted) {
                final categoryToInsert = Category(
                  uuid: remoteCategory.uuid,
                  title: remoteCategory.title,
                  iconCodePoint: remoteCategory.iconCodePoint,
                  fontFamily: remoteCategory.fontFamily,
                );
                final newId = await _haboModel.insertCategory(categoryToInsert);
                if (oldRemoteId != null) {
                  categoryIdMapping[oldRemoteId] = newId;
                }
                mergedCategories++;
              }
            } else {
              // Matched — check if remote has deleted the category
              if (remoteCategory.isDeleted && !localCategory.isDeleted) {
                // Remote deleted, local still alive — LWW: check timestamps
                if (remoteCategory.updatedAt.isAfter(localCategory.updatedAt)) {
                  if (localCategory.id != null) {
                    await _haboModel.deleteCategory(localCategory.id!);
                    debugPrint(
                      'Soft-deleted category "${localCategory.title}" (uuid=${remoteCategory.uuid}) from remote',
                    );
                  }
                }
              } else if (!remoteCategory.isDeleted) {
                // Both alive — LWW: only update if remote is newer
                if (remoteCategory.updatedAt.isAfter(localCategory.updatedAt) &&
                    (localCategory.title != remoteCategory.title ||
                        localCategory.iconCodePoint !=
                            remoteCategory.iconCodePoint ||
                        localCategory.fontFamily !=
                            remoteCategory.fontFamily)) {
                  localCategory.title = remoteCategory.title;
                  localCategory.iconCodePoint = remoteCategory.iconCodePoint;
                  localCategory.fontFamily = remoteCategory.fontFamily;
                  await _haboModel.updateCategory(localCategory);
                  debugPrint(
                    'Updated category "${remoteCategory.title}" (uuid=${remoteCategory.uuid})',
                  );
                }
              }
              // Map remote ID to local ID
              if (oldRemoteId != null && localCategory.id != null) {
                categoryIdMapping[oldRemoteId] = localCategory.id!;
              }
            }
          } catch (e) {
            debugPrint('Warning: Failed to merge category: $e');
          }
        }
      }

      debugPrint('Merged $mergedCategories new categories');

      // Merge habits with LWW
      final remoteHabits = remoteData['habits'] as List;
      int newHabits = 0;
      int updatedHabits = 0;
      int skippedHabits = 0;
      int mergedEvents = 0;

      for (final remoteHabitJson in remoteHabits) {
        try {
          final remoteHabit = Habit.fromJson(remoteHabitJson);
          final remoteUpdatedAt = remoteHabit.habitData.updatedAt;
          final remoteDeletedAt = remoteHabit.habitData.deletedAt;

          debugPrint(
            'MERGE: Processing remote habit: "${remoteHabit.habitData.title}" '
            'uuid=${remoteHabit.habitData.uuid} '
            'updatedAt=${remoteUpdatedAt.toIso8601String()} '
            'deletedAt=${remoteDeletedAt?.toIso8601String()}',
          );

          // Find local habit by uuid first, then fallback to title
          Habit? localHabit = localHabitsByUuid[remoteHabit.habitData.uuid];
          final matchedBy = localHabit != null ? 'uuid' : null;
          localHabit ??= localHabitsByTitle[remoteHabit.habitData.title];
          final finalMatchedBy =
              matchedBy ?? (localHabit != null ? 'title' : 'NONE');

          debugPrint(
            'MERGE:   Matched local: ${localHabit != null ? '"${localHabit.habitData.title}" id=${localHabit.habitData.id} (by $finalMatchedBy)' : 'NO MATCH'}',
          );

          // Map category IDs
          for (final cat in remoteHabit.habitData.categories) {
            if (cat.id != null) {
              final mappedId = categoryIdMapping[cat.id];
              if (mappedId != null) {
                cat.id = mappedId;
              }
            }
          }

          if (localHabit == null) {
            // Remote-only habit
            if (remoteDeletedAt != null) {
              // Remote is deleted, no local - skip
              debugPrint('MERGE:   -> SKIP (remote-only but deleted)');
              continue;
            }
            debugPrint('MERGE:   -> INSERT NEW (remote-only, not deleted)');
            // Import new habit — CRITICAL: clear the ID so SQLite auto-assigns
            // a new one. If we keep the remote's integer ID, it can collide
            // with an existing local habit ID and silently replace it
            // (ConflictAlgorithm.replace).
            remoteHabit.habitData.id = null;
            final newHabitId = await _haboModel.insertHabit(
              remoteHabit,
              preserveTimestamp: true,
            );
            debugPrint(
              'MERGE:   Inserted with new local id=$newHabitId '
              '(uuid=${remoteHabit.habitData.uuid})',
            );
            if (remoteHabit.habitData.categories.isNotEmpty) {
              await _haboModel.updateHabitCategories(
                newHabitId,
                remoteHabit.habitData.categories,
              );
            }
            for (final entry in remoteHabit.habitData.events.entries) {
              await _haboModel.insertEvent(
                newHabitId,
                entry.key,
                entry.value,
                updateHabitTimestamp: false,
              );
              mergedEvents++;
            }
            newHabits++;
          } else {
            // Both exist - apply LWW
            final localHabitId = localHabit.habitData.id!;
            final localUpdatedAt = localHabit.habitData.updatedAt;
            final localDeletedAt = localHabit.habitData.deletedAt;

            // Determine the "effective timestamp" for conflict resolution
            // Per LWW spec: effectiveTimestamp = MAX(updated_at, deleted_at ?? epoch)
            final epoch = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
            final remoteTimestamp =
                remoteUpdatedAt.isAfter(remoteDeletedAt ?? epoch)
                ? remoteUpdatedAt
                : remoteDeletedAt!;
            final localTimestamp =
                localUpdatedAt.isAfter(localDeletedAt ?? epoch)
                ? localUpdatedAt
                : localDeletedAt!;

            debugPrint(
              'MERGE:   LWW comparison for "${remoteHabit.habitData.title}":',
            );
            debugPrint(
              'MERGE:     remote: updatedAt=${remoteUpdatedAt.toIso8601String()} '
              'deletedAt=${remoteDeletedAt?.toIso8601String()} '
              '-> effective=${remoteTimestamp.toIso8601String()}',
            );
            debugPrint(
              'MERGE:     local:  updatedAt=${localUpdatedAt.toIso8601String()} '
              'deletedAt=${localDeletedAt?.toIso8601String()} '
              '-> effective=${localTimestamp.toIso8601String()}',
            );

            // LWW: Remote wins if remote timestamp > local timestamp
            if (remoteTimestamp.isAfter(localTimestamp)) {
              debugPrint(
                'MERGE:     -> REMOTE WINS '
                '(remote ${remoteTimestamp.toIso8601String()} > '
                'local ${localTimestamp.toIso8601String()})',
              );
              if (remoteDeletedAt != null) {
                debugPrint('MERGE:     -> Applying soft-delete from remote');
                // Remote says delete - apply soft delete locally,
                // preserving the remote's original deletedAt timestamp
                await _haboModel.softDeleteHabitAt(
                  localHabitId,
                  remoteDeletedAt,
                );
              } else {
                debugPrint(
                  'MERGE:     -> Updating local with remote data '
                  '(events: ${remoteHabit.habitData.events.length})',
                );
                // Remote is newer - update local with remote data
                remoteHabit.habitData.id = localHabitId;
                // CRITICAL: preserveTimestamp=true to keep remote's updatedAt,
                // otherwise editHabit sets it to now() which corrupts LWW
                await _haboModel.editHabit(
                  remoteHabit,
                  preserveTimestamp: true,
                );
                await _haboModel.updateHabitCategories(
                  localHabitId,
                  remoteHabit.habitData.categories,
                );

                // Replace local events with remote events.
                // Since deleted events don't exist in export (they're deleted), we must
                // clear local events first to ensure deletions propagate correctly.
                await _haboModel.deleteAllEventsForHabit(localHabitId);
                for (final entry in remoteHabit.habitData.events.entries) {
                  final eventDate = entry.key;
                  final remoteEvent = entry.value;
                  await _haboModel.insertEvent(
                    localHabitId,
                    eventDate,
                    remoteEvent,
                    updateHabitTimestamp: false,
                  );
                  mergedEvents++;
                }
              }
              updatedHabits++;
            } else {
              // Local is newer - skip remote
              debugPrint(
                'MERGE:     -> LOCAL WINS '
                '(local ${localTimestamp.toIso8601String()} >= '
                'remote ${remoteTimestamp.toIso8601String()}) — skipping remote',
              );
              skippedHabits++;
            }
          }
        } catch (e) {
          debugPrint('Warning: Failed to merge habit: $e');
        }
      }

      debugPrint(
        'MERGE SUMMARY: $newHabits new, $updatedHabits updated (remote won), '
        '$skippedHabits skipped (local won), $mergedEvents events merged',
      );
      debugPrint('--- LWW MERGE END ---\n');
    } catch (e) {
      debugPrint('Error during LWW merge: $e');
      rethrow;
    }
  }
}
