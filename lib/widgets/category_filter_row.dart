import 'package:flutter/material.dart';
import 'package:habo/model/category.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';

/// Horizontal scrollable row of category filter chips
class CategoryFilterRow extends StatelessWidget {
  final Category? selectedCategory;
  final Function(Category?) onCategorySelected;

  const CategoryFilterRow({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    // Listen to both HabitsManager (data changes) and SettingsManager (theme changes)
    // so this row rebuilds when theme is updated from settings.
    return Consumer2<HabitsManager, SettingsManager>(
      builder: (context, habitsManager, settingsManager, child) {
        if (habitsManager.allCategories.isEmpty) {
          return const SizedBox.shrink();
        }

        // Build a key signature derived from current theme to force remount on any theme change
        final theme = Theme.of(context);
        final themeSig =
            '${theme.brightness.index}-${theme.colorScheme.primary.toARGB32()}-${theme.scaffoldBackgroundColor.toARGB32()}-${theme.colorScheme.primaryContainer.toARGB32()}-${theme.colorScheme.outline.toARGB32()}';

        return Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ListView.builder(
            key: ValueKey('cat-row-$themeSig'),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
                left: 16, right: 24), // Extra right padding
            itemCount:
                habitsManager.allCategories.length + 1, // +1 for "All" chip
            itemBuilder: (context, index) {
              if (index == 0) {
                // "All" chip to show all habits
                final isSelected = selectedCategory == null;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    key: ValueKey('all-chip-$themeSig'),
                    label: Text(
                      'All',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onPrimary.withAlpha(150),
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        onCategorySelected(null);
                      }
                    },
                    // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    // selectedColor:
                    //     Theme.of(context).colorScheme.primaryContainer,
                    side: BorderSide(
                      color: isSelected
                          ? Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.3)
                          : Colors.transparent,
                      width: 1,
                    ),
                    showCheckmark: false,
                  ),
                );
              }

              final category = habitsManager.allCategories[index - 1];
              final isSelected = selectedCategory?.id == category.id;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  key: ValueKey('cat-${category.id}-$themeSig'),
                  label: Text(
                    category.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onPrimary.withAlpha(150),
                    ),
                  ),
                  avatar: Icon(
                    category.icon,
                    size: 18,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onPrimary.withAlpha(150),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      onCategorySelected(category);
                    } else {
                      onCategorySelected(null);
                    }
                  },
                  side: BorderSide(
                    color: isSelected
                        ? theme.colorScheme.outline.withValues(alpha: 0.3)
                        : Colors.transparent,
                    width: 1,
                  ),
                  showCheckmark: false,
                  // pressElevation: 4,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
