import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/habo_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockHaboModel extends Mock implements HaboModel {}

void main() {
  late HabitsManager habitsManager;
  late MockHaboModel mockHaboModel;

  setUp(() {
    mockHaboModel = MockHaboModel();
    habitsManager = HabitsManager(haboModel: mockHaboModel);
  });

  group('HabitListWidget Tests', () {
    testWidgets('should display empty state when no habits', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: habitsManager,
            child: const Scaffold(
              body: HabitListWidget(),
            ),
          ),
        ),
      );

      // Verify empty state is displayed
      expect(find.text('No habits yet'), findsOneWidget);
      expect(find.byType(HabitCard), findsNothing);
    });

    testWidgets('should display habits when available', (WidgetTester tester) async {
      // Add test habits
      final testHabit1 = Habit(
        habitData: HabitData(
          position: 0,
          title: 'Test Habit 1',
          twoDayRule: false,
          cue: 'Cue 1',
          routine: 'Routine 1',
          reward: 'Reward 1',
          showReward: true,
          advanced: false,
          events: SplayTreeMap<DateTime, List>(),
          notification: false,
          notTime: const TimeOfDay(hour: 9, minute: 0),
          sanction: '',
          showSanction: false,
          accountant: '',
        ),
      );
      testHabit1.setId = 1;

      habitsManager.allHabits.add(testHabit1);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: habitsManager,
            child: const Scaffold(
              body: HabitListWidget(),
            ),
          ),
        ),
      );

      // Verify habits are displayed
      expect(find.text('Test Habit 1'), findsOneWidget);
      expect(find.byType(HabitCard), findsOneWidget);
    });
  });
}

// Mock widget classes for testing
class HabitListWidget extends StatelessWidget {
  const HabitListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final habitsManager = context.watch<HabitsManager>();
    
    if (habitsManager.allHabits.isEmpty) {
      return const Center(child: Text('No habits yet'));
    }
    
    return ListView.builder(
      itemCount: habitsManager.allHabits.length,
      itemBuilder: (context, index) {
        final habit = habitsManager.allHabits[index];
        return HabitCard(habit: habit);
      },
    );
  }
}

class HabitCard extends StatelessWidget {
  final Habit habit;
  
  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(habit.habitData.title),
        subtitle: Text(habit.habitData.cue),
      ),
    );
  }
}
