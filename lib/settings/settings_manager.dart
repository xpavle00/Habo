import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habo/constants.dart';
import 'package:habo/model/settings_data.dart';
import 'package:habo/notifications.dart';
import 'package:habo/themes.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SettingsData _settingsData = SettingsData();
  bool _isInitialized = false;
  String _currentAppVersion = '';

  late AudioSource _checkSource;
  late AudioSource _clickSource;
  bool _soundsLoaded = false;

  Future<void> initialize() async {
    await loadData();
    try {
      final info = await PackageInfo.fromPlatform();
      _currentAppVersion = info.version;
    } catch (_) {
      _currentAppVersion = '';
    }
    _isInitialized = true;
    notifyListeners();
    _initializeSounds();
  }

  Future<void> _initializeSounds() async {
    try {
      await SoLoud.instance.init();
      _checkSource = await SoLoud.instance.loadAsset('assets/sounds/check.wav');
      _clickSource = await SoLoud.instance.loadAsset('assets/sounds/click.wav');
      _soundsLoaded = true;
    } catch (e) {
      // Handle initialization error gracefully
      _soundsLoaded = false;
    }
  }

  @override
  void dispose() {
    if (_soundsLoaded) {
      SoLoud.instance.disposeSource(_checkSource);
      SoLoud.instance.disposeSource(_clickSource);
    }
    super.dispose();
  }

  void resetAppNotification() {
    if (_settingsData.showDailyNot) {
      resetAppNotificationIfMissing(_settingsData.dailyNotTime);
    }
  }

  void playCheckSound() {
    if (_settingsData.soundEffects &&
        _soundsLoaded &&
        _settingsData.soundVolume > 0) {
      try {
        final volume =
            _settingsData.soundVolume / 5.0; // Convert 0-5 to 0.0-1.0
        SoLoud.instance.play(_checkSource, volume: volume);
      } catch (e) {
        // Handle playback error gracefully
      } finally {
        HapticFeedback.lightImpact();
      }
    }
  }

  void playClickSound() {
    if (_settingsData.soundEffects &&
        _soundsLoaded &&
        _settingsData.soundVolume > 0) {
      try {
        final volume =
            _settingsData.soundVolume / 5.0; // Convert 0-5 to 0.0-1.0
        SoLoud.instance.play(_clickSource, volume: volume);
      } catch (e) {
        // Handle playback error gracefully
      } finally {
        HapticFeedback.lightImpact();
      }
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
    switch (_settingsData.theme) {
      case Themes.device:
        return HaboTheme.darkTheme;
      case Themes.light:
        return HaboTheme.lightTheme;
      case Themes.dark:
        return HaboTheme.darkTheme;
      case Themes.oled:
        return HaboTheme.oledTheme;
      case Themes.materialYou:
        return HaboTheme.darkTheme; //
      case Themes.dracula:
        return HaboTheme.draculaTheme;
      default:
        return HaboTheme.darkTheme;
    }
  }

  ThemeData get getLight {
    switch (_settingsData.theme) {
      case Themes.device:
        return HaboTheme.lightTheme;
      case Themes.light:
        return HaboTheme.lightTheme;
      case Themes.dark:
        return HaboTheme.darkTheme;
      case Themes.oled:
        return HaboTheme.oledTheme;
      case Themes.materialYou:
        return HaboTheme.lightTheme; // Fa
      case Themes.dracula:
        return HaboTheme.draculaTheme;
      default:
        return HaboTheme.lightTheme;
    }
  }

  Themes get getThemeString {
    return _settingsData.theme;
  }

  StartingDayOfWeek get getWeekStartEnum {
    return _settingsData.weekStart;
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

  double get getSoundVolume {
    return _settingsData.soundVolume;
  }

  bool get getShowMonthName {
    return _settingsData.showMonthName;
  }

  bool get getSeenOnboarding {
    return _settingsData.seenOnboarding;
  }

  bool get getShowCategories {
    return _settingsData.showCategories;
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

  Color get progressColor {
    return _settingsData.progressColor;
  }

  Color get iconColor {
    return _settingsData.iconColor;
  }

  bool get getBiometricLock {
    return _settingsData.biometricLock;
  }

  bool get isInitialized {
    return _isInitialized;
  }

  String get getLastWhatsNewVersion {
    return _settingsData.lastWhatsNewVersion;
  }

  set setLastWhatsNewVersion(String value) {
    _settingsData.lastWhatsNewVersion = value;
    saveData();
    notifyListeners();
  }

  String get getCurrentAppVersion {
    return _currentAppVersion;
  }

  set setTheme(Themes value) {
    _settingsData.theme = value;
    if (value == Themes.dracula) {
      _settingsData.checkColor = draculaGreen;
      _settingsData.failColor = draculaRed;
      _settingsData.skipColor = draculaYellow;
      _settingsData.progressColor = draculaCyan;
      _settingsData.iconColor = draculaSelection;
    } else {
      _settingsData.checkColor = HaboColors.primary;
      _settingsData.failColor = HaboColors.red;
      _settingsData.skipColor = HaboColors.skip;
      _settingsData.progressColor = HaboColors.progress;
      _settingsData.iconColor = Colors.white;
    }
    saveData();
    notifyListeners();
  }

  set setWeekStart(StartingDayOfWeek value) {
    _settingsData.weekStart = value;
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

  set setSoundVolume(double value) {
    _settingsData.soundVolume = value.clamp(0.0, 5.0);
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

  set setShowCategories(bool value) {
    _settingsData.showCategories = value;
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

  set progressColor(Color value) {
    _settingsData.progressColor = value;
    saveData();
    notifyListeners();
  }

  set setBiometricLock(bool value) {
    _settingsData.biometricLock = value;
    saveData();
    notifyListeners();
  }
}
