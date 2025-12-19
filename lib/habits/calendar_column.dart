import 'package:flutter/material.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/calendar_header.dart';
import 'package:habo/habits/empty_list_image.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/model/category.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/widgets/category_filter_row.dart';
import 'package:provider/provider.dart';

class CalendarColumn extends StatefulWidget {
  const CalendarColumn({super.key});

  @override
  State<CalendarColumn> createState() => _CalendarColumnState();
}

class _CalendarColumnState extends State<CalendarColumn> {
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final habitsManager = Provider.of<HabitsManager>(context);
    final List<Habit> calendars =
        habitsManager.getHabitsByCategory(selectedCategory);

    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
          child: CalendarHeader(),
        ),
        // Category Filter Row (conditionally shown)
        Consumer<SettingsManager>(
          builder: (context, settingsManager, child) {
            if (!settingsManager.getShowCategories) {
              return const SizedBox.shrink();
            }
            return CategoryFilterRow(
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            );
          },
        ),
        Expanded(
          child: (calendars.isNotEmpty)
              ? RefreshIndicator(
                  onRefresh: () async {
                    await habitsManager.refreshAll();
                  },
                  child: ReorderableListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                    children: calendars
                        .map(
                          (index) => Container(
                            key: ObjectKey(index),
                            child: index,
                          ),
                        )
                        .toList(),
                    onReorder: (oldIndex, newIndex) {
                      // Need to handle reordering with filtered list
                      final allHabits = habitsManager.getAllHabits;
                      final oldHabit = calendars[oldIndex];

                      // Find the actual indices in the full list
                      final actualOldIndex = allHabits.indexOf(oldHabit);
                      int actualNewIndex;

                      // Handle the case where newIndex is out of bounds (moving to last position)
                      if (newIndex >= calendars.length) {
                        // Moving to the end of the filtered list means moving to the position
                        // after the last habit in this category within the full list
                        actualNewIndex = allHabits.length;
                      } else {
                        final newHabit = calendars[newIndex];
                        actualNewIndex = allHabits.indexOf(newHabit);
                      }

                      Provider.of<HabitsManager>(context, listen: false)
                          .reorderList(actualOldIndex, actualNewIndex);
                    },
                  ),
                )
              : _buildEmptyState(),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    if (selectedCategory != null) {
      // Show message when no habits in selected category
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).noHabitsInCategory(selectedCategory!.title),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).createHabitForCategory,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      // Show default empty state
      return const EmptyListImage();
    }
  }
}
