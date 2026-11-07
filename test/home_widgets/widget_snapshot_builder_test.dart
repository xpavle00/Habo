import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/streak.dart';
import 'package:habo/helpers.dart';
import 'package:habo/home_widgets/widget_snapshot_builder.dart';
import 'package:habo/model/habit_data.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

/// Swift decodes this exact file (ios/HaboWidgetCore tests). Regenerate with
/// `UPDATE_WIDGET_FIXTURE=1 flutter test test/home_widgets/widget_snapshot_builder_test.dart`.
const _fixturePath =
    'ios/HaboWidgetCore/Tests/HaboWidgetCoreTests/Fixtures/snapshot.json';

const _labels = WidgetLabels(
  habitsToday: 'Habits today',
  chooseHabit: 'Choose a habit',
  noHabits: 'Add a habit in Habo',
  months: [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ],
);

HabitData _habit({
  int id = 1,
  String? uuid,
  int position = 0,
  String title = 'Habit',
  HabitType type = HabitType.boolean,
  Map<DateTime, List>? events,
  bool archived = false,
  DateTime? deletedAt,
  bool notification = false,
  bool twoDayRule = false,
}) {
  final map = SplayTreeMap<DateTime, List>();
  events?.forEach((day, event) => map[transformDate(day)] = event);
  return HabitData(
    id: id,
    uuid: uuid ?? 'uuid-$id',
    position: position,
    title: title,
    twoDayRule: twoDayRule,
    cue: '',
    routine: '',
    reward: '',
    showReward: false,
    advanced: false,
    notification: notification,
    notTime: const TimeOfDay(hour: 20, minute: 30),
    events: map,
    sanction: '',
    showSanction: false,
    accountant: '',
    habitType: type,
    targetValue: 30,
    partialValue: 10,
    unit: type == HabitType.numeric ? 'min' : '',
    archived: archived,
    deletedAt: deletedAt,
  );
}

Map<String, dynamic> _build(
  List<HabitData> habits, {
  DateTime? now,
  StartingDayOfWeek weekStart = StartingDayOfWeek.monday,
}) => buildWidgetSnapshot(
  habits: habits,
  weekStart: weekStart,
  labels: _labels,
  now: now ?? DateTime(2026, 11, 6, 21, 15),
);

Map<String, dynamic> _only(Map<String, dynamic> snapshot) =>
    (snapshot['habits'] as List).single as Map<String, dynamic>;

int _dayIndex(DateTime d) => d.difference(DateTime(d.year)).inDays;

void main() {
  test('header fields', () {
    final s = _build([]);
    expect(s['v'], 1);
    expect(s['date'], '2026-11-06');
    expect(s['weekStart'], 1);
    expect(s['labels']['months'], hasLength(12));
    expect(s['habits'], isEmpty);
  });

  test('weekStart monday is 1 and sunday is 7', () {
    expect(_build([], weekStart: StartingDayOfWeek.sunday)['weekStart'], 7);
    expect(_build([], weekStart: StartingDayOfWeek.monday)['weekStart'], 1);
  });

  test('days has 365 chars in 2026 and 366 in 2028', () {
    expect(_only(_build([_habit()]))['days'], hasLength(365));
    expect(
      _only(_build([_habit()], now: DateTime(2028, 3, 1)))['days'],
      hasLength(366),
    );
  });

  test('day codes for every event type', () {
    final h = _habit(
      type: HabitType.numeric,
      events: {
        DateTime(2026, 1, 1): [DayType.check, ''],
        DateTime(2026, 1, 2): [DayType.fail, ''],
        DateTime(2026, 1, 3): [DayType.skip, ''],
        DateTime(2026, 1, 4): [DayType.progress, '', 10.0, 30.0],
        DateTime(2026, 1, 5): [DayType.progress, '', 30.0, 30.0],
        DateTime(2026, 1, 6): [DayType.clear, 'note'],
      },
    );
    final days = _only(_build([h]))['days'] as String;
    expect(days.substring(0, 7), 'cfspP..');
  });

  test('progress uses the target stored on the event', () {
    final h = _habit(
      type: HabitType.numeric,
      events: {
        DateTime(2026, 2, 1): [DayType.progress, '', 20.0, 20.0],
      },
    );
    final days = _only(_build([h]))['days'] as String;
    expect(days[_dayIndex(DateTime(2026, 2, 1))], 'P');
  });

  test('events from the previous year are ignored', () {
    final h = _habit(
      events: {
        DateTime(2025, 12, 31): [DayType.check, ''],
      },
    );
    final days = _only(_build([h]))['days'] as String;
    expect(days, '.' * 365);
  });

  test('archived and deleted habits are excluded', () {
    final s = _build([
      _habit(id: 1),
      _habit(id: 2, archived: true),
      _habit(id: 3, deletedAt: DateTime(2026, 1, 1)),
    ]);
    expect((s['habits'] as List).map((h) => h['id']), [1]);
  });

  test('habits are ordered by position', () {
    final s = _build([
      _habit(id: 1, position: 2),
      _habit(id: 2, position: 0),
      _habit(id: 3, position: 1),
    ]);
    expect((s['habits'] as List).map((h) => h['id']), [2, 3, 1]);
  });

  test('boolean habit has no today block', () {
    expect(_only(_build([_habit()]))['today'], isNull);
  });

  test('numeric habit today has value and target', () {
    final h = _habit(
      type: HabitType.numeric,
      events: {
        DateTime(2026, 11, 6): [DayType.progress, '', 12.0, 25.0],
      },
    );
    expect(_only(_build([h]))['today'], {'value': 12.0, 'target': 25.0});
  });

  test('numeric habit without event today has zero value', () {
    final h = _habit(type: HabitType.numeric);
    expect(_only(_build([h]))['today'], {'value': 0.0, 'target': 30.0});
  });

  test('reminder is null when notification is off', () {
    expect(_only(_build([_habit()]))['reminder'], isNull);
    expect(_only(_build([_habit(notification: true)]))['reminder'], {
      'hour': 20,
      'minute': 30,
    });
  });

  test('streak variants match computeStreak on simulated events', () {
    final h = _habit(
      events: {
        DateTime(2026, 11, 4): [DayType.check, ''],
        DateTime(2026, 11, 5): [DayType.check, ''],
      },
    );
    final streak = _only(_build([h]))['streak'];
    expect(streak['today'], [2, 3]);
    // Skipping today and checking tomorrow leaves a two-day gap: streak 1.
    expect(streak['tomorrow'], [
      [2, 1],
      [3, 4],
    ]);

    // Cross-check one cell against the shared implementation.
    final simulated = SplayTreeMap<DateTime, List>.of(h.events)
      ..[transformDate(DateTime(2026, 11, 6))] = [DayType.check, '']
      ..[transformDate(DateTime(2026, 11, 7))] = [DayType.check, ''];
    expect(
      streak['tomorrow'][1][1],
      computeStreak(simulated, twoDayRule: false, targetValue: 30).streak,
    );
  });

  test('today not-done variant keeps a fail logged today', () {
    final h = _habit(
      events: {
        DateTime(2026, 11, 5): [DayType.check, ''],
        DateTime(2026, 11, 6): [DayType.fail, ''],
      },
    );
    expect(_only(_build([h]))['streak']['today'], [0, 2]);
  });

  test('fields copied from the habit', () {
    final h = _habit(
      id: 7,
      uuid: 'abc',
      title: 'Read',
      type: HabitType.numeric,
    );
    final out = _only(_build([h]));
    expect(out['uuid'], 'abc');
    expect(out['id'], 7);
    expect(out['title'], 'Read');
    expect(out['type'], 'numeric');
    expect(out['target'], 30.0);
    expect(out['partial'], 10.0);
    expect(out['unit'], 'min');
    expect(out['year'], 2026);
  });

  test('WidgetLabels.fromS uses app strings and locale month names', () async {
    await initializeDateFormatting('en');
    final s = await S.load(const Locale('en'));
    final labels = WidgetLabels.fromS(s, 'en');
    expect(labels.habitsToday, 'Habits today');
    expect(labels.chooseHabit, 'Choose a habit');
    expect(labels.noHabits, 'Add a habit in Habo');
    expect(labels.months.first, 'Jan');
    expect(labels.months.last, 'Dec');
  });

  test('output passes jsonEncode and matches the shared Swift fixture', () {
    final snapshot = _build([
      _habit(
        id: 1,
        uuid: 'water',
        title: 'Drink water',
        notification: true,
        events: {
          DateTime(2026, 1, 1): [DayType.check, ''],
          DateTime(2026, 11, 4): [DayType.check, ''],
          DateTime(2026, 11, 5): [DayType.skip, ''],
        },
      ),
      _habit(
        id: 2,
        uuid: 'read',
        title: 'Read',
        position: 1,
        type: HabitType.numeric,
        events: {
          DateTime(2026, 11, 5): [DayType.fail, ''],
          DateTime(2026, 11, 6): [DayType.progress, '', 10.0, 30.0],
        },
      ),
    ]);
    final json = const JsonEncoder.withIndent('  ').convert(snapshot);

    final file = File(_fixturePath);
    if (Platform.environment['UPDATE_WIDGET_FIXTURE'] == '1') {
      file.createSync(recursive: true);
      file.writeAsStringSync('$json\n');
    }
    expect(file.readAsStringSync(), '$json\n');
  });
}
