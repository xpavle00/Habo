import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/category.dart';
import 'package:habo/repositories/habit_repository.dart';
import 'package:habo/repositories/event_repository.dart';
import 'package:habo/repositories/category_repository.dart';
import 'package:habo/statistics/statistics.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/ui_feedback_service.dart';

class HabitsManager extends ChangeNotifier {
  final HabitRepository _habitRepository;
  final EventRepository _eventRepository;
  final CategoryRepository _categoryRepository;

  // Service dependencies
  final BackupService? _backupService;
  final NotificationService? _notificationService;
  final UIFeedbackService? _uiFeedbackService;

  late List<Habit> allHabits = [];
  late List<Category> allCategories = [];
  bool _isInitialized = false;

  Habit? deletedHabit;
  Queue<Habit> toDelete = Queue();

  /// Creates a new HabitsManager instance with dependency injection.
  ///
  /// [habitRepository] Repository for habit data operations (required)
  /// [eventRepository] Repository for habit event operations (required)
  /// [categoryRepository] Repository for category data operations (required)
  /// [backupService] Service for backup/restore operations (optional)
  /// [notificationService] Service for notification management (optional)
  /// [uiFeedbackService] Service for UI feedback like SnackBars (optional)
  ///
  /// Optional services provide graceful degradation - if not provided,
  /// related functionality will be disabled or use fallback behavior.
  HabitsManager({
    required HabitRepository habitRepository,
    required EventRepository eventRepository,
    required CategoryRepository categoryRepository,
    BackupService? backupService,
    NotificationService? notificationService,
    UIFeedbackService? uiFeedbackService,
  }) : _habitRepository = habitRepository,
       _eventRepository = eventRepository,
       _categoryRepository = categoryRepository,
       _backupService = backupService,
       _notificationService = notificationService,
       _uiFeedbackService = uiFeedbackService;

  Future<void> initialize() async {
    await initModel();
    await loadCategories();
    notifyListeners();
  }

  void resetHabitsNotifications() {
    resetNotifications(allHabits);
  }

  Future<void> initModel() async {
    allHabits = await _habitRepository.getAllHabits();
    _isInitialized = true;
    notifyListeners();
  }



  void hideSnackBar() {
    if (_uiFeedbackService != null) {
      _uiFeedbackService!.hideCurrentMessage();
    }
    // Note: If UIFeedbackService is null, we can't hide the snackbar
    // This is acceptable as the snackbar will auto-dismiss
  }

  Future<bool> createBackup() async {
    if (_backupService != null) {
      return await _backupService!.createDatabaseBackup();
    }
    // Fallback: return false if service not available
    return false;
  }

  Future<bool> loadBackup() async {
    if (_backupService != null) {
      final ok = await _backupService!.restoreFromBackupFile();
      if (ok) {
        // Reload in-memory state from repositories
        allHabits = await _habitRepository.getAllHabits();
        await loadCategories();
        _notificationService?.removeNotifications(allHabits);
        _notificationService?.resetNotifications(allHabits);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void resetNotifications(List<Habit> habits) {
    _notificationService?.resetNotifications(habits);
  }

  void removeNotifications(List<Habit> habits) {
    _notificationService?.removeNotifications(habits);
  }

  void showErrorMessage(String message) {
    if (_uiFeedbackService != null) {
      _uiFeedbackService!.showError(message);
    }
    // Note: If UIFeedbackService is null, we silently fail
    // This should not happen in normal operation since services are injected
  }

  List<Habit> get getAllHabits {
    return allHabits;
  }

  /// Get habits filtered by category (excludes archived habits)
  List<Habit> getHabitsByCategory(Category? category) {
    final activeHabits = allHabits.where((habit) => !habit.habitData.archived).toList();
    
    if (category == null) {
      return activeHabits;
    }
    
    return activeHabits.where((habit) {
      return habit.habitData.categories.any((cat) => cat.id == category.id);
    }).toList();
  }

  bool get isInitialized {
    return _isInitialized;
  }

  void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    Habit moved = allHabits.removeAt(oldIndex);
    allHabits.insert(newIndex, moved);
    updateOrder();
    _habitRepository.updateHabitsOrder(allHabits);
    notifyListeners();
  }

  void addEvent(int id, DateTime dateTime, List event) {
    _eventRepository.insertEvent(id, dateTime, event);
    _notificationService?.handleHabitEventAdded(id, dateTime, event);
  }

  void deleteEvent(int id, DateTime dateTime) {
    _eventRepository.deleteEvent(id, dateTime);
    _notificationService?.handleHabitEventDeleted(id, dateTime);
  }

  void addHabit(
      String title,
      bool twoDayRule,
      String cue,
      String routine,
      String reward,
      bool showReward,
      bool advanced,
      bool notification,
      TimeOfDay notTime,
      String sanction,
      bool showSanction,
      String accountant,
      {HabitType habitType = HabitType.boolean,
      double targetValue = 1.0,
      double partialValue = 1.0,
      String unit = '',
      List<Category> categories = const []}) {
    Habit newHabit = Habit(
      habitData: HabitData(
        position: allHabits.length,
        title: title,
        twoDayRule: twoDayRule,
        cue: cue,
        routine: routine,
        reward: reward,
        showReward: showReward,
        advanced: advanced,
        events: SplayTreeMap<DateTime, List>(),
        notification: notification,
        notTime: notTime,
        sanction: sanction,
        showSanction: showSanction,
        accountant: accountant,
        habitType: habitType,
        targetValue: targetValue,
        partialValue: partialValue,
        unit: unit,
        categories: categories,
      ),
    );
    _habitRepository.createHabit(newHabit).then(
      (id) {
        newHabit.setId = id;
        allHabits.add(newHabit);
        
        // Associate categories with the new habit
        if (categories.isNotEmpty) {
          updateHabitCategories(id, categories);
        }
        
        if (notification) {
          _notificationService?.setHabitNotification(id, notTime, 'Habo', title);
        } else {
          _notificationService?.disableHabitNotification(id);
        }
        notifyListeners();
      },
    );
    updateOrder();
  }

  void editHabit(HabitData habitData) {
    Habit? hab = findHabitById(habitData.id!);
    if (hab == null) return;
    hab.habitData.title = habitData.title;
    hab.habitData.twoDayRule = habitData.twoDayRule;
    hab.habitData.cue = habitData.cue;
    hab.habitData.routine = habitData.routine;
    hab.habitData.reward = habitData.reward;
    hab.habitData.showReward = habitData.showReward;
    hab.habitData.advanced = habitData.advanced;
    hab.habitData.notification = habitData.notification;
    hab.habitData.notTime = habitData.notTime;
    hab.habitData.sanction = habitData.sanction;
    hab.habitData.showSanction = habitData.showSanction;
    hab.habitData.accountant = habitData.accountant;
    hab.habitData.habitType = habitData.habitType;
    hab.habitData.targetValue = habitData.targetValue;
    hab.habitData.partialValue = habitData.partialValue;
    hab.habitData.unit = habitData.unit;
    hab.habitData.categories = habitData.categories;
    hab.habitData.archived = habitData.archived;
    _habitRepository.updateHabit(hab);
    if (habitData.notification) {
      _notificationService?.setHabitNotification(
          habitData.id!, habitData.notTime, 'Habo', habitData.title);
    } else {
      _notificationService?.disableHabitNotification(habitData.id!);
    }
    notifyListeners();
  }

  String getNameOfHabit(int id) {
    Habit? hab = findHabitById(id);
    return (hab != null) ? hab.habitData.title : '';
  }

  Habit? findHabitById(int id) {
    Habit? result;
    for (var hab in allHabits) {
      if (hab.habitData.id == id) {
        result = hab;
      }
    }
    return result;
  }

  void archiveHabit(int id) {
    Habit? habit = findHabitById(id);
    if (habit == null) return;
    
    habit.habitData.archived = true;
    _habitRepository.updateHabit(habit);
    
    // Remove notifications for archived habits
    _notificationService?.disableHabitNotification(id);
    
    if (_uiFeedbackService != null) {
      _uiFeedbackService!.showMessageWithAction(
        message: S.current.habitArchived,
        actionLabel: S.current.undo,
        onActionPressed: () {
          unarchiveHabit(id);
        },
        backgroundColor: Colors.orange,
      );
    }
    
    notifyListeners();
  }

  void unarchiveHabit(int id) {
    Habit? habit = findHabitById(id);
    if (habit == null) return;
    
    habit.habitData.archived = false;
    _habitRepository.updateHabit(habit);
    
    // Restore notifications if enabled
    if (habit.habitData.notification) {
      _notificationService?.setHabitNotification(
          id, habit.habitData.notTime, 'Habo', habit.habitData.title);
    }
    
    if (_uiFeedbackService != null) {
      _uiFeedbackService!.showMessageWithAction(
        message: S.current.habitUnarchived,
        actionLabel: '',
        onActionPressed: () {},
        backgroundColor: Colors.green,
      );
    }
    
    notifyListeners();
  }

  List<Habit> get activeHabits {
    return allHabits.where((habit) => !habit.habitData.archived).toList();
  }

  List<Habit> get archivedHabits {
    return allHabits.where((habit) => habit.habitData.archived).toList();
  }

  void deleteHabit(int id) {
    deletedHabit = findHabitById(id);
    allHabits.remove(deletedHabit);
    toDelete.addLast(deletedHabit!);
    Future.delayed(const Duration(seconds: 4), () => deleteFromDB());
    
    if (_uiFeedbackService != null) {
      _uiFeedbackService!.showMessageWithAction(
        message: S.current.habitDeleted,
        actionLabel: S.current.undo,
        onActionPressed: () {
          undoDeleteHabit(deletedHabit!);
        },
        backgroundColor: Colors.grey,
      );
    }
    
    updateOrder();
    notifyListeners();
  }

  void undoDeleteHabit(Habit del) {
    toDelete.remove(del);
    if (deletedHabit != null) {
      if (deletedHabit!.habitData.position < allHabits.length) {
        allHabits.insert(deletedHabit!.habitData.position, deletedHabit!);
      } else {
        allHabits.add(deletedHabit!);
      }
    }

    updateOrder();
    notifyListeners();
  }

  Future<void> deleteFromDB() async {
    if (toDelete.isNotEmpty) {
      _notificationService?.disableHabitNotification(toDelete.first.habitData.id!);
      await _habitRepository.deleteHabit(toDelete.first.habitData.id!);
      toDelete.removeFirst();
    }
    if (toDelete.isNotEmpty) {
      Future.delayed(const Duration(seconds: 1), () => deleteFromDB());
    }
  }

  void updateOrder() {
    int iterator = 0;
    for (var habit in allHabits) {
      habit.habitData.position = iterator++;
    }
  }

  Future<AllStatistics> getFutureStatsData() async {
    return await Statistics.calculateStatistics(allHabits);
  }

  // Category management methods
  Future<void> loadCategories() async {
    allCategories = await _categoryRepository.getAllCategories();
    notifyListeners();
  }

  Future<void> addCategory(String title, int iconCodePoint) async {
    final category = Category(title: title, iconCodePoint: iconCodePoint);
    final id = await _categoryRepository.createCategory(category);
    category.id = id;
    allCategories.add(category);
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    await _categoryRepository.updateCategory(category);
    // Update the category in the local list
    final index = allCategories.indexWhere((cat) => cat.id == category.id);
    if (index != -1) {
      allCategories[index] = category;
    }
    notifyListeners();
  }

  Future<void> deleteCategory(int categoryId) async {
    await _categoryRepository.deleteCategory(categoryId);
    allCategories.removeWhere((cat) => cat.id == categoryId);
    
    // Update habits to remove the deleted category
    for (var habit in allHabits) {
      habit.habitData.categories.removeWhere((cat) => cat.id == categoryId);
    }
    notifyListeners();
  }

  Future<void> updateHabitCategories(int habitId, List<Category> categories) async {
    await _categoryRepository.updateHabitCategories(habitId, categories);
    
    // Update the habit in memory
    final habit = findHabitById(habitId);
    if (habit != null) {
      habit.habitData.categories = categories;
      notifyListeners();
    }
  }

  Future<List<Category>> getCategoriesForHabit(int habitId) async {
    return await _categoryRepository.getCategoriesForHabit(habitId);
  }
}
