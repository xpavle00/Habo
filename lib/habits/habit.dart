import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habo/model/category.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/habits/habit_header.dart';
import 'package:habo/habits/one_day.dart';
import 'package:habo/habits/one_day_button.dart';
import 'package:habo/helpers.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
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
      'habitType': habitData.habitType.index,
      'targetValue': habitData.targetValue,
      'partialValue': habitData.partialValue,
      'unit': habitData.unit,
      'archived': habitData.archived ? 1 : 0,
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
        return MapEntry(
            key.toString(),
            value.length > 2
                ? [value[0].toString(), value[1], value[2]]
                : [value[0].toString(), value[1]]);
      }),
      'sanction': habitData.sanction,
      'showSanction': habitData.showSanction ? 1 : 0,
      'accountant': habitData.accountant,
      'habitType': habitData.habitType.index,
      'targetValue': habitData.targetValue,
      'partialValue': habitData.partialValue,
      'unit': habitData.unit,
      'categories':
          habitData.categories.map((category) => category.toJson()).toList(),
      'archived': habitData.archived ? 1 : 0,
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
          habitType: HabitType.values[json['habitType'] ?? 0],
          targetValue: (json['targetValue'] ?? 1.0).toDouble(),
          partialValue: (json['partialValue'] ?? 1.0).toDouble(),
          unit: json['unit'] ?? '',
          categories: json['categories'] != null
              ? (json['categories'] as List)
                  .map((categoryJson) => Category.fromJson(categoryJson))
                  .toList()
              : [],
          archived: (json['archived'] ?? 0) != 0 ? true : false,
        );

  static SplayTreeMap<DateTime, List> doEvents(Map<String, dynamic> input) {
    SplayTreeMap<DateTime, List> result = SplayTreeMap<DateTime, List>();

    input.forEach((key, value) {
      final dayType = DayType.values
          .firstWhere((e) => e.toString() == reformatOld(value[0]));
      final comment = value[1];

      // Handle progress data for numeric habits
      if (value.length > 2 && dayType == DayType.progress) {
        final progressValue = (value[2] as num?)?.toDouble() ?? 0.0;
        result[DateTime.parse(key)] = [dayType, comment, progressValue];
      } else {
        result[DateTime.parse(key)] = [dayType, comment];
      }
    });
    return result;
  }

  // To be compatible with older version backup
  static String reformatOld(String value) {
    var all = value.split('.');
    return '${all[0]}.${all[1].toLowerCase()}';
  }

  void navigateToEditPage(BuildContext context) {
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

  void showRewardNotification(DateTime date) {
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
          backgroundColor: Provider.of<SettingsManager>(context).checkColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void showSanctionNotification(DateTime date) {
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
          backgroundColor: Provider.of<SettingsManager>(context).failColor,
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

  void setSelectedDay(DateTime selectedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = selectedDay;
        reloadMonth(selectedDay);
      });
    }
  }

  void reloadMonth(DateTime selectedDay) {
    _showMonth = (_calendarFormat == CalendarFormat.month);
    _actualMonth = DateFormat('yMMMM', Intl.getCurrentLocale())
        .format(selectedDay)
        .capitalize();
  }

  void _onFormatChanged(CalendarFormat format) {
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
                    color: _getEventColor(events),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _getEventIcon(events),
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

  Color _getEventColor(List events) {
    final eventType = events[0] as DayType;

    switch (eventType) {
      case DayType.check:
        return Provider.of<SettingsManager>(context).checkColor;
      case DayType.fail:
        return Provider.of<SettingsManager>(context).failColor;
      case DayType.skip:
        return Provider.of<SettingsManager>(context).skipColor;
      case DayType.progress:
        // For progress events, check if it's 100% completion
        if (widget.habitData.isNumeric && events.length > 2) {
          final progressValue = (events[2] as num?)?.toDouble() ?? 0.0;
          if (progressValue >= widget.habitData.targetValue) {
            // 100% or more = green check color
            return Provider.of<SettingsManager>(context, listen: false)
                .checkColor;
          }
        }
        return Provider.of<SettingsManager>(context, listen: false)
            .progressColor;
      case DayType.clear:
      default:
        return Colors.transparent;
    }
  }

  Widget _getEventIcon(List events) {
    final eventType = events[0] as DayType;

    switch (eventType) {
      case DayType.check:
        return Icon(
          Icons.check,
          color: Provider.of<SettingsManager>(context).iconColor,
        );
      case DayType.fail:
        return Icon(
          Icons.close,
          color: Provider.of<SettingsManager>(context).iconColor,
        );
      case DayType.skip:
        return Icon(
          Icons.last_page,
          color: Provider.of<SettingsManager>(context).iconColor,
        );
      case DayType.progress:
        // For progress events, check if it's 100% completion
        if (widget.habitData.isNumeric && events.length > 2) {
          final progressValue = (events[2] as num?)?.toDouble() ?? 0.0;
          if (progressValue >= widget.habitData.targetValue) {
            // 100% or more = green check icon
            return Icon(
              Icons.check,
              color: Provider.of<SettingsManager>(context).iconColor,
            );
          }
        }
        return _buildProgressIcon(events);
      case DayType.clear:
      default:
        return Container();
    }
  }

  Widget _buildProgressIcon(List events) {
    // For progress events, show a circular progress indicator
    if (events.length > 2 && widget.habitData.isNumeric) {
      final progressValue = (events[2] as num?)?.toDouble() ?? 0.0;
      final percentage =
          (progressValue / widget.habitData.targetValue).clamp(0.0, 1.0);

      return Stack(
        children: [
          Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: percentage,
                strokeWidth: 3,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          Center(
            child: Text(
              '${(percentage * 100).round()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    // Fallback for non-numeric progress events
    return const Icon(
      Icons.trending_up,
      color: Colors.white,
      size: 20,
    );
  }

  void _updateLastStreak() {
    if (widget.habitData.twoDayRule == true) {
      _updateLastStreakTwoDay();
    } else {
      _updateLastStreakNormal();
    }
  }

  void _updateLastStreakNormal() {
    int inStreak = 0;
    var checkDayKey = widget.habitData.events.lastKey();
    var lastDayKey = widget.habitData.events.lastKey();

    while (widget.habitData.events[checkDayKey] != null &&
        widget.habitData.events[checkDayKey]![0] != DayType.fail) {
      if (widget.habitData.events[checkDayKey]![0] != DayType.clear) {
        if (widget.habitData.events[lastDayKey]![0] != null &&
            widget.habitData.events[lastDayKey]![0] != DayType.clear &&
            lastDayKey!.difference(checkDayKey!).inDays > 1) {
          break;
        }
        lastDayKey = checkDayKey;
      }

      if (widget.habitData.events[checkDayKey]![0] == DayType.check ||
          (widget.habitData.events[checkDayKey]![0] == DayType.progress &&
              widget.habitData.events[checkDayKey]![2] >=
                  widget.habitData.targetValue)) {
        inStreak++;
      }
      checkDayKey = widget.habitData.events.lastKeyBefore(checkDayKey!);
    }

    _streakVisible = (inStreak >= 2);

    widget.habitData.streak = inStreak;
  }

  void _updateLastStreakTwoDay() {
    int inStreak = 0;
    var trueLastKey = widget.habitData.events.lastKey();

    // Skip clear entries and single incomplete progress (treated as clear)
    while (widget.habitData.events[trueLastKey] != null &&
        widget.habitData.events[trueLastKey]![0] != null &&
        (widget.habitData.events[trueLastKey]![0] == DayType.clear ||
            (widget.habitData.events[trueLastKey]![0] == DayType.progress &&
                widget.habitData.events[trueLastKey]![2] <
                    widget.habitData.targetValue))) {
      trueLastKey = widget.habitData.events.lastKeyBefore(trueLastKey!);
    }

    var checkDayKey = trueLastKey;
    var lastDayKey = trueLastKey;
    DayType lastDay = DayType.check;

    while (widget.habitData.events[checkDayKey] != null) {
      if (widget.habitData.events[checkDayKey]![0] != DayType.clear) {
        // End if fail and next is not check, clear or progress
        if (widget.habitData.events[checkDayKey]![0] == DayType.fail &&
            (lastDay != DayType.check &&
                lastDay != DayType.clear &&
                (lastDay != DayType.progress))) {
          break;
        }

        // End if gap is more than 1 day
        if (widget.habitData.events[lastDayKey]![0] != null &&
            widget.habitData.events[lastDayKey]![0] != DayType.clear &&
            lastDayKey!.difference(checkDayKey!).inDays > 1) {
          break;
        }

        lastDayKey = checkDayKey;
      }

      // Count streak if check or 100% progress
      lastDay = widget.habitData.events[checkDayKey]![0];
      if (widget.habitData.events[checkDayKey]![0] == DayType.check ||
          (widget.habitData.events[checkDayKey]![0] == DayType.progress &&
              widget.habitData.events[checkDayKey]![2] >=
                  widget.habitData.targetValue)) {
        inStreak++;
      }
      checkDayKey = widget.habitData.events.lastKeyBefore(checkDayKey!);
    }

    _streakVisible = (inStreak >= 2);

    // Set orange streak if last event is fail
    widget.habitData.streak = inStreak;
    _orangeStreak = (widget.habitData.events[trueLastKey] != null &&
        widget.habitData.events[trueLastKey]![0] == DayType.fail);
  }
}
