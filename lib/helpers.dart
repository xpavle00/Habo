import 'package:Habo/screens/create_habit_screen.dart';
import 'package:Habo/screens/settings_screen.dart';
import 'package:flutter/material.dart';

Future navigateToSettingsPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SettingsScreen()));
}

Future navigateToCreatePage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CreateHabitScreen()));
}

TimeOfDay parseTimeOfDay(String value) {
  if (value != null) {
    var times = value.split(":");
    if (times.length == 2)
      return TimeOfDay(hour: int.parse(times[0]), minute: int.parse(times[1]));
  }

  return TimeOfDay(hour: 12, minute: 0);
}

enum DayType { Clear, Check, Fail, Skip }
