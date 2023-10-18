import 'package:flutter/material.dart';

TimeOfDay parseTimeOfDay(String? value) {
  if (value != null) {
    var times = value.split(':');
    if (times.length == 2) {
      return TimeOfDay(hour: int.parse(times[0]), minute: int.parse(times[1]));
    }
  }

  return const TimeOfDay(hour: 12, minute: 0);
}

DateTime transformDate(DateTime date) {
  return DateTime.utc(
    date.year,
    date.month,
    date.day,
    12,
  );
}
