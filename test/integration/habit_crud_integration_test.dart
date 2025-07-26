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

class TestHabitScreen extends StatelessWidget {
  const TestHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HabitsManager>(
        builder: (context, habitsManager, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: habitsManager.allHabits.length,
                  itemBuilder: (context, index) {
                    final habit = habitsManager.allHabits[index];
                    return ListTile(
                      title: Text(habit.habitData.title),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  habitsManager.addHabit(
                    'Test Habit',
                    false,
                    'Test cue',
                    'Test routine',
                    'Test reward',
                    true,
                    false,
                    false,
                    const TimeOfDay(hour: 8, minute: 0),
                    '',
                    false,
                    'Self',
                  );
                },
                child: const Text('Add Habit'),
              ),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(Habit(
      habitData: HabitData(
        position: 0,
        title: '',
        twoDayRule: false,
        cue: '',
        routine: '',
        reward: '',
        showReward: false,
        advanced: false,
        events: SplayTreeMap<DateTime, List>(),
        notification: false,
        notTime: const TimeOfDay(hour: 0, minute: 0),
        sanction: '',
        showSanction: false,
        accountant: '',
      ),
    ));
  });

  late HabitsManager habitsManager;
  late MockHaboModel mockHaboModel;

  setUp(() {
    mockHaboModel = MockHaboModel();
    habitsManager = HabitsManager(haboModel: mockHaboModel);
    
    when(() => mockHaboModel.insertHabit(any())).thenAnswer((_) async => 1);
    when(() => mockHaboModel.editHabit(any())).thenAnswer((_) async => null);
    when(() => mockHaboModel.deleteHabit(any())).thenAnswer((_) async => null);
  });

  group('Habit CRUD Integration Tests', () {
    testWidgets('habit creation and management', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: habitsManager,
            child: const TestHabitScreen(),
          ),
        ),
      );

      // Test 1: Create a habit
      await tester.tap(find.text('Add Habit'));
      await tester.pumpAndSettle();

      // Verify habit was created
      expect(find.text('Test Habit'), findsOneWidget);
      expect(habitsManager.allHabits.length, 1);
    });

    testWidgets('habit lifecycle simulation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: habitsManager,
            child: const TestHabitScreen(),
          ),
        ),
      );

      // Add multiple habits
      await tester.tap(find.text('Add Habit'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add Habit'));
      await tester.pumpAndSettle();

      // Verify habits were created
      expect(habitsManager.allHabits.length, 2);
      expect(habitsManager.allHabits[0].habitData.title, 'Test Habit');
      expect(habitsManager.allHabits[1].habitData.title, 'Test Habit');
    });
  });
}

// Mock screen for integration testing
class HabitManagementScreen extends StatefulWidget {
  const HabitManagementScreen({super.key});

  @override
  State<HabitManagementScreen> createState() => _HabitManagementScreenState();
}

class _HabitManagementScreenState extends State<HabitManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final habitsManager = context.watch<HabitsManager>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: ListView.builder(
        itemCount: habitsManager.allHabits.length,
        itemBuilder: (context, index) {
          final habit = habitsManager.allHabits[index];
          return ListTile(
            title: Text(habit.habitData.title),
            subtitle: Text('Position: ${habit.habitData.position}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    final habitsManager = context.read<HabitsManager>();
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Habit'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                habitsManager.addHabit(
                  controller.text,
                  false,
                  '',
                  '',
                  '',
                  false,
                  false,
                  false,
                  const TimeOfDay(hour: 9, minute: 0),
                  '',
                  false,
                  '',
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
