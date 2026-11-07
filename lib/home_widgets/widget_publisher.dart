import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/home_widgets/widget_action_drainer.dart';
import 'package:habo/home_widgets/widget_snapshot_builder.dart';
import 'package:habo/home_widgets/widget_store.dart';
import 'package:habo/model/habit_data.dart';
import 'package:table_calendar/table_calendar.dart';

/// Writes the widget snapshot and applies queued widget taps.
class WidgetPublisher {
  WidgetPublisher({
    required WidgetStore store,
    required StartingDayOfWeek Function() weekStart,
    required WidgetLabels Function() labels,
    DateTime Function()? now,
  }) : _store = store,
       _weekStart = weekStart,
       _labels = labels,
       _now = now ?? DateTime.now;

  final WidgetStore _store;
  final StartingDayOfWeek Function() _weekStart;
  final WidgetLabels Function() _labels;
  final DateTime Function() _now;
  Future<void>? _drainInFlight;

  /// Writes a fresh snapshot of [habits] and reloads every Habo widget.
  ///
  /// Never throws: a widget refresh failing must not break the app.
  Future<void> publish(List<HabitData> habits) async {
    try {
      final snapshot = buildWidgetSnapshot(
        habits: habits,
        weekStart: _weekStart(),
        labels: _labels(),
        now: _now(),
      );
      await _store.setString(WidgetKeys.snapshot, jsonEncode(snapshot));
      await _store.reloadKinds(WidgetKinds.all);
    } catch (e, st) {
      debugPrint('Widget snapshot publish failed: $e\n$st');
    }
  }

  /// Applies pending widget taps to [habits], then publishes.
  ///
  /// Overlapping calls (resume can fire repeatedly) share one drain.
  Future<void> drainAndPublish(HabitsManager habits) {
    return _drainInFlight ??= _drainAndPublish(habits).whenComplete(() {
      _drainInFlight = null;
    });
  }

  Future<void> _drainAndPublish(HabitsManager habits) async {
    try {
      await WidgetActionDrainer(_store, habits).drain();
    } catch (e, st) {
      debugPrint('Widget action drain failed: $e\n$st');
    }
    await publish([for (final h in habits.allHabits) h.habitData]);
  }
}
