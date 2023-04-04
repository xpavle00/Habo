import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/model/settings_data.dart';
import 'package:habo/notifications.dart';
import 'package:habo/themes.dart';
import 'package:just_audio/just_audio.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SettingsData _settingsData = SettingsData();
  bool _isInitialized = false;

  final _checkPlayer = AudioPlayer();
  final _clickPlayer = AudioPlayer();

  void initialize() async {
    await loadData();
    _isInitialized = true;
    notifyListeners();
    _checkPlayer.setAsset('assets/sounds/check.wav');
    _clickPlayer.setAsset('assets/sounds/click.wav');
  }

  @override
  void dispose() {
    _checkPlayer.dispose();
    _clickPlayer.dispose();
    super.dispose();
  }

  resetAppNotification() {
    if (_settingsData.showDailyNot) {
      resetAppNotificationIfMissing(_settingsData.dailyNotTime);
    }
  }

  playCheckSound() {
    if (_settingsData.soundEffects) {
      _checkPlayer.setClip(
          start: const Duration(seconds: 0), end: const Duration(seconds: 2));
      _checkPlayer.play();
    }
  }

  playClickSound() {
    if (_settingsData.soundEffects) {
      _clickPlayer.setClip(
          start: const Duration(seconds: 0), end: const Duration(seconds: 2));
      _clickPlayer.play();
    }
  }

  void saveData() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('habo_settings', jsonEncode(_settingsData));
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await _prefs;
    String? json = prefs.getString('habo_settings');
    if (json != null) {
      _settingsData = SettingsData.fromJson(jsonDecode(json));
    }
  }

  ThemeData get getDark {
    if (_settingsData.theme != Themes.light) {
      return HaboTheme.darkTheme;
    } else {
      return HaboTheme.lightTheme;
    }
  }

  ThemeData get getLight {
    if (_settingsData.theme != Themes.dark) {
      return HaboTheme.lightTheme;
    } else {
      return HaboTheme.darkTheme;
    }
  }

  String get getThemeString {
    return _settingsData.themeList[_settingsData.theme.index];
  }

  List<String> get getThemeList {
    return _settingsData.themeList;
  }

  String get getWeekStart {
    return _settingsData.weekStartList[_settingsData.weekStart.index];
  }

  StartingDayOfWeek get getWeekStartEnum {
    return _settingsData.weekStart;
  }

  List<String> get getWeekStartList {
    return _settingsData.weekStartList;
  }

  TimeOfDay get getDailyNot {
    return _settingsData.dailyNotTime;
  }

  bool get getShowDailyNot {
    return _settingsData.showDailyNot;
  }

  bool get getSoundEffects {
    return _settingsData.soundEffects;
  }

  bool get getShowMonthName {
    return _settingsData.showMonthName;
  }

  bool get getSeenOnboarding {
    return _settingsData.seenOnboarding;
  }

  Color get checkColor {
    return _settingsData.checkColor;
  }

  Color get failColor {
    return _settingsData.failColor;
  }

  Color get skipColor {
    return _settingsData.skipColor;
  }

  bool get isInitialized {
    return _isInitialized;
  }

  set setTheme(String value) {
    _settingsData.theme = Themes.values[_settingsData.themeList.indexOf(value)];
    saveData();
    notifyListeners();
  }

  set setWeekStart(String value) {
    _settingsData.weekStart =
        StartingDayOfWeek.values[_settingsData.weekStartList.indexOf(value)];
    saveData();
    notifyListeners();
  }

  set setDailyNot(TimeOfDay notTime) {
    _settingsData.dailyNotTime = notTime;
    setAppNotification(notTime);
    saveData();
    notifyListeners();
  }

  set setShowDailyNot(bool value) {
    _settingsData.showDailyNot = value;
    if (value) {
      setAppNotification(_settingsData.dailyNotTime);
    } else {
      disableAppNotification();
    }
    saveData();
    notifyListeners();
  }

  set setSoundEffects(bool value) {
    _settingsData.soundEffects = value;
    saveData();
    notifyListeners();
  }

  set setShowMonthName(bool value) {
    _settingsData.showMonthName = value;
    saveData();
    notifyListeners();
  }

  set setSeenOnboarding(bool value) {
    _settingsData.seenOnboarding = value;
    saveData();
    notifyListeners();
  }

  set checkColor(Color value) {
    _settingsData.checkColor = value;
    saveData();
    notifyListeners();
  }

  set failColor(Color value) {
    _settingsData.failColor = value;
    saveData();
    notifyListeners();
  }

  set skipColor(Color value) {
    _settingsData.skipColor = value;
    saveData();
    notifyListeners();
  }
}
