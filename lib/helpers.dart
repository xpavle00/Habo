import 'package:Habo/widgets/create_page.dart';
import 'package:Habo/widgets/settings_page.dart';
import 'package:flutter/material.dart';

Future navigateToSettingsPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
}

Future navigateToCreatePage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CreateHabitPage()));
}

TimeOfDay parseTimeOfDay(String value) {
  if (value != null) {
    var times = value.split(":");
    if (times.length == 2)
      return TimeOfDay(hour: int.parse(times[0]), minute: int.parse(times[1]));
  }

  return TimeOfDay(hour: 12, minute: 0);
}
