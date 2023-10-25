import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/habit_header.dart';
import 'package:habo/habits/one_day.dart';
import 'package:habo/habits/one_day_button.dart';
import 'package:habo/helpers.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:habo/extensions.dart';

class Habit extends StatefulWidget {
  const Habit({super.key, required this.habitData});

  final HabitData habitData;

  set setId(int input) {
    habitData.id = input;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': habitData.id,
      'title': habitData.title,
      'twoDayRule': habitData.twoDayRule ? 1 : 0,
      'position': habitData.position,
      'cue': habitData.cue,
      'routine': habitData.routine,
      'reward': habitData.reward,
      'showReward': habitData.showReward ? 1 : 0,
      'advanced': habitData.advanced ? 1 : 0,
      'notification': habitData.notification ? 1 : 0,
      'notTime': '${habitData.notTime.hour}:${habitData.notTime.minute}',
      'sanction': habitData.sanction,
      'showSanction': habitData.showSanction ? 1 : 0,
      'accountant': habitData.accountant,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': habitData.id,
      'title': habitData.title,
      'twoDayRule': habitData.twoDayRule ? 1 : 0,
      'position': habitData.position,
      'cue': habitData.cue,
      'routine': habitData.routine,
      'reward': habitData.reward,
      'showReward': habitData.showReward ? 1 : 0,
      'advanced': habitData.advanced ? 1 : 0,
      'notification': habitData.notification ? 1 : 0,
      'notTime': '${habitData.notTime.hour}:${habitData.notTime.minute}',
      'events': habitData.events.map((key, value) {
        return MapEntry(key.toString(), [value[0].toString(), value[1]]);
      }),
      'sanction': habitData.sanction,
      'showSanction': habitData.showSanction ? 1 : 0,
      'accountant': habitData.accountant,
    };
  }

  Habit.fromJson(Map<String, dynamic> json, {super.key})
      : habitData = HabitData(
          id: json['id'],
          position: json['position'],
          title: json['title'],
          twoDayRule: json['twoDayRule'] != 0 ? true : false,
          cue: json['cue'],
          routine: json['routine'],
          reward: json['reward'],
          showReward: json['showReward'] != 0 ? true : false,
          advanced: json['advanced'] != 0 ? true : false,
          notification: json['notification'] != 0 ? true : false,
          notTime: parseTimeOfDay(json['notTime']),
          events: doEvents(json['events']),
          sanction: json['sanction'] ?? '',
          showSanction: (json['showSanction'] ?? 0) != 0 ? true : false,
          accountant: json['accountant'] ?? '',
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
    return '${all[0]}.${all[1].toLowerCase()}';
  }

  void navigateToEditPage(context) {
    Provider.of<AppStateManager>(context, listen: false).goEditHabit(habitData);
  }

  @override
  State<Habit> createState() => HabitState();
}

class HabitState extends State<Habit> {
  bool _orangeStreak = false;
  bool _streakVisible = false;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool _showMonth = false;
  String _actualMonth = '';
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  void refresh() {
    setState(() {
      _updateLastStreak();
    });
  }

  @override
  void initState() {
    super.initState();
    _updateLastStreak();
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
        widget.habitData.reward != '') {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            '${S.of(context).congratulationsReward}\n${widget.habitData.reward}',
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
        widget.habitData.sanction != '') {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            '${S.of(context).ohNoSanction}\n${widget.habitData.sanction}',
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

  List _getEventsForDay(DateTime day) {
    return widget.habitData.events[transformDate(day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setSelectedDay(selectedDay);
  }

  setSelectedDay(DateTime selectedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = selectedDay;
        reloadMonth(selectedDay);
      });
    }
  }

  reloadMonth(DateTime selectedDay) {
    _showMonth = (_calendarFormat == CalendarFormat.month);
    _actualMonth = DateFormat('yMMMM', Intl.getCurrentLocale())
        .format(selectedDay)
        .capitalize();
  }

  _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
        reloadMonth(_selectedDay);
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
              streakVisible: _streakVisible,
              orangeStreak: _orangeStreak,
              streak: widget.habitData.streak,
            ),
            if (_showMonth &&
                Provider.of<SettingsManager>(context).getShowMonthName)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(_actualMonth),
              ),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime.now(),
              headerVisible: false,
              currentDay: DateTime.now(),
              availableCalendarFormats: {
                CalendarFormat.month: S.of(context).month,
                CalendarFormat.week: S.of(context).week,
              },
              eventLoader: _getEventsForDay,
              calendarFormat: _calendarFormat,
              daysOfWeekVisible: false,
              onFormatChanged: _onFormatChanged,
              onPageChanged: setSelectedDay,
              onDaySelected: _onDaySelected,
              startingDayOfWeek:
                  Provider.of<SettingsManager>(context).getWeekStartEnum,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) {
                  return OneDayButton(
                    callback: refresh,
                    parent: this,
                    id: widget.habitData.id!,
                    date: date,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    event: widget.habitData.events[transformDate(date)],
                  );
                },
                todayBuilder: (context, date, _) {
                  return OneDayButton(
                    callback: refresh,
                    parent: this,
                    id: widget.habitData.id!,
                    date: date,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    event: widget.habitData.events[transformDate(date)],
                  );
                },
                disabledBuilder: (context, date, _) {
                  return OneDay(
                    date: date,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                          color: (date.weekday > 5) ? Colors.red[300] : null),
                    ),
                  );
                },
                outsideBuilder: (context, date, _) {
                  return OneDay(
                    date: date,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                          color: (date.weekday > 5) ? Colors.red[300] : null),
                    ),
                  );
                },
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return _buildEventsMarker(date, events);
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AspectRatio(
      aspectRatio: 1,
      child: IgnorePointer(
        child: Stack(children: [
          (events[0] != DayType.clear)
              ? Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: events[0] == DayType.check
                        ? Provider.of<SettingsManager>(context, listen: false)
                            .checkColor
                        : events[0] == DayType.fail
                            ? Provider.of<SettingsManager>(context,
                                    listen: false)
                                .failColor
                            : Provider.of<SettingsManager>(context,
                                    listen: false)
                                .skipColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: events[0] == DayType.check
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : events[0] == DayType.fail
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.last_page,
                              color: Colors.white,
                            ),
                )
              : Container(),
          (events[1] != null && events[1] != '')
              ? Container(
                  alignment: const Alignment(1.0, 1.0),
                  padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 2.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(15.0),
                    elevation: 1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: HaboColors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }

  _updateLastStreak() {
    if (widget.habitData.twoDayRule == true) {
      _updateLastStreakTwoDay();
    } else {
      _updateLastStreakNormal();
    }
  }

  _updateLastStreakNormal() {
    int inStreak = 0;
    var checkDayKey = widget.habitData.events.lastKey();
    var lastDayKey = widget.habitData.events.lastKey();

    while (widget.habitData.events[checkDayKey] != null &&
        widget.habitData.events[checkDayKey]![0] != DayType.fail) {
      if (widget.habitData.events[checkDayKey]![0] != DayType.clear) {
        if (widget.habitData.events[lastDayKey]![0] != null &&
            widget.habitData.events[lastDayKey]![0] != DayType.clear &&
            lastDayKey!.difference(checkDayKey!).inDays > 1) break;
        lastDayKey = checkDayKey;
      }

      if (widget.habitData.events[checkDayKey]![0] == DayType.check) inStreak++;
      checkDayKey = widget.habitData.events.lastKeyBefore(checkDayKey!);
    }

    _streakVisible = (inStreak >= 2);

    widget.habitData.streak = inStreak;
  }

  _updateLastStreakTwoDay() {
    int inStreak = 0;
    var trueLastKey = widget.habitData.events.lastKey();

    while (widget.habitData.events[trueLastKey] != null &&
        widget.habitData.events[trueLastKey]![0] != null &&
        widget.habitData.events[trueLastKey]![0] == DayType.clear) {
      trueLastKey = widget.habitData.events.lastKeyBefore(trueLastKey!);
    }

    var checkDayKey = trueLastKey;
    var lastDayKey = trueLastKey;
    DayType lastDay = DayType.check;

    while (widget.habitData.events[checkDayKey] != null) {
      if (widget.habitData.events[checkDayKey]![0] != DayType.clear) {
        if (widget.habitData.events[checkDayKey]![0] == DayType.fail &&
            (lastDay != DayType.check && lastDay != DayType.clear)) {
          break;
        }

        if (widget.habitData.events[lastDayKey]![0] != null &&
            widget.habitData.events[lastDayKey]![0] != DayType.clear &&
            lastDayKey!.difference(checkDayKey!).inDays > 1) break;
        lastDayKey = checkDayKey;
      }

      lastDay = widget.habitData.events[checkDayKey]![0];
      if (widget.habitData.events[checkDayKey]![0] == DayType.check) inStreak++;
      checkDayKey = widget.habitData.events.lastKeyBefore(checkDayKey!);
    }

    _streakVisible = (inStreak >= 2);

    widget.habitData.streak = inStreak;
    _orangeStreak = (widget.habitData.events[trueLastKey] != null &&
        widget.habitData.events[trueLastKey]![0] == DayType.fail);
  }
}
