import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/streak.dart';

SplayTreeMap<DateTime, List> _events(Map<int, List> byDay) {
  final map = SplayTreeMap<DateTime, List>();
  byDay.forEach((day, event) => map[DateTime(2026, 3, day)] = event);
  return map;
}

void main() {
  group('computeStreak (normal rule)', () {
    StreakResult run(Map<int, List> byDay, {double target = 100}) =>
        computeStreak(_events(byDay), twoDayRule: false, targetValue: target);

    test('empty events gives 0', () {
      expect(run({}).streak, 0);
    });

    test('three consecutive checks give 3', () {
      final result = run({
        1: [DayType.check, ''],
        2: [DayType.check, ''],
        3: [DayType.check, ''],
      });
      expect(result.streak, 3);
      expect(result.orange, isFalse);
    });

    test('fail breaks the streak', () {
      expect(
        run({
          1: [DayType.check, ''],
          2: [DayType.fail, ''],
          3: [DayType.check, ''],
          4: [DayType.check, ''],
        }).streak,
        2,
      );
    });

    test('gap of two days breaks the streak', () {
      expect(
        run({
          1: [DayType.check, ''],
          3: [DayType.check, ''],
        }).streak,
        1,
      );
    });

    test('numeric progress at target counts, below target does not', () {
      expect(
        run({
          1: [DayType.progress, '', 30.0, 30.0],
          2: [DayType.progress, '', 10.0, 30.0],
          3: [DayType.progress, '', 31.0, 30.0],
        }, target: 30).streak,
        2,
      );
    });

    test('target stored on the event wins over current target', () {
      expect(
        run({
          1: [DayType.progress, '', 20.0, 20.0],
        }, target: 50).streak,
        1,
      );
    });
  });

  group('computeStreak (two-day rule)', () {
    StreakResult run(Map<int, List> byDay) =>
        computeStreak(_events(byDay), twoDayRule: true, targetValue: 100);

    test('single fail between checks keeps the streak', () {
      final result = run({
        1: [DayType.check, ''],
        2: [DayType.fail, ''],
        3: [DayType.check, ''],
      });
      expect(result.streak, 2);
      expect(result.orange, isFalse);
    });

    test('trailing fail sets orange', () {
      final result = run({
        1: [DayType.check, ''],
        2: [DayType.check, ''],
        3: [DayType.fail, ''],
      });
      expect(result.streak, 2);
      expect(result.orange, isTrue);
    });

    test('two fails in a row end the streak', () {
      expect(
        run({
          1: [DayType.check, ''],
          2: [DayType.fail, ''],
          3: [DayType.fail, ''],
          4: [DayType.check, ''],
        }).streak,
        1,
      );
    });
  });
}
