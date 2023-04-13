import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/helpers.dart';
import 'package:habo/model/habit_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HaboModel {
  late Database db;

  Future<void> deleteEvent(int id, DateTime dateTime) async {
    try {
      await db.delete("events",
          where: "id = ? AND dateTime = ?",
          whereArgs: [id, dateTime.toString()]);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      await db.delete("habits", where: "id = ?", whereArgs: [id]);
      await db.delete("events", where: "id = ?", whereArgs: [id]);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<void> emptyTables() async {
    try {
      await db.delete("habits");
      await db.delete("events");
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
        "habits",
        habit.toMap(),
        where: "id = ?",
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
        await db.query("habits", orderBy: "position");
    List<Habit> result = [];

    await Future.forEach(
      habits,
      (hab) async {
        int id = hab["id"];
        SplayTreeMap<DateTime, List> eventsMap = SplayTreeMap<DateTime, List>();
        await db.query("events", where: "id = $id").then(
          (events) {
            for (var event in events) {
              eventsMap[DateTime.parse(event["dateTime"] as String)] = [
                DayType.values[event["dayType"] as int],
                event["comment"]
              ];
            }
            result.add(
              Habit(
                habitData: HabitData(
                  id: id,
                  position: hab["position"],
                  title: hab["title"],
                  twoDayRule: hab["twoDayRule"] == 0 ? false : true,
                  cue: hab["cue"] ?? "",
                  routine: hab["routine"] ?? "",
                  reward: hab["reward"] ?? "",
                  showReward: hab["showReward"] == 0 ? false : true,
                  advanced: hab["advanced"] == 0 ? false : true,
                  notification: hab["notification"] == 0 ? false : true,
                  notTime: parseTimeOfDay(hab["notTime"]),
                  events: eventsMap,
                  sanction: hab["sanction"] ?? "",
                  showSanction: (hab["showSanction"] ?? 0) == 0 ? false : true,
                  accountant: hab["accountant"] ?? "",
                ),
              ),
            );
          },
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
    batch.execute('ALTER TABLE habits ADD showSanction INTEGER DEFAULT 0 NOT NULL');
    batch.execute('ALTER TABLE habits ADD accountant TEXT DEFAULT "" NOT NULL');
  }

  void _createTableEventsV3(Batch batch) {
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

  void _createTableHabitsV3(Batch batch) {
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
    accountant TEXT
    )''');
  }

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    if (kDebugMode) {
      print(databasesPath);
    }
    db = await openDatabase(
      join(await getDatabasesPath(), 'habo_db0.db'),
      version: 3,
      onCreate: (db, version) {
        var batch = db.batch();
        _createTableHabitsV3(batch);
        _createTableEventsV3(batch);
        batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) {
        var batch = db.batch();
        if (oldVersion == 1) {
          _updateTableEventsV1toV2(batch);
          _updateTableHabitsV2toV3(batch);
        }
        if (oldVersion == 2) {
          _updateTableHabitsV2toV3(batch);
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
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<int> insertHabit(Habit habit) async {
    try {
      var id = await db.insert("habits", habit.toMap(),
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
          "habits",
          habit.toMap(),
          where: "id = ?",
          whereArgs: [habit.habitData.id],
        );
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }
}
