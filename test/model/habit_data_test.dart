import 'package:flutter_test/flutter_test.dart';
import 'package:habo/constants.dart';
import 'package:habo/model/habit_data.dart';

void main() {
  group('HabitData.isEventCompleted', () {
    test('boolean check event is completed', () {
      expect(HabitData.isEventCompleted([DayType.check]), isTrue);
      expect(HabitData.isEventCompleted([DayType.check, 'note']), isTrue);
    });

    test('numeric progress reaching or exceeding the target is completed', () {
      // [DayType.progress, comment, value, target]
      expect(
        HabitData.isEventCompleted([DayType.progress, '', 8.0, 8.0]),
        isTrue,
      );
      expect(
        HabitData.isEventCompleted([DayType.progress, '', 25.0, 20.0]),
        isTrue,
      );
    });

    test('numeric progress below the target is not completed', () {
      expect(
        HabitData.isEventCompleted([DayType.progress, '', 5.0, 8.0]),
        isFalse,
      );
    });

    test('progress event without a stored target is not completed', () {
      // Legacy/partial event missing the target at index 3.
      expect(HabitData.isEventCompleted([DayType.progress, '', 5.0]), isFalse);
    });

    test('zero target is not treated as completed', () {
      expect(
        HabitData.isEventCompleted([DayType.progress, '', 0.0, 0.0]),
        isFalse,
      );
    });

    test('non-completing day types are not completed', () {
      expect(HabitData.isEventCompleted([DayType.fail]), isFalse);
      expect(HabitData.isEventCompleted([DayType.skip]), isFalse);
      expect(HabitData.isEventCompleted([DayType.clear]), isFalse);
    });

    test('empty event is not completed', () {
      expect(HabitData.isEventCompleted([]), isFalse);
    });
  });
}
