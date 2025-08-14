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
      final habits = await _haboModel.getAllHabits();
      final categories = await _haboModel.getAllCategories();
      
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
      for (final habit in habits) {
        try {
          // Use the habit's toJson method which includes events
          (data['habits'] as List).add(habit.toJson());
        } catch (e) {
          debugPrint('Warning: Failed to export habit ${habit.habitData.id}: $e');
        }
      }

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
            final habitCategories = await _haboModel.getCategoriesForHabit(habit.habitData.id!);
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
            debugPrint('Warning: Failed to export categories for habit ${habit.habitData.id}: $e');
          }
        }
      }

      // Update metadata with actual counts
      (data['metadata'] as Map<String, dynamic>)['total_associations'] = associationCount;

      debugPrint('Backup export completed: ${habits.length} habits, ${categories.length} categories, $associationCount associations');
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
        debugPrint('Importing backup from ${metadata['export_timestamp']} with ${metadata['total_habits']} habits and ${metadata['total_categories']} categories');
      }

      // Clear existing data
      debugPrint('Clearing existing data...');
      final habits = await _haboModel.getAllHabits();
      for (final habit in habits) {
        if (habit.habitData.id != null) {
          await _haboModel.deleteHabit(habit.habitData.id!);
        }
      }
      
      // Clear existing categories
      final categories = await _haboModel.getAllCategories();
      for (final category in categories) {
        if (category.id != null) {
          await _haboModel.deleteCategory(category.id!);
        }
      }

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
          
          // Create category without ID so database assigns new one
          final categoryToInsert = Category(
            title: category.title,
            iconCodePoint: category.iconCodePoint,
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
          
          // Insert habit and get the new ID
          final newHabitId = await _haboModel.insertHabit(habit);
          
          // Map old habit ID to new habit ID if old ID existed
          if (oldHabitId != null) {
            habitIdMapping[oldHabitId] = newHabitId;
          }
          
          // Insert events for this habit using the NEW habit ID
          if (habit.habitData.events.isNotEmpty) {
            for (final entry in habit.habitData.events.entries) {
              try {
                await _haboModel.insertEvent(newHabitId, entry.key, entry.value);
                importedEvents++;
              } catch (e) {
                debugPrint('Warning: Failed to import event for habit $newHabitId at ${entry.key}: $e');
              }
            }
          }
          
          importedHabits++;
        } catch (e) {
          debugPrint('Warning: Failed to import habit: $e');
        }
      }
      
      debugPrint('Imported $importedHabits habits and $importedEvents events');

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
              debugPrint('Warning: Skipping association - habit ID $oldHabitId -> $newHabitId, category ID $oldCategoryId -> $newCategoryId');
            }
          } catch (e) {
            debugPrint('Warning: Failed to import habit-category association: $e');
          }
        }
        
        debugPrint('Imported $importedAssociations habit-category associations');
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
        final habitCategories = await _haboModel.getCategoriesForHabit(habit.habitData.id!);
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
}
