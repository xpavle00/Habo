import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/model/category.dart';
import 'package:uuid/uuid.dart';

const _uuidGenerator = Uuid();

class HabitData {
  HabitData({
    this.id,
    String? uuid,
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
    this.targetValue = 100.0,
    this.partialValue = 10.0,
    this.unit = '',
    this.categories = const [],
    this.archived = false,
    this.deletedAt,
    DateTime? updatedAt,
  }) : uuid = uuid ?? _uuidGenerator.v4(),
       updatedAt = updatedAt ?? DateTime.now().toUtc();

  SplayTreeMap<DateTime, List> events;
  int streak = 0;
  int? id;
  final String uuid;
  DateTime updatedAt;
  int position;
  DateTime? deletedAt;
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

  // Categories assigned to this habit
  List<Category> categories;

  // Archive status
  bool archived;

  // Helper methods for numeric habits
  bool get isNumeric => habitType == HabitType.numeric;
  bool get isBoolean => habitType == HabitType.boolean;

  double getProgressForDate(DateTime date) {
    final event = events[date];
    if (event == null) return 0.0;

    if (event[0] == DayType.check) {
      // Use stored target value if available, fallback to current
      return event.length > 3
          ? (event[3] as double?) ?? targetValue
          : targetValue;
    }
    if (event[0] == DayType.progress && event.length > 2) {
      return (event[2] as double?) ?? 0.0;
    }
    return 0.0;
  }

  double getProgressPercentage(DateTime date) {
    final event = events[date];
    // Use stored target value if available, fallback to current
    final targetAtTime = (event != null && event.length > 3)
        ? (event[3] as double?) ?? targetValue
        : targetValue;
    if (!isNumeric || targetAtTime <= 0) return 0.0;
    final progress = getProgressForDate(date);
    return (progress / targetAtTime).clamp(0.0, 1.0);
  }

  bool isCompletedForDate(DateTime date) {
    if (isBoolean) {
      final event = events[date];
      return event != null && event[0] == DayType.check;
    } else {
      // Use stored target value for completion check
      final event = events[date];
      final targetAtTime = (event != null && event.length > 3)
          ? (event[3] as double?) ?? targetValue
          : targetValue;
      final progress = getProgressForDate(date);
      return progress >= targetAtTime;
    }
  }

  /// Whether a stored [event] list represents a completed day.
  ///
  /// Boolean habits complete with [DayType.check]. Numeric habits complete
  /// when the entered progress (index 2) reaches the target stored alongside
  /// the event (index 3) — they are saved as [DayType.progress], not
  /// [DayType.check]. Operates on a self-contained event list so it can be
  /// used where only the raw event (not the habit) is available, e.g.
  /// notification scheduling.
  static bool isEventCompleted(List event) {
    if (event.isEmpty) return false;
    if (event[0] == DayType.check) return true;
    if (event[0] == DayType.progress && event.length > 3) {
      final value = (event[2] as num?)?.toDouble() ?? 0.0;
      final target = (event[3] as num?)?.toDouble() ?? 0.0;
      return target > 0 && value >= target;
    }
    return false;
  }
}
