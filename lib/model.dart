import 'dart:async';
import 'dart:collection';

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

  Future<void> editHabit(Habit habit) async {
    try {
      var id = await db.update(
        "habits",
        habit.toMap(),
        where: "id = ?",
        whereArgs: [habit.id],
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
              DayType.values[event["dayType"]]
            ];
          });
        }
        result.add(Habit(
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
        ));
      });
    });

    return result;
  }

  Future<void> initDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'habo_db0.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE habits(id INTEGER PRIMARY KEY AUTOINCREMENT, position INTEGER, title TEXT, twoDayRule INTEGER, cue TEXT, routine TEXT, reward TEXT, showReward INTEGER, advanced INTEGER, notification INTEGER, notTime TEXT);",
        );
        db.execute(
          "CREATE TABLE events(id INTEGER, dateTime TEXT, dayType INTEGER, PRIMARY KEY(id, dateTime));",
        );
      },
      version: 1,
    );
  }

  Future<void> inserEvent(int id, DateTime date, List event) async {
    try {
      db.insert("events",
          {"id": id, "dateTime": date.toString(), "dayType": event[0].index},
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
          whereArgs: [habit.id],
        );
        return id;
      });
    } catch (_) {
      print(_);
    }
  }
}
