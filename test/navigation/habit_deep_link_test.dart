import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/navigation/habit_deep_link.dart';
import 'package:habo/navigation/route_information_parser.dart';

Habit _habit(String uuid) => Habit(
  habitData: HabitData(
    uuid: uuid,
    position: 0,
    title: uuid,
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
  ),
);

Future<String> _parse(String url) async {
  final config = await HaboRouteInformationParser().parseRouteInformation(
    RouteInformation(uri: Uri.parse(url)),
  );
  return config.path;
}

void main() {
  group('parser', () {
    test('habo://habit/<uuid> parses to /habit/<uuid>', () async {
      expect(await _parse('habo://habit/AbC-1'), '/habit/AbC-1');
    });

    test('habo://settings still parses to /settings', () async {
      expect(await _parse('habo://settings'), '/settings');
    });

    test('habo://open parses to /open', () async {
      expect(await _parse('habo://open'), '/open');
    });
  });

  group('resolveHabitDeepLink', () {
    final habits = [_habit('one'), _habit('AbC-1')];

    test('known uuid resolves to that habit, keeping uuid case', () {
      expect(resolveHabitDeepLink('/habit/AbC-1', habits)?.uuid, 'AbC-1');
    });

    test('prefix matches case-insensitively', () {
      expect(resolveHabitDeepLink('/HABIT/one', habits)?.uuid, 'one');
    });

    test('unknown uuid resolves to null', () {
      expect(resolveHabitDeepLink('/habit/missing', habits), isNull);
    });

    test('other paths resolve to null', () {
      expect(resolveHabitDeepLink('/settings', habits), isNull);
      expect(resolveHabitDeepLink('/habit/', habits), isNull);
    });
  });
}
