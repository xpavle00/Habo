import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/helpers.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/category.dart' as habo_category;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

class HaboModel {
  static const _dbVersion = 10;
  Database? _db;

  Database get db {
    if (_db == null) {
      throw StateError(
        'Database has not been initialized. Call initDatabase() first.',
      );
    }
    return _db!;
  }

  Future<void> deleteEvent(int id, DateTime dateTime) async {
    try {
      await db.delete(
        'events',
        where: 'id = ? AND dateTime = ?',
        whereArgs: [id, dateTime.toString()],
      );

      // Update the habit's updated_at so LWW recognizes the event deletion
      await db.update(
        'habits',
        {'updated_at': DateTime.now().toUtc().toIso8601String()},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  /// Deletes all events for a specific habit.
  /// Used during sync when remote habit wins and needs to replace all local events.
  Future<void> deleteAllEventsForHabit(int habitId) async {
    try {
      await db.delete('events', where: 'id = ?', whereArgs: [habitId]);
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      // Soft delete: set deleted_at and updated_at for LWW sync
      final now = DateTime.now().toUtc().toIso8601String();
      await db.update(
        'habits',
        {'deleted_at': now, 'updated_at': now},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  /// Soft-delete with a specific timestamp (used during backup import/sync
  /// to preserve the original deletion time for correct LWW resolution).
  Future<void> softDeleteHabitAt(int id, DateTime deletedAt) async {
    try {
      final ts = deletedAt.toIso8601String();
      await db.update(
        'habits',
        {'deleted_at': ts, 'updated_at': ts},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  // Actually delete the habit row (Hard Delete)
  Future<void> hardDeleteHabit(int id) async {
    try {
      await db.transaction((txn) async {
        await txn.delete('habits', where: 'id = ?', whereArgs: [id]);
        await txn.delete('events', where: 'id = ?', whereArgs: [id]);
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  /// Clears all data from database tables (hard delete).
  /// Used for backup import to ensure complete replacement.
  Future<void> emptyTables() async {
    try {
      await db.delete('habits');
      await db.delete('events');
      await db.delete('categories');
      await db.delete('habit_categories');
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> useBackup(List<Habit> habits) async {
    try {
      await emptyTables();
      for (var element in habits) {
        await insertHabit(element);
        for (var entry in element.habitData.events.entries) {
          await insertEvent(element.habitData.id!, entry.key, entry.value);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  /// Updates a habit in the database.
  ///
  /// [preserveTimestamp] - When true, keeps the habit's existing updatedAt timestamp.
  /// This is critical for sync operations where we're applying remote changes and
  /// must preserve the original timestamp to maintain correct LWW conflict resolution.
  Future<void> editHabit(Habit habit, {bool preserveTimestamp = false}) async {
    try {
      final habitMap = habit.toMap();
      if (preserveTimestamp) {
        habitMap['updated_at'] = habit.habitData.updatedAt.toIso8601String();
      } else {
        habitMap['updated_at'] = DateTime.now().toUtc().toIso8601String();
      }
      await db.update(
        'habits',
        habitMap,
        where: 'id = ?',
        whereArgs: [habit.habitData.id],
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<List<Habit>> getAllHabits({bool includeDeleted = false}) async {
    final String whereClause = includeDeleted ? '' : 'WHERE deleted_at IS NULL';
    final List<Map<String, dynamic>> habits = await db.rawQuery(
      'SELECT * FROM habits $whereClause ORDER BY position',
    );
    List<Habit> result = [];

    await Future.forEach(habits, (hab) async {
      int id = hab['id'];
      SplayTreeMap<DateTime, List> eventsMap = SplayTreeMap<DateTime, List>();
      final events = await db.query('events', where: 'id = ?', whereArgs: [id]);
      for (var event in events) {
        final dayType = DayType.values[event['dayType'] as int];
        final comment = event['comment'];
        final progressValue = event['progressValue'] as double?;
        final targetValue = event['targetValue'] as double?;

        // Handle numeric habits with progress and target values
        if ((dayType == DayType.progress || dayType == DayType.check) &&
            progressValue != null &&
            targetValue != null &&
            targetValue > 0) {
          eventsMap[DateTime.parse(event['dateTime'] as String)] = [
            dayType,
            comment,
            progressValue,
            targetValue,
          ];
        } else if (dayType == DayType.progress && progressValue != null) {
          eventsMap[DateTime.parse(event['dateTime'] as String)] = [
            dayType,
            comment,
            progressValue,
          ];
        } else {
          eventsMap[DateTime.parse(event['dateTime'] as String)] = [
            dayType,
            comment,
          ];
        }
      }

      // Load categories for this habit
      final categories = await getCategoriesForHabit(id);

      // Handle legacy habits without uuid - generate and save one
      String? habitUuid = hab['uuid'] as String?;
      if (habitUuid == null || habitUuid.isEmpty) {
        // Will be auto-generated by HabitData constructor
        habitUuid = null;
      }

      final habitData = HabitData(
        id: id,
        uuid: habitUuid,
        position: hab['position'],
        title: hab['title'],
        twoDayRule: hab['twoDayRule'] == 0 ? false : true,
        cue: hab['cue'] ?? '',
        routine: hab['routine'] ?? '',
        reward: hab['reward'] ?? '',
        showReward: hab['showReward'] == 0 ? false : true,
        advanced: hab['advanced'] == 0 ? false : true,
        notification: hab['notification'] == 0 ? false : true,
        notTime: parseTimeOfDay(hab['notTime']),
        events: eventsMap,
        sanction: hab['sanction'] ?? '',
        showSanction: (hab['showSanction'] ?? 0) == 0 ? false : true,
        accountant: hab['accountant'] ?? '',
        habitType: HabitType.values[hab['habitType'] ?? 0],
        targetValue: (hab['targetValue'] ?? 1.0).toDouble(),
        partialValue: (hab['partialValue'] ?? 1.0).toDouble(),
        unit: hab['unit'] ?? '',
        categories: categories,
        archived: hab['archived'] == 0 ? false : true,
        deletedAt: hab['deleted_at'] != null
            ? DateTime.parse(hab['deleted_at'] as String)
            : null,
        updatedAt: hab['updated_at'] != null
            ? DateTime.parse(hab['updated_at'] as String)
            : null,
      );

      // Backfill uuid if it was null in DB
      final dbUuid = hab['uuid'];
      if (dbUuid == null || (dbUuid as String).isEmpty) {
        await db.update(
          'habits',
          {'uuid': habitData.uuid},
          where: 'id = ?',
          whereArgs: [id],
        );
      }

      result.add(Habit(habitData: habitData));
    });
    return result;
  }

  void _updateTableEventsV1toV2(Batch batch) {
    batch.execute('ALTER TABLE Events ADD comment TEXT DEFAULT ""');
  }

  void _updateTableHabitsV2toV3(Batch batch) {
    batch.execute('ALTER TABLE habits ADD sanction TEXT DEFAULT "" NOT NULL');
    batch.execute(
      'ALTER TABLE habits ADD showSanction INTEGER DEFAULT 0 NOT NULL',
    );
    batch.execute('ALTER TABLE habits ADD accountant TEXT DEFAULT "" NOT NULL');
  }

  void _updateTableHabitsV3toV4(Batch batch) {
    batch.execute(
      'ALTER TABLE habits ADD habitType INTEGER DEFAULT 0 NOT NULL',
    );
    batch.execute(
      'ALTER TABLE habits ADD targetValue REAL DEFAULT 1.0 NOT NULL',
    );
    batch.execute(
      'ALTER TABLE habits ADD partialValue REAL DEFAULT 1.0 NOT NULL',
    );
    batch.execute('ALTER TABLE habits ADD unit TEXT DEFAULT "" NOT NULL');
  }

  void _updateTableEventsV3toV4(Batch batch) {
    batch.execute('ALTER TABLE events ADD progressValue REAL DEFAULT 0.0');
  }

  void _createTableHabitsV10(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS habits');
    batch.execute('''CREATE TABLE habits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT,
    position INTEGER,
    title TEXT,
    twoDayRule INTEGER,
    cue TEXT,
    routine TEXT,
    reward TEXT,
    showReward INTEGER,
    advanced INTEGER,
    notification INTEGER,
    notTime TEXT,
    sanction TEXT,
    showSanction INTEGER,
    accountant TEXT,
    habitType INTEGER DEFAULT 0,
    targetValue REAL DEFAULT 1.0,
    partialValue REAL DEFAULT 1.0,
    unit TEXT DEFAULT '',
    archived INTEGER DEFAULT 0,
    updated_at TEXT,
    deleted_at TEXT
    )''');
  }

  void _createTableEventsV10(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS events');
    batch.execute('''CREATE TABLE events (
    id INTEGER,
    dateTime TEXT,
    dayType INTEGER,
    comment TEXT,
    progressValue REAL DEFAULT 0.0,
    targetValue REAL DEFAULT 0.0,
    updated_at TEXT,
    PRIMARY KEY(id, dateTime),
    FOREIGN KEY (id) REFERENCES habits(id) ON DELETE CASCADE
    )''');
  }

  void _createTableCategoriesV10(Batch batch) {
    batch.execute('''CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT,
    title TEXT NOT NULL,
    iconCodePoint INTEGER NOT NULL,
    fontFamily TEXT,
    updated_at TEXT,
    deleted_at TEXT
    )''');
  }

  Future<void> _updateTablesToV10(Database db) async {
    // Add all sync-related columns (uuid, updated_at, deleted_at)
    // Check each column before adding to handle partial migrations

    // Habits table
    var habitsInfo = await db.rawQuery("PRAGMA table_info(habits)");
    if (!habitsInfo.any((col) => col['name'] == 'uuid')) {
      await db.execute('ALTER TABLE habits ADD COLUMN uuid TEXT');
    }
    if (!habitsInfo.any((col) => col['name'] == 'updated_at')) {
      await db.execute('ALTER TABLE habits ADD COLUMN updated_at TEXT');
    }
    if (!habitsInfo.any((col) => col['name'] == 'deleted_at')) {
      await db.execute('ALTER TABLE habits ADD COLUMN deleted_at TEXT');
    }

    // Events table
    var eventsInfo = await db.rawQuery("PRAGMA table_info(events)");
    if (!eventsInfo.any((col) => col['name'] == 'targetValue')) {
      await db.execute(
        'ALTER TABLE events ADD COLUMN targetValue REAL DEFAULT 0.0',
      );
    }
    if (!eventsInfo.any((col) => col['name'] == 'updated_at')) {
      await db.execute('ALTER TABLE events ADD COLUMN updated_at TEXT');
    }

    // Categories table
    var categoriesInfo = await db.rawQuery("PRAGMA table_info(categories)");
    if (!categoriesInfo.any((col) => col['name'] == 'uuid')) {
      await db.execute('ALTER TABLE categories ADD COLUMN uuid TEXT');
    }
    if (!categoriesInfo.any((col) => col['name'] == 'updated_at')) {
      await db.execute('ALTER TABLE categories ADD COLUMN updated_at TEXT');
    }
    if (!categoriesInfo.any((col) => col['name'] == 'deleted_at')) {
      await db.execute('ALTER TABLE categories ADD COLUMN deleted_at TEXT');
    }
  }

  void _updateTableHabitsV5toV6(Batch batch) {
    batch.execute('ALTER TABLE habits ADD COLUMN archived INTEGER DEFAULT 0');
  }

  Future<void> _updateTableCategoriesAddFontFamily(Database db) async {
    // Check if fontFamily column already exists before adding it
    final result = await db.rawQuery("PRAGMA table_info(categories)");
    final hasColumn = result.any((column) => column['name'] == 'fontFamily');

    if (!hasColumn) {
      await db.execute('ALTER TABLE categories ADD COLUMN fontFamily TEXT');
    }
  }

  void _createTableCategoriesV5(Batch batch) {
    batch.execute('''CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    iconCodePoint INTEGER NOT NULL
    )''');
  }

  void _createTableHabitCategoriesV5(Batch batch) {
    batch.execute('''CREATE TABLE IF NOT EXISTS habit_categories (
    habit_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (habit_id, category_id),
    FOREIGN KEY (habit_id) REFERENCES habits(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
    )''');
  }

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> initDatabase({String? testPath}) async {
    final databasesPath = Platform.isLinux
        ? (await getApplicationSupportDirectory()).path
        : await getDatabasesPath();

    if (kDebugMode) {
      print(databasesPath);
    }

    final databaseFilePath = testPath ?? join(databasesPath, 'habo_db0.db');

    if (Platform.isLinux) {
      ffi.sqfliteFfiInit();
      _db = await ffi.databaseFactoryFfi.openDatabase(
        databaseFilePath,
        options: OpenDatabaseOptions(
          version: _dbVersion,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
        ),
      );
    } else {
      _db = await openDatabase(
        databaseFilePath,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    }

    // Safety net: ensure sync columns exist even if a previous migration
    // failed after the DB version was already bumped to 9.
    // All checks are PRAGMA-guarded so this is safe to run every time.
    await _updateTablesToV10(db);
  }

  void _onCreate(Database db, int version) {
    var batch = db.batch();
    _createTableHabitsV10(batch);
    _createTableEventsV10(batch);
    _createTableCategoriesV10(batch);
    _createTableHabitCategoriesV5(batch);
    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();
    if (oldVersion == 1) {
      _updateTableEventsV1toV2(batch);
      _updateTableHabitsV2toV3(batch);
      _updateTableHabitsV3toV4(batch);
      _updateTableEventsV3toV4(batch);
      _createTableCategoriesV5(batch);
      _createTableHabitCategoriesV5(batch);
      _updateTableHabitsV5toV6(batch);
    }
    if (oldVersion == 2) {
      _updateTableHabitsV2toV3(batch);
      _updateTableHabitsV3toV4(batch);
      _updateTableEventsV3toV4(batch);
      _createTableCategoriesV5(batch);
      _createTableHabitCategoriesV5(batch);
      _updateTableHabitsV5toV6(batch);
    }
    if (oldVersion == 3) {
      _updateTableHabitsV3toV4(batch);
      _updateTableEventsV3toV4(batch);
      _createTableCategoriesV5(batch);
      _createTableHabitCategoriesV5(batch);
      _updateTableHabitsV5toV6(batch);
    }
    if (oldVersion == 4) {
      _createTableCategoriesV5(batch);
      _createTableHabitCategoriesV5(batch);
      _updateTableHabitsV5toV6(batch);
    }
    if (oldVersion == 5) {
      _updateTableHabitsV5toV6(batch);
    }

    // Commit batch operations first
    await batch.commit();

    // Then handle fontFamily column addition separately (requires async check)
    if (oldVersion <= 7) {
      await _updateTableCategoriesAddFontFamily(db);
    }

    // V10: Add sync columns (uuid, updated_at, deleted_at)
    if (oldVersion <= 9) {
      await _updateTablesToV10(db);
    }
  }

  Future<void> insertEvent(
    int id,
    DateTime date,
    List event, {
    bool updateHabitTimestamp = true,
  }) async {
    try {
      final eventData = {
        'id': id,
        'dateTime': date.toString(),
        'dayType': event[0].index,
        'comment': event[1],
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      // Add progress value for numeric habits
      if (event.length > 2 &&
          (event[0] == DayType.progress || event[0] == DayType.check)) {
        eventData['progressValue'] = event[2] as double;
      } else {
        eventData['progressValue'] = 0.0;
      }

      // Add target value for numeric habits (stored at index 3)
      if (event.length > 3) {
        eventData['targetValue'] = event[3] as double;
      } else {
        eventData['targetValue'] = 0.0;
      }

      await db.insert(
        'events',
        eventData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Also update the habit's updated_at so LWW recognizes the change
      if (updateHabitTimestamp) {
        await db.update(
          'habits',
          {'updated_at': DateTime.now().toUtc().toIso8601String()},
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<int> insertHabit(Habit habit, {bool preserveTimestamp = false}) async {
    try {
      final habitMap = habit.toMap();
      if (preserveTimestamp) {
        habitMap['updated_at'] = habit.habitData.updatedAt.toIso8601String();
      } else {
        habitMap['updated_at'] = DateTime.now().toUtc().toIso8601String();
      }
      var id = await db.insert(
        'habits',
        habitMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
    return 0;
  }

  Future<void> updateOrder(List<Habit> habits) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      for (var habit in habits) {
        final habitMap = habit.toMap();
        habitMap['updated_at'] =
            now; // Update timestamp so LWW recognizes reordering
        await db.update(
          'habits',
          habitMap,
          where: 'id = ?',
          whereArgs: [habit.habitData.id],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  // Category management methods
  Future<int> insertCategory(habo_category.Category category) async {
    try {
      final categoryMap = category.toMap();
      categoryMap['updated_at'] = DateTime.now().toUtc().toIso8601String();
      var id = await db.insert(
        'categories',
        categoryMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
    return 0;
  }

  Future<void> updateCategory(habo_category.Category category) async {
    try {
      final categoryMap = category.toMap();
      categoryMap['updated_at'] = DateTime.now().toUtc().toIso8601String();
      await db.update(
        'categories',
        categoryMap,
        where: 'id = ?',
        whereArgs: [category.id],
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  /// Soft-delete a category (set deleted_at timestamp).
  /// Removes habit-category associations since the category is effectively gone.
  Future<void> deleteCategory(int id) async {
    try {
      final now = DateTime.now().toUtc().toIso8601String();
      await db.transaction((txn) async {
        // Remove habit-category associations
        await txn.delete(
          'habit_categories',
          where: 'category_id = ?',
          whereArgs: [id],
        );
        // Soft delete: set deleted_at and updated_at
        await txn.update(
          'categories',
          {'deleted_at': now, 'updated_at': now},
          where: 'id = ?',
          whereArgs: [id],
        );
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  /// Hard-delete a category row entirely.
  Future<void> hardDeleteCategory(int id) async {
    try {
      await db.transaction((txn) async {
        await txn.delete(
          'habit_categories',
          where: 'category_id = ?',
          whereArgs: [id],
        );
        await txn.delete('categories', where: 'id = ?', whereArgs: [id]);
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<List<habo_category.Category>> getAllCategories({
    bool includeDeleted = false,
  }) async {
    try {
      final String whereClause = includeDeleted ? '' : 'deleted_at IS NULL';
      final List<Map<String, dynamic>> categories = await db.query(
        'categories',
        where: whereClause.isNotEmpty ? whereClause : null,
        orderBy: 'title',
      );
      final result = <habo_category.Category>[];
      for (final cat in categories) {
        final category = habo_category.Category.fromMap(cat);

        // Backfill uuid if it was null in DB (legacy categories)
        final dbUuid = cat['uuid'];
        if (dbUuid == null || (dbUuid as String).isEmpty) {
          await db.update(
            'categories',
            {'uuid': category.uuid},
            where: 'id = ?',
            whereArgs: [category.id],
          );
        }

        result.add(category);
      }
      return result;
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
    return [];
  }

  // Habit-Category relationship methods
  Future<void> addHabitToCategory(int habitId, int categoryId) async {
    try {
      await db.insert('habit_categories', {
        'habit_id': habitId,
        'category_id': categoryId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> removeHabitFromCategory(int habitId, int categoryId) async {
    try {
      await db.delete(
        'habit_categories',
        where: 'habit_id = ? AND category_id = ?',
        whereArgs: [habitId, categoryId],
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<List<habo_category.Category>> getCategoriesForHabit(
    int habitId,
  ) async {
    try {
      final List<Map<String, dynamic>> result = await db.rawQuery(
        '''
        SELECT c.* FROM categories c
        INNER JOIN habit_categories hc ON c.id = hc.category_id
        WHERE hc.habit_id = ? AND c.deleted_at IS NULL
        ORDER BY c.title
      ''',
        [habitId],
      );
      return result.map((cat) => habo_category.Category.fromMap(cat)).toList();
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
    return [];
  }

  Future<void> updateHabitCategories(
    int habitId,
    List<habo_category.Category> categories,
  ) async {
    try {
      // Remove all existing category associations for this habit
      await db.delete(
        'habit_categories',
        where: 'habit_id = ?',
        whereArgs: [habitId],
      );

      // Add new category associations
      for (var category in categories) {
        if (category.id != null) {
          await addHabitToCategory(habitId, category.id!);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }
}
