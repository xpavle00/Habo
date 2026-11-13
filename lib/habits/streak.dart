import 'dart:collection';

import 'package:habo/constants.dart';

/// Result of walking a habit's events backwards from the most recent one.
class StreakResult {
  const StreakResult({required this.streak, required this.orange});

  /// Number of completed days in the current streak.
  final int streak;

  /// True when the most recent non-clear event is a fail (two-day rule only).
  final bool orange;
}

/// Computes a habit's current streak from its [events].
///
/// Pure extraction of the logic that used to live in `_HabitState`, so the
/// app and the home-screen widget snapshot share one implementation.
StreakResult computeStreak(
  SplayTreeMap<DateTime, List> events, {
  required bool twoDayRule,
  required double targetValue,
}) {
  return twoDayRule
      ? _twoDay(events, targetValue)
      : _normal(events, targetValue);
}

StreakResult _normal(SplayTreeMap<DateTime, List> events, double targetValue) {
  int inStreak = 0;
  var checkDayKey = events.lastKey();
  var lastDayKey = events.lastKey();

  while (events[checkDayKey] != null &&
      events[checkDayKey]![0] != DayType.fail) {
    if (events[checkDayKey]![0] != DayType.clear) {
      if (events[lastDayKey]![0] != null &&
          events[lastDayKey]![0] != DayType.clear &&
          lastDayKey!.difference(checkDayKey!).inDays > 1) {
        break;
      }
      lastDayKey = checkDayKey;
    }

    final event = events[checkDayKey]!;
    final targetAtTime = (event.length > 3)
        ? (event[3] as double?) ?? targetValue
        : targetValue;
    if (event[0] == DayType.check ||
        (event[0] == DayType.progress &&
            event.length > 2 &&
            event[2] >= targetAtTime)) {
      inStreak++;
    }
    checkDayKey = events.lastKeyBefore(checkDayKey!);
  }

  return StreakResult(streak: inStreak, orange: false);
}

StreakResult _twoDay(SplayTreeMap<DateTime, List> events, double targetValue) {
  int inStreak = 0;
  var trueLastKey = events.lastKey();

  // Skip clear entries and single incomplete progress (treated as clear)
  while (events[trueLastKey] != null &&
      events[trueLastKey]![0] != null &&
      (events[trueLastKey]![0] == DayType.clear ||
          (events[trueLastKey]![0] == DayType.progress &&
              events[trueLastKey]!.length > 2 &&
              events[trueLastKey]![2] <
                  ((events[trueLastKey]!.length > 3)
                      ? (events[trueLastKey]![3] as double?) ?? targetValue
                      : targetValue)))) {
    trueLastKey = events.lastKeyBefore(trueLastKey!);
  }

  var checkDayKey = trueLastKey;
  var lastDayKey = trueLastKey;
  DayType lastDay = DayType.check;

  while (events[checkDayKey] != null) {
    if (events[checkDayKey]![0] != DayType.clear) {
      // End if fail and next is not check, clear or progress
      if (events[checkDayKey]![0] == DayType.fail &&
          (lastDay != DayType.check &&
              lastDay != DayType.clear &&
              (lastDay != DayType.progress))) {
        break;
      }

      // End if gap is more than 1 day
      if (events[lastDayKey]![0] != null &&
          events[lastDayKey]![0] != DayType.clear &&
          lastDayKey!.difference(checkDayKey!).inDays > 1) {
        break;
      }

      lastDayKey = checkDayKey;
    }

    // Count streak if check or 100% progress
    lastDay = events[checkDayKey]![0];
    final event = events[checkDayKey]!;
    // Use stored target value for completion check
    final targetAtTime = (event.length > 3)
        ? (event[3] as double?) ?? targetValue
        : targetValue;
    if (event[0] == DayType.check ||
        (event[0] == DayType.progress &&
            event.length > 2 &&
            (event[2] as double?) != null &&
            (event[2] as double) >= targetAtTime)) {
      inStreak++;
    }
    checkDayKey = events.lastKeyBefore(checkDayKey!);
  }

  return StreakResult(
    streak: inStreak,
    orange:
        (events[trueLastKey] != null &&
        events[trueLastKey]![0] == DayType.fail),
  );
}
