import 'dart:async';
import 'dart:collection';

import 'package:Habo/provider.dart';
import 'package:Habo/widgets/edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

enum DayType { Clear, Check, Fail, Skip }

class Habit extends StatefulWidget {
  Habit({
    this.id,
    this.position,
    this.title,
    this.twoDayRule,
    this.cue,
    this.routine,
    this.reward,
    this.showReward,
    this.advanced,
    this.notification,
    this.notTime,
    this.events,
  });

  final SplayTreeMap<DateTime, List> events;
  final int _streak = 0;
  final CalendarController _calendarController = new CalendarController();
  int id;
  int position;

  String title;
  bool twoDayRule;
  String cue;
  String routine;
  String reward;
  bool showReward;
  bool advanced;
  bool notification;
  TimeOfDay notTime;

  set setId(int idin) {
    id = idin;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "twoDayRule": this.twoDayRule,
      "position": this.position,
      "cue": this.cue,
      "routine": this.routine,
      "reward": this.reward,
      "showReward": this.showReward,
      "advanced": this.advanced,
      "notification": this.advanced,
      "notTime":
          this.notTime.hour.toString() + ":" + this.notTime.minute.toString(),
    };
  }

  @override
  _HabitState createState() =>
      _HabitState(title, events, _streak, _calendarController, twoDayRule);

  Future navigateToEditPage(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditHabitPage(
                  id: id,
                  title: title,
                  twoDayRule: twoDayRule,
                  cue: cue,
                  routine: routine,
                  reward: reward,
                  showReward: showReward,
                  advanced: advanced,
                  notification: notification,
                  notTime: notTime,
                )));
  }
}

class _HabitState extends State<Habit> {
  CalendarController _controller;
  String name = "";
  SplayTreeMap<DateTime, List> _events;
  int _streak;
  bool _orangeStreak = false;
  bool _streakVisible = false;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool twoDayRule;

  _HabitState(name, events, streak, calendarController, twoDayRule)
      : this.name = name,
        this._events = events,
        this._streak = streak,
        this._controller = calendarController,
        this.twoDayRule = twoDayRule;

  void refresh() {
    _updateLastStreak();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    try {
      this._calendarFormat = _controller.calendarFormat;
    } catch (e) {
      this._calendarFormat = CalendarFormat.week;
    }
    _updateLastStreak();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                height: 24,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.65),
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 35,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.more_horiz),
                    color: Colors.grey,
                    tooltip: 'Modify',
                    onPressed: () {
                      //createAlertDialog(context);
                      widget.navigateToEditPage(context);
                    },
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Visibility(
                    visible: _streakVisible,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: (this._orangeStreak)
                                ? Colors.orange
                                : Color(0xFF09BF30),
                          ),
                          color: (this._orangeStreak)
                              ? Colors.orange
                              : Color(0xFF09BF30),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                offset: Offset.fromDirection(1, 3),
                                color: Color(0x21000000))
                          ]),
                      width: 42,
                      height: 22,
                      alignment: Alignment.center,
                      child: Text(
                        "$_streak",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ))
            ]),
            TableCalendar(
              headerVisible: false,
              events: _events,
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
                  int ind = 0;
                  if (_events[date] != null && _events[date][0] != 0) {
                    ind = (_events[date][0].index);
                  }

                  return OneDayButton(
                    callback: refresh,
                    parent: this,
                    id: widget.id,
                    date: date,
                    index: ind,
                    color: Theme.of(context).colorScheme.primaryVariant,
                  );
                },
                weekendDayBuilder: (context, date, _) {
                  int ind = 0;
                  if (_events[date] != null && _events[date][0] != 0) {
                    ind = (_events[date][0].index);
                  }

                  return OneDayButton(
                    callback: refresh,
                    parent: this,
                    id: widget.id,
                    date: date,
                    index: ind,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.red[300]),
                    ),
                  );
                },
                outsideDayBuilder: (context, date, _) {
                  return OneDay(
                      date: date,
                      color: Theme.of(context).colorScheme.secondaryVariant,
                      child: Text(
                        date.day.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ));
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
                      ));
                },
                markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];

                  if (events.isNotEmpty) {
                    children.add(_buildEventsMarker(date, events));
                  }

                  return children;
                },
              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return IgnorePointer(
      child: Container(
          margin: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: events[0] == DayType.Check
                ? Color(0xFF09BF30)
                : events[0] == DayType.Fail ? Colors.red : Color(0xFF505050),
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
                    )),
    );
  }

  _updateLastStreak() {
    if (twoDayRule == true) {
      _updateLastStreakTwoDay();
    } else {
      _updateLastStreakNormal();
    }
  }

  _updateLastStreakNormal() {
    int inStreak = 0;
    var _checkDay = _events.lastKey();

    while (_events[_checkDay] != null &&
        (_events[_checkDay][0] == DayType.Check ||
            _events[_checkDay][0] == DayType.Skip)) {
      if (_events[_checkDay][0] == DayType.Check) inStreak++;

      if (_events.lastKeyBefore(_checkDay) != null &&
          _checkDay.difference(_events.lastKeyBefore(_checkDay)).inDays != 1)
        break;

      _checkDay = _events.lastKeyBefore(_checkDay);
    }

    if (inStreak >= 2)
      _streakVisible = true;
    else
      _streakVisible = false;

    this._streak = inStreak;
  }

  _updateLastStreakTwoDay() {
    int inStreak = 0;
    var checkDay = _events.lastKey();

    DayType lastDay = DayType.Check;

    while (_events[checkDay] != null) {
      if (_events[checkDay][0] == DayType.Check) inStreak++;

      if (_events[checkDay][0] == DayType.Fail && lastDay != DayType.Check) {
        break;
      }

      if (_events.lastKeyBefore(checkDay) != null &&
          checkDay.difference(_events.lastKeyBefore(checkDay)).inDays != 1)
        break;

      lastDay = _events[checkDay][0];
      checkDay = _events.lastKeyBefore(checkDay);
    }

    if (inStreak >= 2)
      _streakVisible = true;
    else
      _streakVisible = false;

    this._streak = inStreak;
    if (_events[_events.lastKey()] != null &&
        _events[_events.lastKey()][0] == DayType.Fail) {
      this._orangeStreak = true;
    } else {
      this._orangeStreak = false;
    }
  }

  _showRewardNotification(date) {
    if (_controller.isToday(date) && widget.showReward && widget.reward != "") {
      Provider.of<Bloc>(context, listen: false)
          .getScafoldKey
          .currentState
          .hideCurrentSnackBar();
      Provider.of<Bloc>(context, listen: false)
          .getScafoldKey
          .currentState
          .showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Congratulation! Your reward:\n" + widget.reward,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).toggleableActiveColor,
            behavior: SnackBarBehavior.floating,
          ));
    }
  }
}

class OneDay extends StatelessWidget {
  const OneDay({Key key, this.date, this.color, this.child}) : super(key: key);

  final DateTime date;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Material(
        color: this.color,
        borderRadius: BorderRadius.circular(15.0),
        elevation: 3,
        child: Container(
            alignment: Alignment.center,
            child: this.child != null
                ? this.child
                : Center(child: Text(this.date.day.toString()))),
      ),
    );
  }
}

class OneDayButton extends StatelessWidget {
  const OneDayButton(
      {Key key,
      this.date,
      this.color,
      this.child,
      this.id,
      this.parent,
      this.callback,
      this.index})
      : super(key: key);

  final int id;
  final DateTime date;
  final Color color;
  final Widget child;
  final _HabitState parent;
  final void Function() callback;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<InButton> icons = [
      InButton(
          text: this.child != null
              ? this.child
              : Center(child: Text(this.date.day.toString()))),
      InButton(
          icon: Icon(
        Icons.check,
        color: Color(0xFF09BF30),
      )),
      InButton(
          icon: Icon(
        Icons.close,
        color: Colors.red,
      )),
      InButton(icon: Icon(Icons.last_page)),
    ];
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Material(
        color: this.color,
        borderRadius: BorderRadius.circular(15.0),
        elevation: 3,
        child: Container(
          alignment: Alignment.center,
          child: DropdownButton<InButton>(
            iconSize: 0,
            elevation: 3,
            dropdownColor: Theme.of(context).colorScheme.primaryVariant,
            underline: Container(),
            items: icons.map((InButton value) {
              return new DropdownMenuItem<InButton>(
                value: value,
                child: Center(child: value),
              );
            }).toList(),
            value: icons[index],
            onTap: () {
              parent._controller.setSelectedDay(date);
            },
            onChanged: (value) {
              if (icons.indexOf(value) > 0) {
                Provider.of<Bloc>(context, listen: false)
                    .addEvent(id, date, [DayType.values[icons.indexOf(value)]]);
                parent._events[date] = [DayType.values[icons.indexOf(value)]];
                if (icons.indexOf(value) == 1) {
                  parent._showRewardNotification(date);
                }
              } else {
                Provider.of<Bloc>(context, listen: false).deleteEvent(id, date);
                parent._events.remove(date);
              }
              callback();
            },
          ),
        ),
      ),
    );
  }
}

class InButton extends StatelessWidget {
  const InButton({Key key, this.icon, this.text}) : super(key: key);

  final Icon icon;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (text != null)
          ? Container(
              width: 24, height: 24, alignment: Alignment.center, child: text)
          : icon,
    );
  }
}
