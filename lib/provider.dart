import 'dart:collection';
import 'dart:convert';

import 'package:Habo/habit_data.dart';
import 'package:Habo/model.dart';
import 'package:Habo/notification_center.dart';
import 'package:Habo/settings_data.dart';
import 'package:Habo/statistics.dart';
import 'package:Habo/widgets/habit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Bloc with ChangeNotifier {
  final HaboModel _haboModel = HaboModel();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SettingsData settingsData = new SettingsData();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      new GlobalKey<ScaffoldMessengerState>();
  final NotificationCenter _notificationCenter = new NotificationCenter();
  final _checkPlayer = AudioPlayer();
  final _clickPlayer = AudioPlayer();

  String actualTheme = 'Default';
  List<Habit> allHabits;
  Habit deletedHabit;
  bool dataLoaded = false;
  Queue<Habit> toDelete = new Queue();
  PackageInfo packageInfo;

  Bloc() {
    initSettings();
    initModel();
    initPackageInfo();
    _checkPlayer.setAsset('assets/sounds/check.wav');
    _clickPlayer.setAsset('assets/sounds/click.wav');
  }

  Future<AllStatistics> getFutureStatsData() async {
    return await Statistics.calculateStatistics(allHabits);
  }

  playCheckSound() {
    if (settingsData.getSoundEffects) {
      _checkPlayer.setClip(
          start: Duration(seconds: 0), end: Duration(seconds: 2));
      _checkPlayer.play();
    }
  }

  playClickSound() {
    if (settingsData.getSoundEffects) {
      _clickPlayer.setClip(
          start: Duration(seconds: 0), end: Duration(seconds: 2));
      _clickPlayer.play();
    }
  }

  List<Habit> get getAllHabits {
    return allHabits;
  }

  TimeOfDay get getDailyNot {
    return settingsData.getDailyNot;
  }

  bool get getDataLoaded {
    return dataLoaded;
  }

  PackageInfo get getPackageInfo {
    return packageInfo;
  }

  GlobalKey<ScaffoldMessengerState> get getScaffoldKey {
    return _scaffoldKey;
  }

  SettingsData get getSettings {
    return settingsData;
  }

  bool get getShowDailyNot {
    return settingsData.getShowDailyNot;
  }

  bool get getSoundEffects {
    return settingsData.getSoundEffects;
  }

  String get getTheme {
    return settingsData.getTheme;
  }

  List<String> get getThemeList {
    return settingsData.getThemeList;
  }

  String get getWeekStart {
    return settingsData.getWeekStart;
  }

  StartingDayOfWeek get getWeekStartEnum {
    return settingsData.getWeekStartEnum;
  }

  List<String> get getWeekStartList {
    return settingsData.getWeekStartList;
  }

  set setDailyNot(TimeOfDay value) {
    settingsData.setDailyNot = value;
    _prefs.then((SharedPreferences prefs) {
      var st = settingsData.toJson().toString();
      prefs.remove('habo_settings');
      prefs.setString('habo_settings', st);
    });
    _notificationCenter.setNotification(settingsData.getDailyNot);
    notifyListeners();
  }

  set setShowDailyNot(bool value) {
    settingsData.setShowDailyNot = value;
    _prefs.then((SharedPreferences prefs) {
      var st = settingsData.toJson().toString();
      prefs.remove('habo_settings');
      prefs.setString('habo_settings', st);
    });
    if (value) {
      _notificationCenter.setNotification(settingsData.getDailyNot);
    } else {
      _notificationCenter.disableNotification(0);
    }
    notifyListeners();
  }

  set setSoundEffects(bool value) {
    settingsData.setSoundEffects = value;
    _prefs.then((SharedPreferences prefs) {
      var st = settingsData.toJson().toString();
      prefs.remove('habo_settings');
      prefs.setString('habo_settings', st);
    });
    notifyListeners();
  }

  set setTheme(String value) {
    settingsData.setTheme = value;
    _prefs.then((SharedPreferences prefs) {
      var st = settingsData.toJson().toString();
      prefs.remove('habo_settings');
      prefs.setString('habo_settings', st);
    });
    notifyListeners();
  }

  set setWeekStart(String value) {
    settingsData.setWeekStart = value;
    _prefs.then((SharedPreferences prefs) {
      var st = settingsData.toJson().toString();
      prefs.remove('habo_settings');
      prefs.setString('habo_settings', st);
    });
    notifyListeners();
  }

  addEvent(int id, DateTime dateTime, List event) {
    _haboModel.insertEvent(id, dateTime, event);
  }

  addHabit(
      String title,
      bool twoDayRule,
      String cue,
      String routine,
      String reward,
      bool showReward,
      bool advanced,
      bool notification,
      TimeOfDay notTime) {
    Habit newHabit = Habit(
      habitData: HabitData(
        position: allHabits.length,
        title: title,
        twoDayRule: twoDayRule,
        cue: cue,
        routine: routine,
        reward: reward,
        showReward: showReward,
        advanced: advanced,
        events: SplayTreeMap<DateTime, List>(),
        notification: notification,
        notTime: notTime,
      ),
    );
    _haboModel.insertHabit(newHabit).then((id) {
      newHabit.setId = id;
      allHabits.add(newHabit);
      if (notification)
        _notificationCenter.setHabitNotification(id, notTime, 'Habo', title);
      else
        _notificationCenter.disableNotification(id);
      notifyListeners();
    });
    updateOrder();
  }

  deleteEvent(int id, DateTime dateTime) {
    _haboModel.deleteEvent(id, dateTime);
  }

  Future<void> deleteFromDB() async {
    if (toDelete.isNotEmpty) {
      _notificationCenter.disableNotification(toDelete.first.habitData.id);
      _haboModel.deleteHabit(toDelete.first.habitData.id);
      toDelete.removeFirst();
    }
    if (toDelete.isNotEmpty) {
      Future.delayed(const Duration(seconds: 1), () => deleteFromDB());
    }
  }

  deleteHabit(int id) {
    deletedHabit = findHabitById(id);
    allHabits.remove(deletedHabit);
    toDelete.addLast(deletedHabit);
    Future.delayed(const Duration(seconds: 4), () => deleteFromDB());
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Habit deleted."),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            undoDeleteHabit(deletedHabit);
          },
        ),
      ),
    );
    updateOrder();
    notifyListeners();
  }

  editHabit(HabitData habitData) {
    var hab = findHabitById(habitData.id);
    hab.habitData.title = habitData.title;
    hab.habitData.twoDayRule = habitData.twoDayRule;
    hab.habitData.cue = habitData.cue;
    hab.habitData.routine = habitData.routine;
    hab.habitData.reward = habitData.reward;
    hab.habitData.showReward = habitData.showReward;
    hab.habitData.advanced = habitData.advanced;
    hab.habitData.notification = habitData.notification;
    hab.habitData.notTime = habitData.notTime;
    _haboModel.editHabit(hab);
    if (habitData.notification)
      _notificationCenter.setHabitNotification(
          habitData.id, habitData.notTime, 'Habo', habitData.title);
    else
      _notificationCenter.disableNotification(habitData.id);
    notifyListeners();
  }

  Habit findHabitById(int id) {
    Habit result;
    allHabits.forEach((hab) {
      if (hab.habitData.id == id) {
        result = hab;
      }
    });
    return result;
  }

  void hideSnackBar() {
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }

  initModel() async {
    await _haboModel.initDatabase();
    allHabits = await _haboModel.getAllHabits();
    dataLoaded = true;
    notifyListeners();
  }

  initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  initSettings() async {
    await _prefs.then((SharedPreferences prefs) {
      String savedSettings = (prefs.getString('habo_settings') ?? '');
      if (savedSettings != '') {
        var json = jsonDecode(savedSettings);
        settingsData = SettingsData.fromJson(json);
      }
    });
    _notificationCenter.initDailyNotification();
    if (settingsData.getShowDailyNot) {
      _notificationCenter.setNotification(settingsData.getDailyNot);
    }
    notifyListeners();
  }

  reorderList(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    Habit _x = allHabits.removeAt(oldIndex);
    allHabits.insert(newIndex, _x);
    updateOrder();
    _haboModel.updateOrder(allHabits);
    notifyListeners();
  }

  undoDeleteHabit(Habit del) {
    toDelete.remove(del);
    if (deletedHabit.habitData.position < allHabits.length) {
      allHabits.insert(deletedHabit.habitData.position, deletedHabit);
    } else {
      allHabits.add(deletedHabit);
    }
    updateOrder();
    notifyListeners();
  }

  updateOrder() {
    int iterator = 0;
    allHabits.forEach((habit) {
      habit.habitData.position = iterator++;
    });
  }

  updateTwoDayRule(int id, bool twoDayRule) {
    allHabits.forEach((h) {
      if (h.habitData.id == id) {
        h.habitData.twoDayRule = twoDayRule;
      }
    });
  }
}
