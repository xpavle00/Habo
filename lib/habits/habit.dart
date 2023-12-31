import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constant_helpers/constants.dart';
import '../constant_helpers/helpers.dart';
import '../model/habit_data.dart';
import '../navigation/app_state_manager.dart';
import '../settings/settings_manager.dart';
import 'habit_header.dart';
import 'one_day_button.dart';

class Habit extends StatefulWidget {
  const Habit({super.key, required this.habitData});

  final HabitData habitData;
  set setId(int input) {
    habitData.id = input;
  }
  Map<String, dynamic> toMap() {
    return {
      "id": habitData.id,
      "title": habitData.title,
      "position": habitData.position,
      "cue": habitData.cue,
      "routine": habitData.routine,
      "reward": habitData.reward,
      "showReward": habitData.showReward ? 1 : 0,
      "advanced": habitData.advanced ? 1 : 0,
      "notification": habitData.notification ? 1 : 0,
      "notTime": "${habitData.notTime.hour}:${habitData.notTime.minute}",
      "sanction": habitData.sanction,
      "showSanction": habitData.showSanction ? 1 : 0,
      "accountant": habitData.accountant,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": habitData.id,
      "title": habitData.title,
      "position": habitData.position,
      "cue": habitData.cue,
      "routine": habitData.routine,
      "reward": habitData.reward,
      "showReward": habitData.showReward ? 1 : 0,
      "advanced": habitData.advanced ? 1 : 0,
      "notification": habitData.notification ? 1 : 0,
      "notTime": "${habitData.notTime.hour}:${habitData.notTime.minute}",
      "events": habitData.events.map((key, value) {
        return MapEntry(key.toString(), [value[0].toString(), value[1]]);
      }),
      "sanction": habitData.sanction,
      "showSanction": habitData.showSanction ? 1 : 0,
      "accountant": habitData.accountant,
    };
  }

  Habit.fromJson(Map<String, dynamic> json, {super.key})
      : habitData = HabitData(
          id: json['id'],
          position: json['position'],
          title: json['title'],
          cue: json['cue'],
          routine: json['routine'],
          reward: json['reward'],
          showReward: json['showReward'] != 0 ? true : false,
          advanced: json['advanced'] != 0 ? true : false,
          notification: json['notification'] != 0 ? true : false,
          notTime: parseTimeOfDay(json['notTime']),
          events: doEvents(json['events']),
          sanction: json['sanction'] ?? "",
          showSanction: (json['showSanction'] ?? 0) != 0 ? true : false,
          accountant: json['accountant'] ?? "",
        );

  static SplayTreeMap<DateTime, List> doEvents(Map<String, dynamic> input) {
    SplayTreeMap<DateTime, List> result = SplayTreeMap<DateTime, List>();

    input.forEach((key, value) {
      result[DateTime.parse(key)] = [
        DayType.values.firstWhere((e) => e.toString() == reformatOld(value[0])),
        value[1]
      ];
    });
    return result;
  }

  // To be compatible with older version backup
  static String reformatOld(String value) {
    var all = value.split('.');
    return "${all[0]}.${all[1].toLowerCase()}";
  }

  void navigateToEditPage(context) {
    Provider.of<AppStateManager>(context, listen: false).goEditHabit(habitData);
  }

  @override
  State<Habit> createState() => HabitState();
}

class HabitState extends State<Habit> {
  final bool _orangeStreak = false;
  final bool _streakVisible = false;
  final bool _showMonth = false;
  final String _actualMonth = "";
  DateTime _selectedDay = DateTime.now();

  void refresh() {
    setState(() {
      // _updateLastStreak();
    });
  }

  @override
  void initState() {
    super.initState();
    // _updateLastStreak();
  }

  @override
  void dispose() {
    super.dispose();
  }

  SplayTreeMap<DateTime, List> get events {
    return widget.habitData.events;
  }

  showRewardNotification(date) {
    if (isSameDay(date, DateTime.now()) &&
        widget.habitData.showReward &&
        widget.habitData.reward != "") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            "Congratulation! Your reward:\n${widget.habitData.reward}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  showSanctionNotification(date) {
    if (isSameDay(date, DateTime.now()) &&
        widget.habitData.showSanction &&
        widget.habitData.sanction != "") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            "Oh no! Your sanction:\n${widget.habitData.sanction}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor:
              Provider.of<SettingsManager>(context, listen: false).failColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }



  setSelectedDay(DateTime selectedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        //reloadMonth(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 6, 18, 6),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HabitHeader(
                  widget: widget,
                  streakVisible: false,
                  orangeStreak: _orangeStreak,
                ),
                if (_showMonth &&
                    Provider.of<SettingsManager>(context).getShowMonthName)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(_actualMonth),
                  ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 5.0,
                                crossAxisSpacing: 4.0),
                        itemCount: 40,
                        itemBuilder: (context, index) {
                          int value = index + 1;
                          DateTime date = DateTime.now()
                              .subtract(Duration(days: 40 - index));
                          return SizedBox(
                            height: 40,
                            width: 40,
                            child: OneDayButton(
                                date: date,
                                id: widget.habitData.id!,
                                parent: this,
                                callback: refresh,
                                event:
                                widget.habitData.events[transformDate(date)],
                              value: value,),
                          );
                        })),
              ])),
    );
  }
}
