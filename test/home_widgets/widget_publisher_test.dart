import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/home_widgets/widget_action.dart';
import 'package:habo/home_widgets/widget_publisher.dart';
import 'package:habo/home_widgets/widget_snapshot_builder.dart';
import 'package:habo/home_widgets/widget_store.dart';
import 'package:habo/model/habit_data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:table_calendar/table_calendar.dart';

import 'fake_widget_store.dart';

class MockHabitsManager extends Mock implements HabitsManager {}

class ThrowingStore extends FakeWidgetStore {
  @override
  Future<void> setString(String key, String value) async =>
      throw Exception('platform channel missing');
}

HabitData _data(int id) => HabitData(
  id: id,
  uuid: 'u$id',
  position: id,
  title: 'H$id',
  twoDayRule: false,
  cue: '',
  routine: '',
  reward: '',
  showReward: false,
  advanced: false,
  notification: false,
  notTime: const TimeOfDay(hour: 9, minute: 0),
  events: SplayTreeMap<DateTime, List>(),
  sanction: '',
  showSanction: false,
  accountant: '',
);

const _labels = WidgetLabels(
  habitsToday: 'Habits today',
  chooseHabit: 'Choose a habit',
  noHabits: 'Add a habit in Habo',
  months: ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
);

void main() {
  late FakeWidgetStore store;
  late WidgetPublisher publisher;

  setUpAll(() {
    registerFallbackValue(
      WidgetAction(seq: 0, uuid: '', date: DateTime(2026), code: 'c'),
    );
  });

  setUp(() {
    store = FakeWidgetStore();
    publisher = WidgetPublisher(
      store: store,
      weekStart: () => StartingDayOfWeek.sunday,
      labels: () => _labels,
      now: () => DateTime(2026, 11, 6, 10),
    );
  });

  test('publish writes the snapshot then reloads all three kinds', () async {
    await publisher.publish([_data(1)]);

    final snapshot =
        jsonDecode(store.values[WidgetKeys.snapshot] as String) as Map;
    expect(snapshot['date'], '2026-11-06');
    expect(snapshot['weekStart'], 7);
    expect((snapshot['habits'] as List).single['uuid'], 'u1');
    expect(store.reloads, [
      ['HaboWidget', 'HaboCheckInWidget', 'HaboHeatmapWidget'],
    ]);
  });

  test('drainAndPublish drains before publishing', () async {
    final habits = MockHabitsManager();
    final habit = Habit(habitData: _data(1));
    when(() => habits.allHabits).thenReturn([habit]);
    when(() => habits.applyWidgetAction(any())).thenAnswer((_) {
      // The snapshot must not have been written yet when actions apply.
      expect(store.values.containsKey(WidgetKeys.snapshot), isFalse);
      return true;
    });
    store.values[WidgetKeys.pendingActions] = jsonEncode([
      {'seq': 1, 'uuid': 'u1', 'date': '2026-11-06', 'code': 'c'},
    ]);

    await publisher.drainAndPublish(habits);

    verify(() => habits.applyWidgetAction(any())).called(1);
    expect(store.values[WidgetKeys.appliedSeq], 1);
    expect(store.values.containsKey(WidgetKeys.snapshot), isTrue);
  });

  test('publish errors are swallowed', () async {
    final failing = WidgetPublisher(
      store: ThrowingStore(),
      weekStart: () => StartingDayOfWeek.monday,
      labels: () => _labels,
    );
    await expectLater(failing.publish([_data(1)]), completes);
  });

  test('overlapping drainAndPublish calls drain once', () async {
    final habits = MockHabitsManager();
    when(() => habits.allHabits).thenReturn([Habit(habitData: _data(1))]);
    when(() => habits.applyWidgetAction(any())).thenReturn(true);
    store.values[WidgetKeys.pendingActions] = jsonEncode([
      {'seq': 1, 'uuid': 'u1', 'date': '2026-11-06', 'code': 'c'},
    ]);

    await Future.wait([
      publisher.drainAndPublish(habits),
      publisher.drainAndPublish(habits),
    ]);

    verify(() => habits.applyWidgetAction(any())).called(1);
  });
}
