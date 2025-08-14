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
  bool showMonthName = true;
  bool seenOnboarding = false;
  bool showCategories = true;
  Color checkColor = HaboColors.primary;
  Color failColor = HaboColors.red;
  Color skipColor = HaboColors.skip;
  Color progressColor = HaboColors.progress;

  SettingsData();

  SettingsData.fromJson(Map<String, dynamic> json)
      : theme = Themes.values[json['theme']],
        weekStart = StartingDayOfWeek.values[json['weekStart']],
        showDailyNot =
            (json['showDailyNot'] != null) ? json['showDailyNot'] : true,
        soundEffects =
            (json['soundEffects'] != null) ? json['soundEffects'] : true,
        showMonthName =
            (json['showMonthName'] != null) ? json['showMonthName'] : true,
        seenOnboarding =
            (json['seenOnboarding'] != null) ? json['seenOnboarding'] : false,
        showCategories =
            (json['showCategories'] != null) ? json['showCategories'] : true,
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
            : HaboColors.progress;

  Map<String, dynamic> toJson() => {
        'theme': theme.index,
        'weekStart': weekStart.index,
        'notTime':
            '${dailyNotTime.hour.toString().padLeft(2, '0')}:${dailyNotTime.minute.toString().padLeft(2, '0')}',
        'showDailyNot': showDailyNot,
        'soundEffects': soundEffects,
        'showMonthName': showMonthName,
        'seenOnboarding': seenOnboarding,
        'showCategories': showCategories,
        'checkColor': checkColor.value,
        'failColor': failColor.value,
        'skipColor': skipColor.value,
        'progressColor': progressColor.value,
      };
}
