import 'dart:async';
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
import 'package:habo/services/sync_manager.dart';
import 'package:habo/services/ui_feedback_service.dart';
import 'package:habo/services/home_widget_service.dart';
import 'package:habo/helpers.dart';
import 'package:habo/home_widgets/widget_action.dart';
import 'package:habo/home_widgets/widget_publisher.dart';
import 'package:habo/home_widgets/widget_snapshot_builder.dart';

class HabitsManager extends ChangeNotifier {
  final HabitRepository _habitRepository;
  final EventRepository _eventRepository;
  final CategoryRepository _categoryRepository;

  // Service dependencies
  final BackupService? _backupService;
  final NotificationService? _notificationService;
  final UIFeedbackService? _uiFeedbackService;
  final SyncManager? _syncManager;
  final WidgetPublisher? _widgetPublisher;

  StreamSubscription<void>? _syncDataChangedSubscription;

  late List<Habit> allHabits = [];
  late List<Category> allCategories = [];
  bool _isInitialized = false;
  DateTime _lastUpdateDate = DateTime.now();

  // Store context for widget updates

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
    SyncManager? syncManager,
    WidgetPublisher? widgetPublisher,
  }) : _habitRepository = habitRepository,
       _eventRepository = eventRepository,
       _categoryRepository = categoryRepository,
       _backupService = backupService,
       _notificationService = notificationService,
       _uiFeedbackService = uiFeedbackService,
       _syncManager = syncManager,
       _widgetPublisher = widgetPublisher;

  Future<void> initialize() async {
    // Listen for remote sync changes before loading, so a background pull
    // finishing mid-init isn't missed; reload is deferred until init is done
    bool initializing = true;
    bool reloadPending = false;
    _syncDataChangedSubscription = _syncManager?.onDataChanged.listen((_) {
      if (initializing) {
        reloadPending = true;
      } else {
        reloadFromDatabase();
      }
    });

    await initModel();
    await loadCategories();
    await HomeWidgetService.initialize();

    initializing = false;
    if (reloadPending) {
      await reloadFromDatabase();
    } else {
      notifyListeners();
    }
  }

  Future<void> reloadFromDatabase() async {
    allHabits = await _habitRepository.getAllHabits();
    await loadCategories();
    _notificationService?.removeNotifications(allHabits);
    _notificationService?.resetNotifications(allHabits);
    notifyListeners();
    _updateHomeWidgetAsync();
  }

  void resetHabitsNotifications() {
    resetNotifications(allHabits);
  }

  @override
  void dispose() {
    _syncDataChangedSubscription?.cancel();
    super.dispose();
  }

  Future<void> initModel() async {
    allHabits = await _habitRepository.getAllHabits();
    _isInitialized = true;
    notifyListeners();
  }

  void hideSnackBar() {
    if (_uiFeedbackService != null) {
      _uiFeedbackService.hideCurrentMessage();
    }
    // Note: If UIFeedbackService is null, we can't hide the snackbar
    // This is acceptable as the snackbar will auto-dismiss
  }

  Future<bool> createBackup() async {
    if (_backupService != null) {
      return await _backupService.createDatabaseBackup();
    }
    // Fallback: return false if service not available
    return false;
  }

  Future<bool> loadBackup() async {
    if (_backupService != null) {
      final ok = await _backupService.restoreFromBackupFile();
      if (ok) {
        // Reload in-memory state from repositories
        await reloadFromDatabase();
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
      _uiFeedbackService.showError(message);
    }
    // Note: If UIFeedbackService is null, we silently fail
    // This should not happen in normal operation since services are injected
  }

  List<Habit> get getAllHabits {
    return allHabits;
  }

  /// Get habits filtered by category (excludes archived habits)
  List<Habit> getHabitsByCategory(Category? category) {
    final activeHabits = allHabits
        .where((habit) => !habit.habitData.archived)
        .toList();

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
    _updateHomeWidgetAsync();
    // Trigger sync
    _syncManager?.scheduleSync();
  }

  /// [changedAt] is when the user made the change (defaults to now). It
  /// becomes the habit's LWW timestamp, so a widget tap applied later than
  /// it was made doesn't outrank newer edits from other devices.
  void addEvent(int id, DateTime dateTime, List event, {DateTime? changedAt}) {
    // Keep the in-memory habit current before publishing: the widget
    // snapshot is built from it, and callers update their own copy only
    // after this returns.
    _touchInMemory(id, changedAt)?.events[dateTime] = event;
    _eventRepository.insertEvent(id, dateTime, event, changedAt: changedAt);
    _notificationService?.handleHabitEventAdded(id, dateTime, event);
    // Update home widget after event is added
    _updateHomeWidgetAsync();
    // Trigger sync
    _syncManager?.scheduleSync();
  }

  void deleteEvent(int id, DateTime dateTime, {DateTime? changedAt}) {
    _touchInMemory(id, changedAt)?.events.remove(dateTime);
    _eventRepository.deleteEvent(id, dateTime, changedAt: changedAt);
    _notificationService?.handleHabitEventDeleted(id, dateTime);
    // Update home widget after event is deleted
    _updateHomeWidgetAsync();
    // Trigger sync
    _syncManager?.scheduleSync();
  }

  /// The in-memory habit [id], with `updatedAt` set as the database row's
  /// will be.
  HabitData? _touchInMemory(int id, DateTime? changedAt) {
    final data = findHabitById(id)?.habitData;
    data?.updatedAt = (changedAt ?? DateTime.now()).toUtc();
    return data;
  }

  /// Applies a tap recorded by a native home-screen widget.
  ///
  /// Mirrors what `OneDayButton` does for the same action in the app, so
  /// notifications, sync and widget refresh behave identically. The change
  /// is dated when the tap was made.
  ///
  /// Sync is last-write-wins per habit, so if the habit changed after the
  /// tap (e.g. another day edited on another device and synced in), the tap
  /// is still applied but dated now, so the merged habit wins. It is
  /// dropped only when that same day no longer shows what the widget showed
  /// at tap time, i.e. the day itself was changed elsewhere afterwards.
  /// Returns false when the tap isn't applied.
  bool applyWidgetAction(WidgetAction action) {
    final index = allHabits.indexWhere((h) => h.habitData.uuid == action.uuid);
    if (index < 0) return false;
    final data = allHabits[index].habitData;
    final id = data.id;
    if (id == null) return false;
    final key = transformDate(action.date);
    final existing = data.events[key];

    final tappedAt = action.tappedAt;
    final changedSinceTap =
        tappedAt != null && data.updatedAt.isAfter(tappedAt);
    if (changedSinceTap) {
      final dayNow = existing == null
          ? '.'
          : widgetDayCode(existing, data.targetValue);
      // Without `from` (older widget builds) the day can't be compared, so
      // keep the newer edit.
      if (action.from == null || action.from != dayNow) return false;
    }
    final changedAt = changedSinceTap ? null : tappedAt;
    final comment = (existing != null && existing.length > 1)
        ? (existing[1] as String? ?? '')
        : '';

    switch (action.code) {
      case 'c':
        addEvent(id, key, [DayType.check, comment], changedAt: changedAt);
      case '.':
        if (comment.isNotEmpty) {
          addEvent(id, key, [DayType.clear, comment], changedAt: changedAt);
          // Keeping the comment means an event stays; restore the day's
          // reminder as an undo without a comment does.
          _notificationService?.handleHabitEventDeleted(id, key);
        } else {
          deleteEvent(id, key, changedAt: changedAt);
        }
      case 'p':
      case 'P':
        addEvent(id, key, [
          DayType.progress,
          comment,
          action.value ?? 0.0,
          action.target ?? data.targetValue,
        ], changedAt: changedAt);
      default:
        return false;
    }
    // Rows are reused widget instances that Flutter won't rebuild on their
    // own; a fresh instance makes the home screen show the tap.
    allHabits[index] = Habit(key: UniqueKey(), habitData: data);
    notifyListeners();
    return true;
  }

  /// Updates the home widget with current habit data.
  /// This is called automatically when habits change.
  void _updateHomeWidgetAsync() {
    // Every native widget (iOS and Android) draws from the shared snapshot.
    _widgetPublisher?.publish([for (final h in allHabits) h.habitData]);
  }

  /// Republishes home-screen widget data, e.g. after a setting they show
  /// (such as week start) changed.
  void refreshWidgets() => _updateHomeWidgetAsync();

  /// Applies taps queued by home-screen widgets, then republishes the
  /// widget snapshot. Call on launch, on resume and when the day changes.
  Future<void> drainWidgetActions() async {
    await _widgetPublisher?.drainAndPublish(this);
  }

  Future<void> addHabit(
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
    String accountant, {
    HabitType habitType = HabitType.boolean,
    double targetValue = 1.0,
    double partialValue = 1.0,
    String unit = '',
    List<Category> categories = const [],
  }) async {
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
    final id = await _habitRepository.createHabit(newHabit);
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
    updateOrder();
    notifyListeners();
    _updateHomeWidgetAsync();
    _syncManager?.scheduleSync();
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
        habitData.id!,
        habitData.notTime,
        'Habo',
        habitData.title,
      );
    } else {
      _notificationService?.disableHabitNotification(habitData.id!);
    }
    notifyListeners();
    // Title, target or reminder may have changed: widgets must not act on
    // stale habit data.
    _updateHomeWidgetAsync();
    // Trigger sync
    _syncManager?.scheduleSync();
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
      _uiFeedbackService.showMessageWithAction(
        message: S.current.habitArchived,
        actionLabel: S.current.undo,
        onActionPressed: () {
          unarchiveHabit(id);
        },
        backgroundColor: Colors.orange,
      );
    }

    notifyListeners();
    _updateHomeWidgetAsync();
    // Trigger sync
    _syncManager?.scheduleSync();
  }

  void unarchiveHabit(int id) {
    Habit? habit = findHabitById(id);
    if (habit == null) return;

    habit.habitData.archived = false;
    _habitRepository.updateHabit(habit);

    // Restore notifications if enabled
    if (habit.habitData.notification) {
      _notificationService?.setHabitNotification(
        id,
        habit.habitData.notTime,
        'Habo',
        habit.habitData.title,
      );
    }

    if (_uiFeedbackService != null) {
      _uiFeedbackService.showSuccess(S.current.habitUnarchived);
    }

    notifyListeners();
    _updateHomeWidgetAsync();
    // Trigger sync
    _syncManager?.scheduleSync();
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
      _uiFeedbackService.showMessageWithAction(
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
    _updateHomeWidgetAsync();
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
    _updateHomeWidgetAsync();
  }

  Future<void> deleteFromDB() async {
    if (toDelete.isNotEmpty) {
      _notificationService?.disableHabitNotification(
        toDelete.first.habitData.id!,
      );
      await _habitRepository.deleteHabit(toDelete.first.habitData.id!);
      toDelete.removeFirst();
      // Trigger sync after DB deletion
      _syncManager?.scheduleSync();
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

  Future<void> addCategory(
    String title,
    int iconCodePoint, [
    String? fontFamily,
  ]) async {
    final category = Category(
      title: title,
      iconCodePoint: iconCodePoint,
      fontFamily: fontFamily,
    );
    final id = await _categoryRepository.createCategory(category);
    category.id = id;
    allCategories.add(category);
    notifyListeners();
    // Trigger sync
    _syncManager?.scheduleSync();
  }

  Future<void> updateCategory(Category category) async {
    await _categoryRepository.updateCategory(category);
    // Update the category in the local list
    final index = allCategories.indexWhere((cat) => cat.id == category.id);
    if (index != -1) {
      allCategories[index] = category;
    }
    notifyListeners();
    _syncManager?.scheduleSync();
  }

  Future<void> deleteCategory(int categoryId) async {
    await _categoryRepository.deleteCategory(categoryId);
    allCategories.removeWhere((cat) => cat.id == categoryId);

    // Update habits to remove the deleted category
    for (var habit in allHabits) {
      habit.habitData.categories.removeWhere((cat) => cat.id == categoryId);
    }
    notifyListeners();
    // Trigger sync
    _syncManager?.scheduleSync();
  }

  Future<void> updateHabitCategories(
    int habitId,
    List<Category> categories,
  ) async {
    await _categoryRepository.updateHabitCategories(habitId, categories);

    // Update the habit in memory
    final habit = findHabitById(habitId);
    if (habit != null) {
      habit.habitData.categories = categories;
      notifyListeners();
      // Trigger sync
      _syncManager?.scheduleSync();
    }
  }

  Future<List<Category>> getCategoriesForHabit(int habitId) async {
    return await _categoryRepository.getCategoriesForHabit(habitId);
  }

  void checkDayChange() {
    final now = DateTime.now();
    if (now.day != _lastUpdateDate.day ||
        now.month != _lastUpdateDate.month ||
        now.year != _lastUpdateDate.year) {
      _lastUpdateDate = now;
      _reloadHabits();
      notifyListeners();
      _updateHomeWidgetAsync();
    }
  }

  Future<void> refreshAll() async {
    _reloadHabits();
    notifyListeners();
    _updateHomeWidgetAsync();
  }

  void _reloadHabits() {
    for (int i = 0; i < allHabits.length; i++) {
      allHabits[i] = Habit(key: UniqueKey(), habitData: allHabits[i].habitData);
    }
  }
}
