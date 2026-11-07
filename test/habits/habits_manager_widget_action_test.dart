import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/helpers.dart';
import 'package:habo/home_widgets/widget_action.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/repositories/category_repository.dart';
import 'package:habo/repositories/event_repository.dart';
import 'package:habo/repositories/habit_repository.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/sync_manager.dart';
import 'package:mocktail/mocktail.dart';

class MockHabitRepository extends Mock implements HabitRepository {}

class MockEventRepository extends Mock implements EventRepository {}

class MockCategoryRepository extends Mock implements CategoryRepository {}

class MockNotificationService extends Mock implements NotificationService {}

class MockSyncManager extends Mock implements SyncManager {}

Habit _habit({
  required int id,
  required String uuid,
  HabitType type = HabitType.boolean,
  SplayTreeMap<DateTime, List>? events,
}) {
  return Habit(
    habitData: HabitData(
      id: id,
      uuid: uuid,
      position: 0,
      title: 'Habit $id',
      twoDayRule: false,
      cue: '',
      routine: '',
      reward: '',
      showReward: false,
      advanced: false,
      notification: false,
      notTime: const TimeOfDay(hour: 9, minute: 0),
      events: events ?? SplayTreeMap<DateTime, List>(),
      sanction: '',
      showSanction: false,
      accountant: '',
      habitType: type,
      targetValue: 30,
      partialValue: 10,
    ),
  );
}

void main() {
  late HabitsManager manager;
  late MockEventRepository events;
  late MockNotificationService notifications;

  final day = DateTime(2026, 11, 5);
  final key = transformDate(day);

  setUp(() {
    events = MockEventRepository();
    notifications = MockNotificationService();
    final sync = MockSyncManager();
    when(() => sync.scheduleSync()).thenReturn(null);
    when(
      () => events.insertEvent(any(), any(), any()),
    ).thenAnswer((_) async {});
    when(() => events.deleteEvent(any(), any())).thenAnswer((_) async {});
    manager = HabitsManager(
      habitRepository: MockHabitRepository(),
      eventRepository: events,
      categoryRepository: MockCategoryRepository(),
      notificationService: notifications,
      syncManager: sync,
    );
  });

  WidgetAction action(String code, {double? value, double? target}) =>
      WidgetAction(
        seq: 1,
        uuid: 'u1',
        date: day,
        code: code,
        value: value,
        target: target,
      );

  test('unknown uuid returns false and writes nothing', () {
    manager.allHabits = [_habit(id: 1, uuid: 'other')];
    expect(manager.applyWidgetAction(action('c')), isFalse);
    verifyNever(() => events.insertEvent(any(), any(), any()));
    verifyNever(() => events.deleteEvent(any(), any()));
  });

  test('code c on boolean adds a check event and updates memory', () {
    final habit = _habit(id: 1, uuid: 'u1');
    manager.allHabits = [habit];

    expect(manager.applyWidgetAction(action('c')), isTrue);

    verify(() => events.insertEvent(1, key, [DayType.check, ''])).called(1);
    expect(habit.habitData.events[key], [DayType.check, '']);
  });

  test('check keeps an existing comment', () {
    final habit = _habit(
      id: 1,
      uuid: 'u1',
      events: SplayTreeMap.of({
        key: [DayType.fail, 'tired'],
      }),
    );
    manager.allHabits = [habit];

    manager.applyWidgetAction(action('c'));

    verify(
      () => events.insertEvent(1, key, [DayType.check, 'tired']),
    ).called(1);
  });

  test('clearing keeps existing comment', () {
    final habit = _habit(
      id: 1,
      uuid: 'u1',
      events: SplayTreeMap.of({
        key: [DayType.check, 'great run'],
      }),
    );
    manager.allHabits = [habit];

    manager.applyWidgetAction(action('.'));

    verify(
      () => events.insertEvent(1, key, [DayType.clear, 'great run']),
    ).called(1);
    verifyNever(() => events.deleteEvent(any(), any()));
    expect(habit.habitData.events[key], [DayType.clear, 'great run']);
  });

  test('clearing without a comment deletes the event', () {
    final habit = _habit(
      id: 1,
      uuid: 'u1',
      events: SplayTreeMap.of({
        key: [DayType.check, ''],
      }),
    );
    manager.allHabits = [habit];

    manager.applyWidgetAction(action('.'));

    verify(() => events.deleteEvent(1, key)).called(1);
    expect(habit.habitData.events.containsKey(key), isFalse);
  });

  test('progress codes add a progress event with value and target', () {
    final habit = _habit(id: 1, uuid: 'u1', type: HabitType.numeric);
    manager.allHabits = [habit];

    manager.applyWidgetAction(action('P', value: 30, target: 30));

    verify(
      () => events.insertEvent(1, key, [DayType.progress, '', 30.0, 30.0]),
    ).called(1);
    expect(habit.habitData.events[key], [DayType.progress, '', 30.0, 30.0]);
  });

  test('notifies listeners', () {
    manager.allHabits = [_habit(id: 1, uuid: 'u1')];
    var notified = 0;
    manager.addListener(() => notified++);

    manager.applyWidgetAction(action('c'));

    expect(notified, greaterThan(0));
  });
}
