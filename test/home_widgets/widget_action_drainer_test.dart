import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/home_widgets/widget_action.dart';
import 'package:habo/home_widgets/widget_action_drainer.dart';
import 'package:habo/home_widgets/widget_store.dart';
import 'package:mocktail/mocktail.dart';

import 'fake_widget_store.dart';

class MockHabitsManager extends Mock implements HabitsManager {}

Map<String, Object?> _action(
  int seq,
  String uuid,
  String date, [
  String code = 'c',
]) => {
  'seq': seq,
  'uuid': uuid,
  'date': date,
  'code': code,
  'at': '2026-11-06T21:14:03Z',
};

void main() {
  late FakeWidgetStore store;
  late MockHabitsManager habits;
  late WidgetActionDrainer drainer;

  setUpAll(() {
    registerFallbackValue(
      WidgetAction(seq: 0, uuid: '', date: DateTime(2026), code: 'c'),
    );
  });

  setUp(() {
    store = FakeWidgetStore();
    habits = MockHabitsManager();
    when(() => habits.applyWidgetAction(any())).thenReturn(true);
    drainer = WidgetActionDrainer(store, habits);
  });

  void pending(List<Map<String, Object?>> actions) =>
      store.values[WidgetKeys.pendingActions] = jsonEncode(actions);

  test(
    'applies only actions with seq above applied marker, in seq order',
    () async {
      store.values[WidgetKeys.appliedSeq] = 2;
      pending([
        _action(4, 'b', '2026-11-06'),
        _action(2, 'old', '2026-11-06'),
        _action(3, 'a', '2026-11-06'),
      ]);

      final applied = await drainer.drain();

      expect(applied, 2);
      final calls = verify(
        () => habits.applyWidgetAction(captureAny()),
      ).captured.cast<WidgetAction>();
      expect(calls.map((a) => a.uuid), ['a', 'b']);
    },
  );

  test('applies action on its recorded date', () async {
    pending([_action(1, 'a', '2026-11-05')]);

    await drainer.drain();

    final action =
        verify(() => habits.applyWidgetAction(captureAny())).captured.single
            as WidgetAction;
    expect(action.date, DateTime(2026, 11, 5));
  });

  test('drops action for unknown habit and advances marker', () async {
    when(() => habits.applyWidgetAction(any())).thenReturn(false);
    pending([_action(5, 'gone', '2026-11-06')]);

    final applied = await drainer.drain();

    expect(applied, 0);
    expect(store.values[WidgetKeys.appliedSeq], 5);
  });

  test('writes applied marker as max seq seen', () async {
    pending([_action(7, 'a', '2026-11-06'), _action(9, 'b', '2026-11-06')]);

    await drainer.drain();

    expect(store.values[WidgetKeys.appliedSeq], 9);
  });

  test('never writes the pending action list', () async {
    pending([_action(1, 'a', '2026-11-06')]);

    await drainer.drain();

    expect(store.writes, isNot(contains(WidgetKeys.pendingActions)));
    expect(store.writes, isNot(contains(WidgetKeys.pendingSeq)));
  });

  test('missing list is a no-op', () async {
    expect(await drainer.drain(), 0);
    expect(store.writes, isEmpty);
  });

  test('malformed list is a no-op and does not throw', () async {
    store.values[WidgetKeys.pendingActions] = '{not json';
    expect(await drainer.drain(), 0);
    expect(store.writes, isEmpty);
  });

  test('malformed entry is skipped but valid ones apply', () async {
    store.values[WidgetKeys.pendingActions] = jsonEncode([
      {'seq': 1, 'uuid': 'a'},
      _action(2, 'b', '2026-11-06'),
    ]);

    expect(await drainer.drain(), 1);
    expect(store.values[WidgetKeys.appliedSeq], 2);
  });

  test('never lowers a marker advanced by a concurrent drain', () async {
    final racing = _RacingStore();
    racing.values[WidgetKeys.pendingActions] = jsonEncode([
      _action(1, 'a', '2026-11-06'),
    ]);

    await WidgetActionDrainer(racing, habits).drain();

    expect(racing.values[WidgetKeys.appliedSeq], 9);
  });

  test('passes each tap\'s recorded time on as UTC', () async {
    pending([_action(1, 'a', '2026-11-06')]);

    await drainer.drain();

    final action =
        verify(() => habits.applyWidgetAction(captureAny())).captured.single
            as WidgetAction;
    expect(action.tappedAt, DateTime.utc(2026, 11, 6, 21, 14, 3));
  });

  test('an entry without a tap time still applies', () async {
    pending([
      {'seq': 1, 'uuid': 'a', 'date': '2026-11-06', 'code': 'c'},
    ]);

    await drainer.drain();

    final action =
        verify(() => habits.applyWidgetAction(captureAny())).captured.single
            as WidgetAction;
    expect(action.tappedAt, isNull);
  });

  test('passes the day state the widget showed at tap time', () async {
    pending([
      {..._action(1, 'a', '2026-11-06'), 'from': 'f'},
      {..._action(2, 'a', '2026-11-07'), 'from': 'x'},
      _action(3, 'a', '2026-11-08'),
    ]);

    await drainer.drain();

    final froms = verify(
      () => habits.applyWidgetAction(captureAny()),
    ).captured.map((a) => (a as WidgetAction).from).toList();
    // Unknown codes and missing values both mean "not recorded".
    expect(froms, ['f', null, null]);
  });
}

/// Store whose applied marker is advanced by "another drain" right after
/// the first read.
class _RacingStore extends FakeWidgetStore {
  var _reads = 0;

  @override
  Future<int?> getInt(String key) async {
    if (key == WidgetKeys.appliedSeq && _reads++ == 1) {
      values[key] = 9;
    }
    return super.getInt(key);
  }
}
