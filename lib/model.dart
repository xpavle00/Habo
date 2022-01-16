import 'dart:async';
import 'dart:collection';

import 'package:Habo/habit_data.dart';
import 'package:Habo/helpers.dart';
import 'package:Habo/widgets/habit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HaboModel {
  Database db;

  Future<void> deleteEvent(int id, DateTime dateTime) async {
    try {
      await db.delete("events",
          where: "id = ? AND dateTime = ?",
          whereArgs: [id, dateTime.toString()]);
    } catch (_) {
      print(_);
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      await db.delete("habits", where: "id = ?", whereArgs: [id]);
      await db.delete("events", where: "id = ?", whereArgs: [id]);
    } catch (_) {
      print(_);
    }
  }

  Future<void> emptyTables() async {
    try {
      await db.delete("habits");
      await db.delete("events");
    } catch (_) {
      print(_);
    }
  }

  Future<void> useBackup(List<Habit> habits) async {
    try {
      await emptyTables();
      habits.forEach((element) {
        insertHabit(element);
        element.habitData.events.forEach((key, value) {
          insertEvent(element.habitData.id, key, value);
        });
      });
    } catch (_) {
      print(_);
    }
  }

  Future<void> editHabit(Habit habit) async {
    try {
      var id = await db.update(
        "habits",
        habit.toMap(),
        where: "id = ?",
        whereArgs: [habit.habitData.id],
      );
      return id;
    } catch (_) {
      print(_);
    }
  }

  Future<List<Habit>> getAllHabits() async {
    final List<Map<String, dynamic>> habits =
        await db.query("habits", orderBy: "position");
    List<Habit> result = [];

    await Future.forEach(habits, (hab) async {
      int id = hab["id"];
      SplayTreeMap<DateTime, List> eventsMap = SplayTreeMap<DateTime, List>();
      await db.query("events", where: "id = $id").then((events) {
        if (events != null) {
          events.forEach((event) {
            eventsMap[DateTime.parse(event["dateTime"])] = [
              DayType.values[event["dayType"]],
              event["comment"]
            ];
          });
        }
        result.add(
          Habit(
            habitData: HabitData(
              id: id,
              position: hab["position"],
              title: hab["title"],
              twoDayRule: hab["twoDayRule"] == 0 ? false : true,
              cue: hab["cue"],
              routine: hab["routine"],
              reward: hab["reward"],
              showReward: hab["showReward"] == 0 ? false : true,
              advanced: hab["advanced"] == 0 ? false : true,
              notification: hab["notification"] == 0 ? false : true,
              notTime: parseTimeOfDay(hab["notTime"]),
              events: eventsMap,
            ),
          ),
        );
      });
    });

    return result;
  }

  void _updateTableEventsV1toV2(Batch batch) {
    batch.execute('ALTER TABLE Events ADD comment TEXT');
  }

  void _createTableEventsV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS events');
    batch.execute('''CREATE TABLE events (
    id INTEGER,
    dateTime TEXT,
    dayType INTEGER,
    comment TEXT,
    PRIMARY KEY(id, dateTime),
    FOREIGN KEY (id) REFERENCES habits(id) ON DELETE CASCADE
    )''');
  }

  void _createTableHabitsV2(Batch batch) {
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
    notTime TEXT
    )''');
  }

  /// Let's use FOREIGN KEY constraints
  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    print(databasesPath);
    db = await openDatabase(
      join(await getDatabasesPath(), 'habo_db0.db'),
      version: 2,
      // onConfigure: onConfigure,
      onCreate: (db, version) {
        var batch = db.batch();
        _createTableHabitsV2(batch);
        _createTableEventsV2(batch);
        batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) {
        var batch = db.batch();
        if (oldVersion == 1) {
          // We update existing table and create the new tables
          _updateTableEventsV1toV2(batch);
        }
        batch.commit();
      },
    );
  }

  Future<void> insertEvent(int id, DateTime date, List event) async {
    try {
      db.insert(
          "events",
          {
            "id": id,
            "dateTime": date.toString(),
            "dayType": event[0].index,
            "comment": event[1],
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<int> insertHabit(Habit habit) async {
    try {
      var id = await db.insert("habits", habit.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } catch (_) {
      print(_);
    }
    return 0;
  }

  Future<void> updateOrder(List<Habit> habits) async {
    try {
      habits.forEach((habit) {
        var id = db.update(
          "habits",
          habit.toMap(),
          where: "id = ?",
          whereArgs: [habit.habitData.id],
        );
        return id;
      });
    } catch (_) {
      print(_);
    }
  }
}
