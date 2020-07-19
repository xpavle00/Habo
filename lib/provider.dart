import 'dart:collection';
import 'dart:convert';

import 'package:Habo/model.dart';
import 'package:Habo/notification_center.dart';
import 'package:Habo/settings_data.dart';
import 'package:Habo/widgets/habit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Bloc with ChangeNotifier {
  final HaboModel _haboModel = HaboModel();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SettingsData settingsData = new SettingsData();
  final GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey<ScaffoldState>();
  final NotificationCetner _notificationCenter = new NotificationCetner();

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

  GlobalKey<ScaffoldState> get getScafoldKey {
    return _scafoldKey;
  }

  SettingsData get getSettings {
    return settingsData;
  }

  bool get getShowDailyNot {
    return settingsData.getShowDailyNot;
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
    _haboModel.inserEvent(id, dateTime, event);
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
      _notificationCenter.disableNotification(toDelete.first.id);
      _haboModel.deleteHabit(toDelete.first.id);
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
    _scafoldKey.currentState.hideCurrentSnackBar();
    _scafoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Habit deleted."),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            undoDeleteHabit(deletedHabit);
          },
        )));
    updateOrder();
    notifyListeners();
  }

  editHabit(
      int id,
      String title,
      bool twoDayRule,
      String cue,
      String routine,
      String reward,
      bool showReward,
      bool advanced,
      bool notification,
      TimeOfDay notTime) {
    var hab = findHabitById(id);
    hab.title = title;
    hab.twoDayRule = twoDayRule;
    hab.cue = cue;
    hab.routine = routine;
    hab.reward = reward;
    hab.showReward = showReward;
    hab.advanced = advanced;
    hab.notification = notification;
    hab.notTime = notTime;
    _haboModel.editHabit(hab);
    if (notification)
      _notificationCenter.setHabitNotification(id, notTime, 'Habo', title);
    else
      _notificationCenter.disableNotification(id);
    notifyListeners();
  }

  Habit findHabitById(int id) {
    Habit result;
    allHabits.forEach((hab) {
      if (hab.id == id) {
        result = hab;
      }
    });
    return result;
  }

  void hideSnackBar() {
    _scafoldKey.currentState.hideCurrentSnackBar();
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
    if (deletedHabit.position < allHabits.length) {
      allHabits.insert(deletedHabit.position, deletedHabit);
    } else {
      allHabits.add(deletedHabit);
    }
    updateOrder();
    notifyListeners();
  }

  updateOrder() {
    int iterator = 0;
    allHabits.forEach((habit) {
      habit.position = iterator++;
    });
  }

  updateTwoDayRule(int id, bool twoDayRule) {
    allHabits.forEach((h) {
      if (h.id == id) {
        h.twoDayRule = twoDayRule;
      }
    });
  }
}
