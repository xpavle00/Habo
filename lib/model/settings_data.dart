import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/helpers.dart';
import 'package:table_calendar/table_calendar.dart';

class SettingsData {
  Themes theme = Themes.device;
  StartingDayOfWeek weekStart = StartingDayOfWeek.monday;
  TimeOfDay dailyNotTime = const TimeOfDay(hour: 20, minute: 0);
  bool showDailyNot = true;
  bool soundEffects = true;
  double soundVolume = 3.0; // Volume level 0-5
  bool showMonthName = true;
  bool seenOnboarding = false;
  bool showCategories = true;
  Color checkColor = HaboColors.primary;
  Color failColor = HaboColors.red;
  Color skipColor = HaboColors.skip;
  Color progressColor = HaboColors.progress;
  bool biometricLock = false;
  bool oneTapCheck = false;
  String lastWhatsNewVersion = '';
  int syncVersion = 0;
  bool hasUnsyncedChanges = false;
  bool isSyncPaused = false;
  bool hasSeenSyncOnboarding = false;
  String? customSupabaseUrl;
  String? customSupabaseAnonKey;
  bool isSelfHostedCached = false;

  SettingsData();

  SettingsData.fromJson(Map<String, dynamic> json)
    : theme = Themes.values[json['theme']],
      weekStart = StartingDayOfWeek.values[json['weekStart']],
      showDailyNot = (json['showDailyNot'] != null)
          ? json['showDailyNot']
          : true,
      soundEffects = (json['soundEffects'] != null)
          ? json['soundEffects']
          : true,
      soundVolume = (json['soundVolume'] != null) ? json['soundVolume'] : 3.0,
      showMonthName = (json['showMonthName'] != null)
          ? json['showMonthName']
          : true,
      seenOnboarding = (json['seenOnboarding'] != null)
          ? json['seenOnboarding']
          : false,
      showCategories = (json['showCategories'] != null)
          ? json['showCategories']
          : true,
      dailyNotTime = (json['notTime'] != null)
          ? parseTimeOfDay(json['notTime'])
          : const TimeOfDay(hour: 20, minute: 0),
      checkColor = (json['checkColor'] != null)
          ? Color(json['checkColor'])
          : HaboColors.primary,
      failColor = (json['failColor'] != null)
          ? Color(json['failColor'])
          : HaboColors.red,
      skipColor = (json['skipColor'] != null)
          ? Color(json['skipColor'])
          : HaboColors.skip,
      progressColor = (json['progressColor'] != null)
          ? Color(json['progressColor'])
          : HaboColors.progress,
      biometricLock = (json['biometricLock'] != null)
          ? json['biometricLock']
          : false,
      oneTapCheck = (json['oneTapCheck'] != null) ? json['oneTapCheck'] : false,
      lastWhatsNewVersion = (json['lastWhatsNewVersion'] != null)
          ? json['lastWhatsNewVersion']
          : '',
      syncVersion = (json['syncVersion'] != null) ? json['syncVersion'] : 0,
      hasUnsyncedChanges = (json['hasUnsyncedChanges'] != null)
          ? json['hasUnsyncedChanges']
          : false,
      isSyncPaused = (json['isSyncPaused'] != null)
          ? json['isSyncPaused']
          : false,
      hasSeenSyncOnboarding = (json['hasSeenSyncOnboarding'] != null)
          ? json['hasSeenSyncOnboarding']
          : false,
      customSupabaseUrl = json['customSupabaseUrl'] as String?,
      customSupabaseAnonKey = json['customSupabaseAnonKey'] as String?,
      isSelfHostedCached = (json['isSelfHostedCached'] != null)
          ? json['isSelfHostedCached']
          : false;

  SettingsData copyWith({
    Themes? theme,
    StartingDayOfWeek? weekStart,
    TimeOfDay? dailyNotTime,
    bool? showDailyNot,
    bool? soundEffects,
    double? soundVolume,
    bool? showMonthName,
    bool? seenOnboarding,
    bool? showCategories,
    Color? checkColor,
    Color? failColor,
    Color? skipColor,
    Color? progressColor,
    bool? biometricLock,
    bool? oneTapCheck,
    String? lastWhatsNewVersion,
    int? syncVersion,
    bool? hasUnsyncedChanges,
    bool? isSyncPaused,
    bool? hasSeenSyncOnboarding,
    String? customSupabaseUrl,
    String? customSupabaseAnonKey,
    bool? isSelfHostedCached,
  }) {
    return SettingsData()
      ..theme = theme ?? this.theme
      ..weekStart = weekStart ?? this.weekStart
      ..dailyNotTime = dailyNotTime ?? this.dailyNotTime
      ..showDailyNot = showDailyNot ?? this.showDailyNot
      ..soundEffects = soundEffects ?? this.soundEffects
      ..soundVolume = soundVolume ?? this.soundVolume
      ..showMonthName = showMonthName ?? this.showMonthName
      ..seenOnboarding = seenOnboarding ?? this.seenOnboarding
      ..showCategories = showCategories ?? this.showCategories
      ..checkColor = checkColor ?? this.checkColor
      ..failColor = failColor ?? this.failColor
      ..skipColor = skipColor ?? this.skipColor
      ..progressColor = progressColor ?? this.progressColor
      ..biometricLock = biometricLock ?? this.biometricLock
      ..oneTapCheck = oneTapCheck ?? this.oneTapCheck
      ..lastWhatsNewVersion = lastWhatsNewVersion ?? this.lastWhatsNewVersion
      ..syncVersion = syncVersion ?? this.syncVersion
      ..hasUnsyncedChanges = hasUnsyncedChanges ?? this.hasUnsyncedChanges
      ..isSyncPaused = isSyncPaused ?? this.isSyncPaused
      ..hasSeenSyncOnboarding =
          hasSeenSyncOnboarding ?? this.hasSeenSyncOnboarding
      ..customSupabaseUrl = customSupabaseUrl ?? this.customSupabaseUrl
      ..customSupabaseAnonKey = customSupabaseAnonKey ?? this.customSupabaseAnonKey
      ..isSelfHostedCached = isSelfHostedCached ?? this.isSelfHostedCached;
  }

  Map<String, dynamic> toJson() => {
    'theme': theme.index,
    'weekStart': weekStart.index,
    'notTime':
        '${dailyNotTime.hour.toString().padLeft(2, '0')}:${dailyNotTime.minute.toString().padLeft(2, '0')}',
    'showDailyNot': showDailyNot,
    'soundEffects': soundEffects,
    'soundVolume': soundVolume,
    'showMonthName': showMonthName,
    'seenOnboarding': seenOnboarding,
    'showCategories': showCategories,
    'checkColor': checkColor.toARGB32(),
    'failColor': failColor.toARGB32(),
    'skipColor': skipColor.toARGB32(),
    'progressColor': progressColor.toARGB32(),
    'biometricLock': biometricLock,
    'oneTapCheck': oneTapCheck,
    'lastWhatsNewVersion': lastWhatsNewVersion,
    'syncVersion': syncVersion,
    'hasUnsyncedChanges': hasUnsyncedChanges,
    'isSyncPaused': isSyncPaused,
    'hasSeenSyncOnboarding': hasSeenSyncOnboarding,
    'customSupabaseUrl': customSupabaseUrl,
    'customSupabaseAnonKey': customSupabaseAnonKey,
    'isSelfHostedCached': isSelfHostedCached,
  };
}
