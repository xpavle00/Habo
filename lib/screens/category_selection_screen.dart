import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/model/category.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/services/service_locator.dart';
import 'package:provider/provider.dart';

/// Dedicated screen for selecting and managing categories
/// Provides better UX than modal-in-modal approach
class CategorySelectionScreen extends StatefulWidget {
  final List<Category> initialSelectedCategories;
  final Function(List<Category>) onCategoriesChanged;

  const CategorySelectionScreen({
    super.key,
    required this.initialSelectedCategories,
    required this.onCategoriesChanged,
  });

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  late List<Category> _selectedCategories;
  Category? _editingCategory;
  final TextEditingController _editTitleController = TextEditingController();
  IconData _editSelectedIcon = Icons.category;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.initialSelectedCategories);
  }

  @override
  void dispose() {
    _editTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectCategories),
      ),
      body: Consumer<HabitsManager>(
        builder: (context, habitsManager, child) {
          return Column(
            children: [
              // Selected categories summary
              if (_selectedCategories.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).selectedCategories(_selectedCategories.length),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _selectedCategories.map((category) {
                          return Chip(
                            avatar: Icon(
                              category.icon,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            label: Text(category.title),
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () {
                              setState(() {
                                _selectedCategories.remove(category);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],

              // All categories section
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 112,
                  ),
                  children: [
                    // Header with add button
                    Row(
                      children: [
                        Text(
                          S.of(context).allCategories,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Spacer(),
                        FilledButton.icon(
                          onPressed: () =>
                              _startCreatingCategory(habitsManager),
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(S.of(context).addCategory),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Categories list
                    if (habitsManager.allCategories.isEmpty &&
                        _editingCategory == null) ...[
                      _buildEmptyState(),
                    ] else ...[
                      // Show new category editing card at the top if creating
                      if (_editingCategory != null &&
                          _editingCategory!.id == null) ...[
                        _buildEditingCard(_editingCategory!, habitsManager),
                        const SizedBox(height: 8),
                      ],

                      // Show existing categories (sorted alphabetically)
                      ...(habitsManager.allCategories.toList()
                            ..sort((a, b) => a.title
                                .toLowerCase()
                                .compareTo(b.title.toLowerCase())))
                          .map((category) {
                        final isSelected =
                            _selectedCategories.any((c) => c.id == category.id);
                        final isEditing = _editingCategory?.id == category.id;

                        return _buildCategoryCard(
                          category: category,
                          isSelected: isSelected,
                          isEditing: isEditing,
                          habitsManager: habitsManager,
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveAndReturn,
        child: Icon(
          Icons.save,
          semanticLabel: S.of(context).save,
          color: Colors.white,
          size: 35.0,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.category_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).noCategoriesYet,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).createFirstCategory,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required Category category,
    required bool isSelected,
    required bool isEditing,
    required HabitsManager habitsManager,
  }) {
    if (isEditing) {
      return _buildEditingCard(category, habitsManager);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Icon(
            category.icon,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),
        title: Text(
          category.title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _startEditingCategory(category),
              icon: const Icon(Icons.edit, size: 20),
              tooltip: S.of(context).editCategory,
            ),
            Checkbox(
              value: isSelected,
              onChanged: (selected) {
                setState(() {
                  if (selected == true) {
                    _selectedCategories.add(category);
                  } else {
                    _selectedCategories.removeWhere((c) => c.id == category.id);
                  }
                });
              },
            ),
          ],
        ),
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedCategories.removeWhere((c) => c.id == category.id);
            } else {
              _selectedCategories.add(category);
            }
          });
        },
      ),
    );
  }

  Widget _buildEditingCard(Category category, HabitsManager habitsManager) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).editCategory,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _isProcessing
                      ? null
                      : () => _deleteCategory(category, habitsManager),
                  icon: const Icon(Icons.delete, size: 16),
                  label: Text(S.of(context).delete),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Icon and title in one sleek row
            Row(
              children: [
                // Icon selection
                GestureDetector(
                  onTap: _isProcessing ? null : _pickIcon,
                  child: Container(
                    height: 56, // Match TextField height
                    width: 56,  // Square container
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline),
                      borderRadius: BorderRadius.circular(12), // Match TextField border radius
                    ),
                    child: Icon(
                      _editSelectedIcon,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Title input (takes remaining space)
                Expanded(
                  child: TextField(
                    controller: _editTitleController,
                    decoration: InputDecoration(
                      hintText: S.of(context).category,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    enabled: !_isProcessing,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isProcessing ? null : _cancelEditing,
                  child: Text(S.of(context).cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _isProcessing
                      ? null
                      : () => _saveCategory(category, habitsManager),
                  child: _isProcessing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(S.of(context).save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startCreatingCategory(HabitsManager habitsManager) {
    setState(() {
      _editingCategory = Category(
        id: null,
        title: '',
        iconCodePoint: Icons.category.codePoint,
      );
      _editTitleController.text = '';
      _editSelectedIcon = Icons.category;
    });
  }

  void _startEditingCategory(Category category) {
    setState(() {
      _editingCategory = category;
      _editTitleController.text = category.title;
      _editSelectedIcon = category.icon;
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingCategory = null;
      _editTitleController.clear();
      _editSelectedIcon = Icons.category;
    });
  }

  Future<void> _pickIcon() async {
    IconPickerIcon? icon = await showIconPicker(context);

    if (icon != null) {
      setState(() {
        _editSelectedIcon = icon.data;
      });
    }
  }

  Future<void> _saveCategory(
      Category category, HabitsManager habitsManager) async {
    final title = _editTitleController.text.trim();

    if (title.isEmpty) {
      ServiceLocator.instance.uiFeedbackService.showError(S.of(context).pleaseEnterCategoryTitle);
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      if (category.id == null) {
        // Creating new category
        final existingCategory = habitsManager.allCategories
            .where((cat) => cat.title.toLowerCase() == title.toLowerCase())
            .firstOrNull;

        if (existingCategory != null) {
          ServiceLocator.instance.uiFeedbackService.showWarning(S.of(context).categoryAlreadyExists(title));
          setState(() {
            _isProcessing = false;
          });
          return;
        }

        await habitsManager.addCategory(title, _editSelectedIcon.codePoint);

        // Find the newly created category and auto-select it
        final newCategory = habitsManager.allCategories
            .where((cat) => cat.title == title)
            .firstOrNull;

        setState(() {
          if (newCategory != null) {
            _selectedCategories.add(newCategory);
          }
          _editingCategory = null;
          _editTitleController.clear();
          _editSelectedIcon = Icons.category;
        });

        if (!mounted) return;
        ServiceLocator.instance.uiFeedbackService.showSuccess(S.of(context).categoryCreatedSuccessfully(title));
      } else {
        // Updating existing category
        final existingCategory = habitsManager.allCategories
            .where((cat) =>
                cat.title.toLowerCase() == title.toLowerCase() &&
                cat.id != category.id)
            .firstOrNull;

        if (existingCategory != null) {
          ServiceLocator.instance.uiFeedbackService.showWarning(S.of(context).categoryAlreadyExists(title));
          setState(() {
            _isProcessing = false;
          });
          return;
        }

        final updatedCategory = category.copyWith(
          title: title,
          iconCodePoint: _editSelectedIcon.codePoint,
        );

        await habitsManager.updateCategory(updatedCategory);

        // Update selected categories if this category was selected
        setState(() {
          final index =
              _selectedCategories.indexWhere((c) => c.id == category.id);
          if (index != -1) {
            _selectedCategories[index] = updatedCategory;
          }
          _editingCategory = null;
          _editTitleController.clear();
          _editSelectedIcon = Icons.category;
        });

        ServiceLocator.instance.uiFeedbackService.showSuccess(S.of(context).categoryUpdatedSuccessfully(title));
      }
    } catch (e) {
      ServiceLocator.instance.uiFeedbackService.showError(S.of(context).failedToSaveCategory(e.toString()));
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _deleteCategory(
      Category category, HabitsManager habitsManager) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteCategory),
        content: Text(
          S.of(context).deleteCategoryConfirmation(category.title),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(S.of(context).delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      await habitsManager.deleteCategory(category.id!);

      setState(() {
        _selectedCategories.removeWhere((c) => c.id == category.id);
        _editingCategory = null;
        _editTitleController.clear();
        _editSelectedIcon = Icons.category;
      });

      ServiceLocator.instance.uiFeedbackService.showSuccess(S.of(context).categoryDeletedSuccessfully(category.title));
    } catch (e) {
      ServiceLocator.instance.uiFeedbackService.showError(S.of(context).failedToDeleteCategory(e.toString()));
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _saveAndReturn() {
    widget.onCategoriesChanged(_selectedCategories);
    Navigator.of(context).pop(_selectedCategories);
  }
}
