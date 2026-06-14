import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habo/constants.dart';
import 'package:habo/model/settings_data.dart';
import 'package:habo/notifications.dart';
import 'package:habo/themes.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SettingsData _settingsData = SettingsData();
  bool _isInitialized = false;
  String _currentAppVersion = '';

  late AudioPlayer _checkPlayer;
  late AudioPlayer _clickPlayer;
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
    await _initializeSounds();
  }

  Future<void> _initializeSounds() async {
    try {
      // Mix with background audio but stay audible even when iOS silent mode is on.
      await AudioPlayer.global.setAudioContext(
        AudioContext(
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.playback,
            options: {AVAudioSessionOptions.mixWithOthers},
          ),
          android: AudioContextAndroid(
            isSpeakerphoneOn: false,
            stayAwake: false,
            contentType: AndroidContentType.sonification,
            usageType: AndroidUsageType.assistanceSonification,
            audioFocus: AndroidAudioFocus.none,
          ),
        ),
      );
      _checkPlayer = await _createEffectPlayer('sounds/check.wav');
      _clickPlayer = await _createEffectPlayer('sounds/click.wav');
      _soundsLoaded = true;
    } catch (e) {
      // Handle initialization error gracefully
      _soundsLoaded = false;
    }
  }

  /// Creates a low-latency player with [assetPath] preloaded, so the first tap
  /// plays without a decode delay. [ReleaseMode.stop] keeps the decoded buffer
  /// between plays — the default [ReleaseMode.release] re-buffers every tap.
  Future<AudioPlayer> _createEffectPlayer(String assetPath) async {
    final player = AudioPlayer();
    await player.setReleaseMode(ReleaseMode.stop);
    await player.setPlayerMode(PlayerMode.lowLatency);
    await player.setSource(AssetSource(assetPath));
    return player;
  }

  @override
  void dispose() {
    if (_soundsLoaded) {
      _checkPlayer.dispose();
      _clickPlayer.dispose();
    }
    super.dispose();
  }

  void resetAppNotification() {
    if (_settingsData.showDailyNot) {
      resetAppNotificationIfMissing(_settingsData.dailyNotTime);
    }
  }

  Future<void> playCheckSound() async {
    if (_settingsData.soundEffects &&
        _soundsLoaded &&
        _settingsData.soundVolume > 0) {
      await _playEffect(_checkPlayer);
      HapticFeedback.lightImpact();
    }
  }

  Future<void> playClickSound() async {
    if (_settingsData.soundEffects &&
        _soundsLoaded &&
        _settingsData.soundVolume > 0) {
      await _playEffect(_clickPlayer);
      HapticFeedback.lightImpact();
    }
  }

  /// Replays a preloaded effect [player]. Volume is only pushed to the platform
  /// when it changes, and the player is stopped first because low-latency mode
  /// fires no completion events (so it never resets its own position).
  Future<void> _playEffect(AudioPlayer player) async {
    try {
      final volume = _settingsData.soundVolume / 5.0; // Convert 0-5 to 0.0-1.0
      if (player.volume != volume) {
        await player.setVolume(volume);
      }
      await player.stop();
      await player.resume();
    } catch (e) {
      // Handle playback error gracefully
    }
  }

  Future<void> saveData() async {
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

  bool get getOneTapCheck {
    return _settingsData.oneTapCheck;
  }

  set setOneTapCheck(bool value) {
    _settingsData.oneTapCheck = value;
    saveData();
    notifyListeners();
  }

  int get syncVersion => _settingsData.syncVersion;

  bool get hasUnsyncedChanges => _settingsData.hasUnsyncedChanges;

  Future<void> setSyncVersion(int version) async {
    _settingsData = _settingsData.copyWith(syncVersion: version);
    await saveData();
    notifyListeners();
  }

  Future<void> setHasUnsyncedChanges(bool hasChanges) async {
    if (_settingsData.hasUnsyncedChanges == hasChanges) return;
    _settingsData = _settingsData.copyWith(hasUnsyncedChanges: hasChanges);
    await saveData();
    notifyListeners();
  }

  bool get isSyncPaused => _settingsData.isSyncPaused;

  Future<void> setIsSyncPaused(bool isPaused) async {
    if (_settingsData.isSyncPaused == isPaused) return;
    _settingsData = _settingsData.copyWith(isSyncPaused: isPaused);
    await saveData();
    notifyListeners();
  }

  bool get hasSeenSyncOnboarding => _settingsData.hasSeenSyncOnboarding;

  Future<void> setHasSeenSyncOnboarding(bool hasSeen) async {
    if (_settingsData.hasSeenSyncOnboarding == hasSeen) return;
    _settingsData = _settingsData.copyWith(hasSeenSyncOnboarding: hasSeen);
    await saveData();
    notifyListeners();
  }

  String? get customSupabaseUrl => _settingsData.customSupabaseUrl;
  void setCustomSupabaseUrl(String? val) {
    _settingsData.customSupabaseUrl = val;
    saveData();
    notifyListeners();
  }

  String? get customSupabaseAnonKey => _settingsData.customSupabaseAnonKey;
  void setCustomSupabaseAnonKey(String? val) {
    _settingsData.customSupabaseAnonKey = val;
    saveData();
    notifyListeners();
  }

  bool get isSelfHostedCached => _settingsData.isSelfHostedCached;
  void setIsSelfHostedCached(bool val) {
    _settingsData.isSelfHostedCached = val;
    saveData();
    notifyListeners();
  }

  bool get hasCustomServer =>
      _settingsData.customSupabaseUrl != null &&
      _settingsData.customSupabaseUrl!.isNotEmpty &&
      _settingsData.customSupabaseAnonKey != null &&
      _settingsData.customSupabaseAnonKey!.isNotEmpty;
}
