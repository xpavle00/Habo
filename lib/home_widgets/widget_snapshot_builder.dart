import 'dart:collection';

import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/streak.dart';
import 'package:habo/helpers.dart';
import 'package:habo/model/habit_data.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/// Snapshot schema version shared with the native widgets.
const int widgetSnapshotVersion = 1;

/// Localized strings the native widgets display, taken from the app's own
/// translations so widgets follow the language chosen inside Habo.
class WidgetLabels {
  const WidgetLabels({
    required this.habitsToday,
    required this.chooseHabit,
    required this.noHabits,
    required this.months,
  });

  factory WidgetLabels.fromS(S s, String locale) {
    final format = DateFormat.MMM(locale);
    return WidgetLabels(
      habitsToday: s.habitsToday,
      chooseHabit: s.widgetChooseHabit,
      noHabits: s.widgetNoHabits,
      months: [for (var m = 1; m <= 12; m++) format.format(DateTime(2000, m))],
    );
  }

  final String habitsToday;
  final String chooseHabit;
  final String noHabits;
  final List<String> months;

  Map<String, dynamic> toJson() => {
    'habitsToday': habitsToday,
    'chooseHabit': chooseHabit,
    'noHabits': noHabits,
    'months': months,
  };
}

/// Builds the JSON snapshot every native widget renders from.
///
/// Pure function of its inputs. The schema is the contract with the iOS
/// (and later Android) widgets; see the iOS widgets design spec.
Map<String, dynamic> buildWidgetSnapshot({
  required List<HabitData> habits,
  required StartingDayOfWeek weekStart,
  required WidgetLabels labels,
  required DateTime now,
}) {
  final today = DateTime(now.year, now.month, now.day);
  final active =
      habits.where((h) => !h.archived && h.deletedAt == null).toList()
        ..sort((a, b) => a.position.compareTo(b.position));

  return {
    'v': widgetSnapshotVersion,
    'date': _formatDate(today),
    'weekStart': weekStart.index + 1,
    'labels': labels.toJson(),
    'habits': [for (final h in active) _habitJson(h, today)],
  };
}

Map<String, dynamic> _habitJson(HabitData habit, DateTime today) {
  return {
    'uuid': habit.uuid,
    'id': habit.id,
    'title': habit.title,
    'type': habit.isNumeric ? 'numeric' : 'boolean',
    'target': habit.targetValue,
    'partial': habit.partialValue,
    'unit': habit.unit,
    'position': habit.position,
    'reminder': habit.notification
        ? {'hour': habit.notTime.hour, 'minute': habit.notTime.minute}
        : null,
    'year': today.year,
    'days': _dayCodes(habit, today.year),
    'today': habit.isNumeric ? _todayProgress(habit, today) : null,
    'streak': _streakTable(habit, today),
  };
}

String _dayCodes(HabitData habit, int year) {
  final length = DateTime(year + 1).difference(DateTime(year)).inDays;
  final codes = List.filled(length, '.');
  habit.events.forEach((key, event) {
    if (key.year != year || event.isEmpty) return;
    final index = DateTime(
      key.year,
      key.month,
      key.day,
    ).difference(DateTime(year)).inDays;
    if (index < 0 || index >= length) return;
    codes[index] = _codeFor(event, habit.targetValue);
  });
  return codes.join();
}

String _codeFor(List event, double fallbackTarget) {
  switch (event[0] as DayType) {
    case DayType.check:
      return 'c';
    case DayType.fail:
      return 'f';
    case DayType.skip:
      return 's';
    case DayType.clear:
      return '.';
    case DayType.progress:
      final value = event.length > 2 ? (event[2] as num?)?.toDouble() : null;
      final target = event.length > 3
          ? (event[3] as num?)?.toDouble() ?? fallbackTarget
          : fallbackTarget;
      return (value != null && value >= target) ? 'P' : 'p';
  }
}

Map<String, double> _todayProgress(HabitData habit, DateTime today) {
  final event = habit.events[transformDate(today)];
  double value = 0;
  double target = habit.targetValue;
  if (event != null && event.length > 2) {
    value = (event[2] as num?)?.toDouble() ?? 0;
    if (event.length > 3) {
      target = (event[3] as num?)?.toDouble() ?? habit.targetValue;
    }
  }
  return {'value': value, 'target': target};
}

bool _isDone(List event, double fallbackTarget) {
  final code = _codeFor(event, fallbackTarget);
  return code == 'c' || code == 'P';
}

/// Precomputed streaks so widgets can show a correct streak after an
/// optimistic tap, and after one midnight rollover, without porting the
/// streak rules to native code.
///
/// `today = [ifTodayNotDone, ifTodayDone]`;
/// `tomorrow[a][b]` = streak tomorrow when today done = a, tomorrow done = b.
Map<String, dynamic> _streakTable(HabitData habit, DateTime today) {
  final todayKey = transformDate(today);
  final tomorrowKey = transformDate(
    DateTime(today.year, today.month, today.day + 1),
  );
  final existing = habit.events[todayKey];

  SplayTreeMap<DateTime, List> withToday(bool done) {
    final events = SplayTreeMap<DateTime, List>.of(habit.events);
    if (done) {
      events[todayKey] = [DayType.check, ''];
    } else if (existing != null && _isDone(existing, habit.targetValue)) {
      // Undoing a done day clears it, as the widget does.
      events.remove(todayKey);
    }
    return events;
  }

  int streak(SplayTreeMap<DateTime, List> events) => computeStreak(
    events,
    twoDayRule: habit.twoDayRule,
    targetValue: habit.targetValue,
  ).streak;

  List<int> tomorrowRow(bool todayDone) {
    final base = withToday(todayDone)..remove(tomorrowKey);
    final done = SplayTreeMap<DateTime, List>.of(base)
      ..[tomorrowKey] = [DayType.check, ''];
    return [streak(base), streak(done)];
  }

  return {
    'today': [streak(withToday(false)), streak(withToday(true))],
    'tomorrow': [tomorrowRow(false), tomorrowRow(true)],
  };
}

String _formatDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';
