import 'dart:collection';

import 'package:flutter/material.dart';

class HabitData {
  HabitData({
    this.id,
    required this.position,
    required this.title,
    required this.twoDayRule,
    required this.cue,
    required this.routine,
    required this.reward,
    required this.showReward,
    required this.advanced,
    required this.notification,
    required this.notTime,
    required this.events,
  });

  SplayTreeMap<DateTime, List> events;
  int streak = 0;
  int? id;
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
