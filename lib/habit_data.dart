import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitData {
  HabitData(
      {this.id,
      this.position,
      this.title,
      this.twoDayRule,
      this.cue,
      this.routine,
      this.reward,
      this.showReward,
      this.advanced,
      this.notification,
      this.notTime,
      this.events});

  SplayTreeMap<DateTime, List> events;
  int streak = 0;
  CalendarController calendarController = new CalendarController();
  int id;
  int position;
  String title;
  bool twoDayRule;
  String cue;
  String routine;
  String reward;
  bool showReward;
  bool advanced;
  bool notification;
  TimeOfDay notTime;
}
