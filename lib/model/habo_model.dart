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
  static const _dbVersion = 6;
  Database? _db;
  
  Database get db {
    if (_db == null) {
      throw StateError('Database has not been initialized. Call initDatabase() first.');
    }
    return _db!;
  }

  Future<void> deleteEvent(int id, DateTime dateTime) async {
    try {
      await db.delete('events',
          where: 'id = ? AND dateTime = ?',
          whereArgs: [id, dateTime.toString()]);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      await db.delete('habits', where: 'id = ?', whereArgs: [id]);
      await db.delete('events', where: 'id = ?', whereArgs: [id]);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> emptyTables() async {
    try {
      await db.delete('habits');
      await db.delete('events');
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> useBackup(List<Habit> habits) async {
    try {
      await emptyTables();
      for (var element in habits) {
        insertHabit(element);
        element.habitData.events.forEach(
          (key, value) {
            insertEvent(element.habitData.id!, key, value);
          },
        );
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> editHabit(Habit habit) async {
    try {
      await db.update(
        'habits',
        habit.toMap(),
        where: 'id = ?',
        whereArgs: [habit.habitData.id],
      );
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<List<Habit>> getAllHabits() async {
    final List<Map<String, dynamic>> habits =
        await db.query('habits', orderBy: 'position');
    List<Habit> result = [];

    await Future.forEach(
      habits,
      (hab) async {
        int id = hab['id'];
        SplayTreeMap<DateTime, List> eventsMap = SplayTreeMap<DateTime, List>();
        final events = await db.query('events', where: 'id = $id');
        for (var event in events) {
          final dayType = DayType.values[event['dayType'] as int];
          final comment = event['comment'];
          final progressValue = event['progressValue'] as double?;
          
          // Handle progress data for numeric habits
          if (dayType == DayType.progress && progressValue != null) {
            eventsMap[DateTime.parse(event['dateTime'] as String)] = [
              dayType,
              comment,
              progressValue
            ];
          } else {
            eventsMap[DateTime.parse(event['dateTime'] as String)] = [
              dayType,
              comment
            ];
          }
        }
        
        // Load categories for this habit
        final categories = await getCategoriesForHabit(id);
        
        result.add(
          Habit(
            habitData: HabitData(
              id: id,
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
            ),
          ),
        );
      },
    );
    return result;
  }

  void _updateTableEventsV1toV2(Batch batch) {
    batch.execute('ALTER TABLE Events ADD comment TEXT DEFAULT ""');
  }

  void _updateTableHabitsV2toV3(Batch batch) {
    batch.execute('ALTER TABLE habits ADD sanction TEXT DEFAULT "" NOT NULL');
    batch.execute(
        'ALTER TABLE habits ADD showSanction INTEGER DEFAULT 0 NOT NULL');
    batch.execute('ALTER TABLE habits ADD accountant TEXT DEFAULT "" NOT NULL');
  }

  void _updateTableHabitsV3toV4(Batch batch) {
    batch.execute('ALTER TABLE habits ADD habitType INTEGER DEFAULT 0 NOT NULL');
    batch.execute('ALTER TABLE habits ADD targetValue REAL DEFAULT 1.0 NOT NULL');
    batch.execute('ALTER TABLE habits ADD partialValue REAL DEFAULT 1.0 NOT NULL');
    batch.execute('ALTER TABLE habits ADD unit TEXT DEFAULT "" NOT NULL');
  }

  void _updateTableEventsV3toV4(Batch batch) {
    batch.execute('ALTER TABLE events ADD progressValue REAL DEFAULT 0.0');
  }

  // void _createTableEventsV3(Batch batch) {
  //   batch.execute('DROP TABLE IF EXISTS events');
  //   batch.execute('''CREATE TABLE events (
  //   id INTEGER,
  //   dateTime TEXT,
  //   dayType INTEGER,
  //   comment TEXT,
  //   PRIMARY KEY(id, dateTime),
  //   FOREIGN KEY (id) REFERENCES habits(id) ON DELETE CASCADE
  //   )''');
  // }

  void _createTableEventsV4(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS events');
    batch.execute('''CREATE TABLE events (
    id INTEGER,
    dateTime TEXT,
    dayType INTEGER,
    comment TEXT,
    progressValue REAL DEFAULT 0.0,
    PRIMARY KEY(id, dateTime),
    FOREIGN KEY (id) REFERENCES habits(id) ON DELETE CASCADE
    )''');
  }

  // void _createTableHabitsV3(Batch batch) {
  //   batch.execute('DROP TABLE IF EXISTS habits');
  //   batch.execute('''CREATE TABLE habits (
  //   id INTEGER PRIMARY KEY AUTOINCREMENT,
  //   position INTEGER,
  //   title TEXT,
  //   twoDayRule INTEGER,
  //   cue TEXT,
  //   routine TEXT,
  //   reward TEXT,
  //   showReward INTEGER,
  //   advanced INTEGER,
  //   notification INTEGER,
  //   notTime TEXT,
  //   sanction TEXT,
  //   showSanction INTEGER,
  //   accountant TEXT
  //   )''');
  // }


  void _createTableHabitsV6(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS habits');
    batch.execute('''CREATE TABLE habits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
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
    archived INTEGER DEFAULT 0
    )''');
  }

  void _updateTableHabitsV5toV6(Batch batch) {
    batch.execute('ALTER TABLE habits ADD COLUMN archived INTEGER DEFAULT 0');
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

  Future<void> initDatabase() async {
    final databasesPath = Platform.isLinux
        ? (await getApplicationSupportDirectory()).path
        : await getDatabasesPath();

    if (kDebugMode) {
      print(databasesPath);
    }

    final databaseFilePath = join(databasesPath, 'habo_db0.db');

    if (Platform.isLinux) {
      ffi.sqfliteFfiInit();
      _db = await ffi.databaseFactoryFfi.openDatabase(databaseFilePath,
          options: OpenDatabaseOptions(
            version: _dbVersion,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
          ));
    } else {
      _db = await openDatabase(
        databaseFilePath,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    }
  }

  void _onCreate(db, version) {
    var batch = db.batch();
    _createTableHabitsV6(batch);
    _createTableEventsV4(batch);
    _createTableCategoriesV5(batch);
    _createTableHabitCategoriesV5(batch);
    batch.commit();
  }

  void _onUpgrade(db, oldVersion, newVersion) {
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
    batch.commit();
  }

  Future<void> insertEvent(int id, DateTime date, List event) async {
    try {
      final eventData = {
        'id': id,
        'dateTime': date.toString(),
        'dayType': event[0].index,
        'comment': event[1],
      };
      
      // Add progress value for numeric habits
      if (event.length > 2 && event[0] == DayType.progress) {
        eventData['progressValue'] = event[2] as double;
      } else {
        eventData['progressValue'] = 0.0;
      }
      
      db.insert('events', eventData, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<int> insertHabit(Habit habit) async {
    try {
      var id = await db.insert('habits', habit.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
    return 0;
  }

  Future<void> updateOrder(List<Habit> habits) async {
    try {
      for (var habit in habits) {
        db.update(
          'habits',
          habit.toMap(),
          where: 'id = ?',
          whereArgs: [habit.habitData.id],
        );
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  // Category management methods
  Future<int> insertCategory(habo_category.Category category) async {
    try {
      var id = await db.insert('categories', category.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
    return 0;
  }

  Future<void> updateCategory(habo_category.Category category) async {
    try {
      await db.update(
        'categories',
        category.toMap(),
        where: 'id = ?',
        whereArgs: [category.id],
      );
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      // Delete category-habit associations first
      await db.delete('habit_categories', where: 'category_id = ?', whereArgs: [id]);
      // Then delete the category itself
      await db.delete('categories', where: 'id = ?', whereArgs: [id]);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<List<habo_category.Category>> getAllCategories() async {
    try {
      final List<Map<String, dynamic>> categories = await db.query('categories', orderBy: 'title');
      return categories.map((cat) => habo_category.Category.fromMap(cat)).toList();
    } catch (_) {
      if (kDebugMode) {
        print(_);
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
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> removeHabitFromCategory(int habitId, int categoryId) async {
    try {
      await db.delete('habit_categories',
          where: 'habit_id = ? AND category_id = ?',
          whereArgs: [habitId, categoryId]);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<List<habo_category.Category>> getCategoriesForHabit(int habitId) async {
    try {
      final List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT c.* FROM categories c
        INNER JOIN habit_categories hc ON c.id = hc.category_id
        WHERE hc.habit_id = ?
        ORDER BY c.title
      ''', [habitId]);
      return result.map((cat) => habo_category.Category.fromMap(cat)).toList();
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
    return [];
  }

  Future<void> updateHabitCategories(int habitId, List<habo_category.Category> categories) async {
    try {
      // Remove all existing category associations for this habit
      await db.delete('habit_categories', where: 'habit_id = ?', whereArgs: [habitId]);
      
      // Add new category associations
      for (var category in categories) {
        if (category.id != null) {
          await addHabitToCategory(habitId, category.id!);
        }
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }
}
