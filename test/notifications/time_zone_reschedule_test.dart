import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/notifications.dart';

void main() {
  group('scheduleForTimeZone', () {
    test('returns null when schedule is already in the current zone', () {
      final schedule = NotificationCalendar(
        hour: 15,
        minute: 0,
        repeats: true,
        timeZone: 'Europe/Prague',
      );

      expect(scheduleForTimeZone(schedule, 'Europe/Prague'), isNull);
    });

    test('returns null for non-calendar schedules', () {
      final schedule = NotificationInterval(
        interval: const Duration(minutes: 5),
        timeZone: 'Europe/Prague',
      );

      expect(scheduleForTimeZone(schedule, 'America/New_York'), isNull);
    });

    test('returns null for a missing schedule', () {
      expect(scheduleForTimeZone(null, 'America/New_York'), isNull);
    });

    test('keeps wall-clock time and moves it to the new zone', () {
      final schedule = NotificationCalendar(
        hour: 15,
        minute: 30,
        repeats: true,
        preciseAlarm: true,
        timeZone: 'Europe/Prague',
      );

      final updated = scheduleForTimeZone(schedule, 'America/New_York');

      expect(updated, isNotNull);
      expect(updated!.hour, 15);
      expect(updated.minute, 30);
      expect(updated.second, 0);
      expect(updated.repeats, isTrue);
      expect(updated.preciseAlarm, isTrue);
      expect(updated.timeZone, 'America/New_York');
      expect(updated.year, isNull);
      expect(updated.day, isNull);
    });

    test('preserves a start date (habit already done today)', () {
      final schedule = NotificationCalendar(
        year: 2026,
        month: 11,
        day: 15,
        hour: 9,
        minute: 0,
        repeats: true,
        timeZone: 'Europe/Prague',
      );

      final updated = scheduleForTimeZone(schedule, 'Asia/Tokyo');

      expect(updated, isNotNull);
      expect(updated!.year, 2026);
      expect(updated.month, 11);
      expect(updated.day, 15);
      expect(updated.hour, 9);
      expect(updated.timeZone, 'Asia/Tokyo');
    });
  });
}
