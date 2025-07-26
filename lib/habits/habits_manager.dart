import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/backup.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:habo/statistics/statistics.dart';

class HabitsManager extends ChangeNotifier {
  late final HaboModel _haboModel;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late List<Habit> allHabits = [];
  bool _isInitialized = false;

  Habit? deletedHabit;
  Queue<Habit> toDelete = Queue();

  HabitsManager({HaboModel? haboModel}) {
    _haboModel = haboModel ?? HaboModel();
  }

  void initialize() async {
    await initModel();
    await Future.delayed(const Duration(seconds: 5));
    notifyListeners();
  }

  resetHabitsNotifications() {
    resetNotifications(allHabits);
  }

  initModel() async {
    await _haboModel.initDatabase();
    allHabits = await _haboModel.getAllHabits();
    _isInitialized = true;
    notifyListeners();
  }

  GlobalKey<ScaffoldMessengerState> get getScaffoldKey {
    return _scaffoldKey;
  }

  void hideSnackBar() {
    _scaffoldKey.currentState!.hideCurrentSnackBar();
  }

  Future<bool> createBackup() async {
    try {
      final file = await Backup.writeBackup(allHabits);
      if (Platform.isAndroid || Platform.isIOS) {
        final params = SaveFileDialogParams(
          sourceFilePath: file.path,
          mimeTypesFilter: ['application/json'],
        );
        await FlutterFileDialog.saveFile(params: params);
      } else {
        final outputFile = await FilePicker.platform.saveFile(
          dialogTitle: '',
          type: FileType.custom,
          allowedExtensions: ['json'],
          fileName: file.path.split('/').last,
        );
        if (outputFile != null) {
          await file.copy(outputFile);
        }
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> loadBackup() async {
    try {
      final String? filePath;
      if (Platform.isAndroid || Platform.isIOS) {
        const params = OpenFileDialogParams(
          fileExtensionsFilter: ['json'],
          mimeTypesFilter: ['application/json'],
        );
        filePath = await FlutterFileDialog.pickFile(params: params);
      } else {
        filePath = (await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
                allowMultiple: false,
                withReadStream: Platform.isLinux))
            ?.files
            .first
            .path;
      }
      if (filePath == null) {
        return true;
      }
      final json = await Backup.readBackup(filePath);
      List<Habit> habits = [];
      jsonDecode(json).forEach((element) {
        habits.add(Habit.fromJson(element));
      });
      await _haboModel.useBackup(habits);
      removeNotifications(allHabits);
      allHabits = habits;
      resetNotifications(allHabits);
      notifyListeners();
    } catch (e) {
      return false;
    }
    return true;
  }

  resetNotifications(List<Habit> habits) {
    if (!platformSupportsNotifications()) return;
    
    // Check existing notifications and habit completion status
    AwesomeNotifications().listScheduledNotifications().then((notifications) {
      final existingIds = notifications.map((n) => n.content?.id).whereType<int>().toSet();
      
      for (var element in habits) {
        if (element.habitData.notification) {
          var data = element.habitData;
          
          // Check if habit is already completed for today
          DateTime today = DateTime.now();
          DateTime todayDate = DateTime(today.year, today.month, today.day);
          bool isCompletedToday = false;
          
          // Check if there's a completed event for today
          data.events.forEach((date, event) {
            if (date.year == todayDate.year && 
                date.month == todayDate.month && 
                date.day == todayDate.day) {
              if (event[0] == DayType.check) {
                isCompletedToday = true;
              }
            }
          });
          
          // Only schedule notification if not completed today
          if (!isCompletedToday && !existingIds.contains(data.id)) {
            setHabitNotification(data.id!, data.notTime, 'Habo', data.title);
          }
        }
      }
    });
  }

  removeNotifications(List<Habit> habits) {
    for (var element in habits) {
      disableHabitNotification(element.habitData.id!);
    }
  }

  showErrorMessage(String message) {
    _scaffoldKey.currentState!.hideCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: HaboColors.red,
      ),
    );
  }

  List<Habit> get getAllHabits {
    return allHabits;
  }

  bool get isInitialized {
    return _isInitialized;
  }

  reorderList(oldIndex, newIndex) {
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
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (eventDate == today && event[0] == DayType.check) {
      rescheduleNotificationForTomorrow(id);
    }
  }

  void deleteEvent(int id, DateTime dateTime) {
    _haboModel.deleteEvent(id, dateTime);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (eventDate == today) {
      rescheduleNotificationForToday(id);
    }
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

  editHabit(HabitData habitData) {
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

  deleteHabit(int id) {
    deletedHabit = findHabitById(id);
    allHabits.remove(deletedHabit);
    toDelete.addLast(deletedHabit!);
    Future.delayed(const Duration(seconds: 4), () => deleteFromDB());
    _scaffoldKey.currentState!.hideCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(S.current.habitDeleted),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: S.current.undo,
          onPressed: () {
            undoDeleteHabit(deletedHabit!);
          },
        ),
      ),
    );
    updateOrder();
    notifyListeners();
  }

  undoDeleteHabit(Habit del) {
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

  updateOrder() {
    int iterator = 0;
    for (var habit in allHabits) {
      habit.habitData.position = iterator++;
    }
  }

  Future<AllStatistics> getFutureStatsData() async {
    return await Statistics.calculateStatistics(allHabits);
  }
}
