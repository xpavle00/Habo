import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/repositories/habit_repository.dart';
import 'package:habo/repositories/event_repository.dart';
import 'package:habo/repositories/category_repository.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/ui_feedback_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockHabitRepository extends Mock implements HabitRepository {}
class MockEventRepository extends Mock implements EventRepository {}
class MockCategoryRepository extends Mock implements CategoryRepository {}
class MockBackupService extends Mock implements BackupService {}
class MockNotificationService extends Mock implements NotificationService {}
class MockUIFeedbackService extends Mock implements UIFeedbackService {}

void main() {
  late HabitsManager habitsManager;
  late MockHabitRepository mockHabitRepository;
  late Habit testHabit;

  setUp(() {
    mockHabitRepository = MockHabitRepository();
    habitsManager = HabitsManager(
      habitRepository: MockHabitRepository(),
      eventRepository: MockEventRepository(),
      categoryRepository: MockCategoryRepository(),
      backupService: MockBackupService(),
      notificationService: MockNotificationService(),
      uiFeedbackService: MockUIFeedbackService(),
    );
    
    testHabit = Habit(
      habitData: HabitData(
        position: 0,
        title: 'Test Habit',
        twoDayRule: true,
        cue: 'Morning alarm',
        routine: '10 push-ups',
        reward: 'Feel energized',
        showReward: true,
        advanced: true,
        events: SplayTreeMap<DateTime, List>(),
        notification: true,
        notTime: const TimeOfDay(hour: 8, minute: 0),
        sanction: 'No coffee',
        showSanction: true,
        accountant: 'Self',
      ),
    );
    testHabit.setId = 1;
  });

  group('HabitDetailsWidget Tests', () {
    testWidgets('should display habit details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: habitsManager,
            child: Scaffold(
              body: HabitDetailsWidget(habit: testHabit),
            ),
          ),
        ),
      );

      // Verify habit title is displayed
      expect(find.text('Test Habit'), findsOneWidget);
      
      // Verify cue is displayed
      expect(find.text('Morning alarm'), findsOneWidget);
      
      // Verify routine is displayed
      expect(find.text('10 push-ups'), findsOneWidget);
      
      // Verify reward is displayed
      expect(find.text('Feel energized'), findsOneWidget);
      
      // Verify two-day rule indicator
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('should handle edit button tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: habitsManager,
            child: Scaffold(
              body: HabitDetailsWidget(habit: testHabit),
            ),
          ),
        ),
      );

      // Tap edit button
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      // Verify edit dialog appears
      expect(find.text('Edit Habit'), findsOneWidget);
    });

    testWidgets('should handle delete button tap', (WidgetTester tester) async {
      when(() => mockHabitRepository.deleteHabit(any())).thenAnswer((_) async => null);
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: habitsManager,
            child: Scaffold(
              body: HabitDetailsWidget(habit: testHabit),
            ),
          ),
        ),
      );

      // Tap delete button
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // Verify confirmation dialog appears
      expect(find.text('Delete Habit'), findsOneWidget);
    });
  });
}

class HabitDetailsWidget extends StatelessWidget {
  final Habit habit;
  
  const HabitDetailsWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(habit.habitData.title),
            subtitle: Text('Habit Details'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditDialog(context),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteDialog(context),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: const Text('Cue'),
            subtitle: Text(habit.habitData.cue),
          ),
          ListTile(
            leading: const Icon(Icons.repeat),
            title: const Text('Routine'),
            subtitle: Text(habit.habitData.routine),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Reward'),
            subtitle: Text(habit.habitData.reward),
          ),
          if (habit.habitData.twoDayRule)
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Two-Day Rule'),
              subtitle: const Text('Enabled'),
            ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Habit'),
        content: const Text('Edit habit details'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
