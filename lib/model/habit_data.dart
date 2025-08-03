import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habo/constants.dart';

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
    required this.sanction,
    required this.showSanction,
    required this.accountant,
    this.habitType = HabitType.boolean,
    this.targetValue = 1.0,
    this.partialValue = 1.0,
    this.unit = '',
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
  String sanction;
  bool showSanction;
  String accountant;
  
  // Numeric habit fields
  HabitType habitType;
  double targetValue;
  double partialValue;
  String unit;
  
  // Helper methods for numeric habits
  bool get isNumeric => habitType == HabitType.numeric;
  bool get isBoolean => habitType == HabitType.boolean;
  
  double getProgressForDate(DateTime date) {
    final event = events[date];
    if (event == null) return 0.0;
    
    if (event[0] == DayType.check) return targetValue;
    if (event[0] == DayType.progress && event.length > 2) {
      return (event[2] as double?) ?? 0.0;
    }
    return 0.0;
  }
  
  double getProgressPercentage(DateTime date) {
    if (!isNumeric || targetValue <= 0) return 0.0;
    final progress = getProgressForDate(date);
    return (progress / targetValue).clamp(0.0, 1.0);
  }
  
  bool isCompletedForDate(DateTime date) {
    if (isBoolean) {
      final event = events[date];
      return event != null && event[0] == DayType.check;
    } else {
      return getProgressForDate(date) >= targetValue;
    }
  }
}
