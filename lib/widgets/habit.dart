import 'dart:async';
import 'dart:collection';

import 'package:Habo/habit_data.dart';
import 'package:Habo/helpers.dart';
import 'package:Habo/provider.dart';
import 'package:Habo/screens/edit_habit_screen.dart';
import 'package:Habo/widgets/habit_header.dart';
import 'package:Habo/widgets/one_day.dart';
import 'package:Habo/widgets/one_day_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Habit extends StatefulWidget {
  Habit({this.habitData});

  final HabitData habitData;

  set setId(int input) {
    habitData.id = input;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.habitData.id,
      "title": this.habitData.title,
      "twoDayRule": this.habitData.twoDayRule ? 1 : 0,
      "position": this.habitData.position,
      "cue": this.habitData.cue,
      "routine": this.habitData.routine,
      "reward": this.habitData.reward,
      "showReward": this.habitData.showReward ? 1 : 0,
      "advanced": this.habitData.advanced ? 1 : 0,
      "notification": this.habitData.notification ? 1 : 0,
      "notTime": this.habitData.notTime.hour.toString() +
          ":" +
          this.habitData.notTime.minute.toString(),
    };
  }

  @override
  _HabitState createState() => _HabitState(habitData);

  Future navigateToEditPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditHabitScreen(
          habitData: habitData,
        ),
      ),
    );
  }
}

class _HabitState extends State<Habit> {
  bool _orangeStreak = false;
  bool _streakVisible = false;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  HabitData _habitData;

  _HabitState(habitData) : this._habitData = habitData;

  void refresh() {
    _updateLastStreak();
    setState(() {});
  }

  CalendarController get controller {
    return _habitData.calendarController;
  }

  SplayTreeMap<DateTime, List> get events {
    return _habitData.events;
  }

  @override
  void initState() {
    super.initState();
    try {
      this._calendarFormat = _habitData.calendarController.calendarFormat;
    } catch (e) {
      this._calendarFormat = CalendarFormat.week;
    }
    _updateLastStreak();
  }

  @override
  void dispose() {
    _habitData.calendarController.dispose();
    super.dispose();
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
                name: _habitData.title,
                widget: widget,
                streakVisible: _streakVisible,
                orangeStreak: _orangeStreak,
                streak: _habitData.streak),
            TableCalendar(
              headerVisible: false,
              events: _habitData.events,
              endDay: DateTime.now(),
              initialCalendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
                CalendarFormat.week: 'Week',
              },
              calendarStyle: CalendarStyle(
                  renderDaysOfWeek: false,
                  contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
              startingDayOfWeek: Provider.of<Bloc>(context).getWeekStartEnum,
              builders: CalendarBuilders(
                dayBuilder: (context, date, _) {
                  return OneDayButton(
                    callback: refresh,
                    parent: this,
                    id: widget.habitData.id,
                    date: date,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    event: _habitData.events[date],
                  );
                },
                weekendDayBuilder: (context, date, _) {
                  return OneDayButton(
                    callback: refresh,
                    parent: this,
                    id: widget.habitData.id,
                    date: date,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.red[300]),
                    ),
                    event: _habitData.events[date],
                  );
                },
                outsideDayBuilder: (context, date, _) {
                  return OneDay(
                    date: date,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    child: Text(
                      date.day.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  );
                },
                outsideWeekendDayBuilder: (context, date, _) {
                  return OneDay(
                      date: date,
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryVariant, //Color(0xFFFAFAFA),
                      child: Text(date.day.toString(),
                          style: Theme.of(context).textTheme.bodyText1));
                },
                unavailableDayBuilder: (context, date, _) {
                  return OneDay(
                    date: date,
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryVariant, //Color(0xFFFAFAFA),
                    child: Text(
                      date.day.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  );
                },
                markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];

                  if (events.isNotEmpty) {
                    children.add(_buildEventsMarker(date, events));
                  }
                  return children;
                },
              ),
              calendarController: _habitData.calendarController,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return IgnorePointer(
      child: Stack(children: [
        (events[0] != DayType.Clear)
            ? Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: events[0] == DayType.Check
                      ? HaboColors.primary
                      : events[0] == DayType.Fail
                          ? HaboColors.red
                          : HaboColors.skip,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: events[0] == DayType.Check
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : events[0] == DayType.Fail
                        ? Icon(
                            Icons.close,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.last_page,
                            color: Colors.white,
                          ),
              )
            : Container(),
        (events[1] != null && events[1] != "")
            ? Container(
                alignment: const Alignment(1.0, 1.0),
                padding: const EdgeInsets.fromLTRB(0, 0, 7.0, 3.0),
                child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  elevation: 1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: new BoxDecoration(
                      color: HaboColors.comment,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )
            : Container(),
      ]),
    );
  }

  _updateLastStreak() {
    if (_habitData.twoDayRule == true) {
      _updateLastStreakTwoDay();
    } else {
      _updateLastStreakNormal();
    }
  }

  _updateLastStreakNormal() {
    int inStreak = 0;
    var _checkDay = _habitData.events.lastKey();

    while (_habitData.events[_checkDay] != null &&
        (_habitData.events[_checkDay][0] == DayType.Check ||
            _habitData.events[_checkDay][0] == DayType.Skip)) {
      if (_habitData.events[_checkDay][0] == DayType.Check) inStreak++;

      if (_habitData.events.lastKeyBefore(_checkDay) != null &&
          _checkDay
                  .difference(_habitData.events.lastKeyBefore(_checkDay))
                  .inDays !=
              1) break;

      _checkDay = _habitData.events.lastKeyBefore(_checkDay);
    }

    if (inStreak >= 2)
      _streakVisible = true;
    else
      _streakVisible = false;

    this._habitData.streak = inStreak;
  }

  _updateLastStreakTwoDay() {
    int inStreak = 0;
    var checkDay = _habitData.events.lastKey();

    DayType lastDay = DayType.Check;

    while (_habitData.events[checkDay] != null) {
      if (_habitData.events[checkDay][0] == DayType.Check) inStreak++;

      if (_habitData.events[checkDay][0] == DayType.Fail &&
          lastDay != DayType.Check) {
        break;
      }

      if (_habitData.events.lastKeyBefore(checkDay) != null &&
          checkDay
                  .difference(_habitData.events.lastKeyBefore(checkDay))
                  .inDays !=
              1) break;

      lastDay = _habitData.events[checkDay][0];
      checkDay = _habitData.events.lastKeyBefore(checkDay);
    }

    if (inStreak >= 2)
      _streakVisible = true;
    else
      _streakVisible = false;

    this._habitData.streak = inStreak;
    if (_habitData.events[_habitData.events.lastKey()] != null &&
        _habitData.events[_habitData.events.lastKey()][0] == DayType.Fail) {
      this._orangeStreak = true;
    } else {
      this._orangeStreak = false;
    }
  }

  showRewardNotification(date) {
    if (_habitData.calendarController.isToday(date) &&
        widget.habitData.showReward &&
        widget.habitData.reward != "") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            "Congratulation! Your reward:\n" + widget.habitData.reward,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).toggleableActiveColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
