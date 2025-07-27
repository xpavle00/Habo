import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/notifications.dart';
import 'package:habo/statistics/statistics.dart';
import 'package:habo/services/backup_service.dart';
import 'package:habo/services/notification_service.dart';
import 'package:habo/services/ui_feedback_service.dart';

class HabitsManager extends ChangeNotifier {
  late final HaboModel _haboModel;

  // Service dependencies
  final BackupService? _backupService;
  final NotificationService? _notificationService;
  final UIFeedbackService? _uiFeedbackService;

  late List<Habit> allHabits = [];
  bool _isInitialized = false;

  Habit? deletedHabit;
  Queue<Habit> toDelete = Queue();

  HabitsManager({
    HaboModel? haboModel,
    BackupService? backupService,
    NotificationService? notificationService,
    UIFeedbackService? uiFeedbackService,
  }) : _backupService = backupService,
       _notificationService = notificationService,
       _uiFeedbackService = uiFeedbackService {
    _haboModel = haboModel ?? HaboModel();
  }

  void initialize() async {
    await initModel();
    await Future.delayed(const Duration(seconds: 5));
    notifyListeners();
  }

  void resetHabitsNotifications() {
    resetNotifications(allHabits);
  }

  Future<void> initModel() async {
    await _haboModel.initDatabase();
    allHabits = await _haboModel.getAllHabits();
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
      return await _backupService!.createBackup(allHabits);
    }
    // Fallback: return false if service not available
    return false;
  }

  Future<bool> loadBackup() async {
    if (_backupService != null) {
      final result = await _backupService!.loadBackup();
      if (result.success && result.habits != null) {
        await _haboModel.useBackup(result.habits!);
        _notificationService?.removeNotifications(allHabits);
        allHabits = result.habits!;
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
    _haboModel.updateOrder(allHabits);
    notifyListeners();
  }

  void addEvent(int id, DateTime dateTime, List event) {
    _haboModel.insertEvent(id, dateTime, event);
    _notificationService?.handleHabitEventAdded(id, dateTime, event);
  }

  void deleteEvent(int id, DateTime dateTime) {
    _haboModel.deleteEvent(id, dateTime);
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
      String accountant) {
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
      ),
    );
    _haboModel.insertHabit(newHabit).then(
      (id) {
        newHabit.setId = id;
        allHabits.add(newHabit);
        if (notification) {
          setHabitNotification(id, notTime, 'Habo', title);
        } else {
          disableHabitNotification(id);
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
    _haboModel.editHabit(hab);
    if (habitData.notification) {
      setHabitNotification(
          habitData.id!, habitData.notTime, 'Habo', habitData.title);
    } else {
      disableHabitNotification(habitData.id!);
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
      disableHabitNotification(toDelete.first.habitData.id!);
      _haboModel.deleteHabit(toDelete.first.habitData.id!);
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
}
