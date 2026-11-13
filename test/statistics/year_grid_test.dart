import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/statistics/statistics.dart';
import 'package:habo/statistics/year_grid.dart';

Habit _habit(
  SplayTreeMap<DateTime, List> events, {
  HabitType type = HabitType.boolean,
}) => Habit(
  habitData: HabitData(
    id: 1,
    position: 0,
    title: 'Read',
    twoDayRule: false,
    cue: '',
    routine: '',
    reward: '',
    showReward: false,
    advanced: false,
    notification: false,
    notTime: const TimeOfDay(hour: 9, minute: 0),
    events: events,
    sanction: '',
    showSanction: false,
    accountant: '',
    habitType: type,
    targetValue: 10,
  ),
);

YearGridPainter _painter(
  Map<DateTime, DayType> status,
  Map<DayType, Color> colors,
) => YearGridPainter(
  year: 2026,
  dailyStatus: status,
  colors: colors,
  monthLabels: List.filled(12, 'X'),
  today: DateTime(2026, 6, 15),
  emptyColor: Colors.grey,
  outlineColor: Colors.black,
  labelStyle: const TextStyle(),
  labelWidth: 14,
);

void main() {
  group('Statistics dailyStatus', () {
    test(
      'records each marked day at local midnight, skipping cleared days',
      () async {
        final stats = await Statistics.calculateStatistics([
          _habit(
            SplayTreeMap.of({
              DateTime(2026, 3, 1): [DayType.check, ''],
              DateTime(2026, 3, 2): [DayType.fail, ''],
              DateTime(2026, 3, 3): [DayType.skip, ''],
              DateTime(2026, 3, 4): [DayType.clear, ''],
            }),
          ),
        ]);

        expect(stats.habitsData.single.dailyStatus, {
          DateTime(2026, 3, 1): DayType.check,
          DateTime(2026, 3, 2): DayType.fail,
          DateTime(2026, 3, 3): DayType.skip,
        });
      },
    );

    test(
      'completed numeric progress counts as a check, partial as progress',
      () async {
        final stats = await Statistics.calculateStatistics([
          _habit(
            SplayTreeMap.of({
              DateTime(2026, 3, 1): [DayType.progress, '', 10.0, 10.0],
              DateTime(2026, 3, 2): [DayType.progress, '', 4.0, 10.0],
            }),
            type: HabitType.numeric,
          ),
        ]);

        expect(stats.habitsData.single.dailyStatus, {
          DateTime(2026, 3, 1): DayType.check,
          DateTime(2026, 3, 2): DayType.progress,
        });
      },
    );
  });

  group('YearGridPainter.colorFor', () {
    const check = Color(0xFF00FF00);
    final status = {
      DateTime(2026, 3, 1): DayType.check,
      DateTime(2026, 3, 2): DayType.fail,
    };

    test('uses the status colour when the category is shown', () {
      expect(
        _painter(status, {DayType.check: check}).colorFor(DateTime(2026, 3, 1)),
        check,
      );
    });

    test('draws a hidden category like an unmarked past day', () {
      final painter = _painter(status, {DayType.check: check});
      expect(
        painter.colorFor(DateTime(2026, 3, 2)),
        painter.colorFor(DateTime(2026, 3, 3)),
      );
    });

    test('future days are fainter than unmarked past days', () {
      final painter = _painter(status, {});
      expect(painter.colorFor(DateTime(2026, 3, 3)).a, closeTo(0.28, 0.01));
      expect(painter.colorFor(DateTime(2026, 9, 3)).a, closeTo(0.12, 0.01));
    });
  });

  testWidgets('YearGrid lays out twelve month rows for the given width', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 14 + 31 * 10,
            child: YearGrid(
              year: 2026,
              dailyStatus: const {},
              colors: const {},
              monthLabels: List.filled(12, 'X'),
            ),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(YearGrid)).height, closeTo(120, 0.01));
  });
}
