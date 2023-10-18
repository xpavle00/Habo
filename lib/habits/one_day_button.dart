import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/habits/in_button.dart';
import 'package:habo/helpers.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OneDayButton extends StatelessWidget {
  OneDayButton(
      {Key? key,
      required date,
      this.color,
      this.child,
      required this.id,
      required this.parent,
      required this.callback,
      required this.event})
      : date = transformDate(date),
        super(key: key);

  final int id;
  final DateTime date;
  final Color? color;
  final Widget? child;
  final HabitState parent;
  final void Function() callback;
  final List? event;

  @override
  Widget build(BuildContext context) {
    List<InButton> icons = [
      InButton(
        key: const Key('Date'),
        text: child ??
            Text(
              date.day.toString(),
              style: TextStyle(
                color: (date.weekday > 5) ? Colors.red[300] : null,
                fontWeight: (isSameDay(date, DateTime.now()))
                    ? FontWeight.w900
                    : FontWeight.normal,
                fontSize: (isSameDay(date, DateTime.now())) ? 17 : null,
              ),
              textAlign: TextAlign.center,
            ),
      ),
      InButton(
        key: const Key('Check'),
        icon: Icon(
          Icons.check,
          color:
              Provider.of<SettingsManager>(context, listen: false).checkColor,
          semanticLabel: 'Check',
        ),
      ),
      InButton(
        key: const Key('Fail'),
        icon: Icon(
          Icons.close,
          color: Provider.of<SettingsManager>(context, listen: false).failColor,
          semanticLabel: 'Fail',
        ),
      ),
      InButton(
        key: const Key('Skip'),
        icon: Icon(
          Icons.last_page,
          color: Provider.of<SettingsManager>(context, listen: false).skipColor,
          semanticLabel: 'Skip',
        ),
      ),
      const InButton(
        key: Key('Comment'),
        icon: Icon(
          Icons.chat_bubble_outline,
          semanticLabel: 'Comment',
          color: HaboColors.orange,
        ),
      )
    ];

    int index = 0;
    String comment = '';

    if (event != null) {
      if (event![0] != 0) {
        index = (event![0].index);
      }

      if (event!.length > 1 && event![1] != null && event![1] != '') {
        comment = (event![1]);
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(4.0),
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 2,
            shadowColor: Theme.of(context).shadowColor,
            child: Container(
              alignment: Alignment.center,
              child: DropdownButton<InButton>(
                iconSize: 0,
                elevation: 3,
                alignment: Alignment.center,
                dropdownColor: Theme.of(context).colorScheme.primaryContainer,
                underline: Container(),
                items: icons.map(
                  (InButton value) {
                    return DropdownMenuItem<InButton>(
                      key: value.key,
                      value: value,
                      child: Center(child: value),
                    );
                  },
                ).toList(),
                value: icons[index],
                onTap: () {
                  parent.setSelectedDay(date);
                },
                onChanged: (value) {
                  if (value != null) {
                    if (value.key == const Key('Check') ||
                        value.key == const Key('Fail') ||
                        value.key == const Key('Skip')) {
                      Provider.of<HabitsManager>(context, listen: false)
                          .addEvent(id, date, [
                        DayType.values[icons
                            .indexWhere((element) => element.key == value.key)],
                        comment
                      ]);
                      parent.events[date] = [
                        DayType.values[icons
                            .indexWhere((element) => element.key == value.key)],
                        comment
                      ];
                      if (value.key == const Key('Check')) {
                        parent.showRewardNotification(date);
                        Provider.of<SettingsManager>(context, listen: false)
                            .playCheckSound();
                      } else {
                        Provider.of<SettingsManager>(context, listen: false)
                            .playClickSound();
                        if (value.key == const Key('Fail')) {
                          parent.showSanctionNotification(date);
                        }
                      }
                    } else if (value.key == const Key('Comment')) {
                      showCommentDialog(context, index, comment);
                    } else {
                      if (comment != '') {
                        Provider.of<HabitsManager>(context, listen: false)
                            .addEvent(id, date, [DayType.clear, comment]);
                        parent.events[date] = [DayType.clear, comment];
                      } else {
                        Provider.of<HabitsManager>(context, listen: false)
                            .deleteEvent(id, date);
                        parent.events.remove(date);
                      }
                    }
                    callback();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  showCommentDialog(BuildContext context, int index, String comment) {
    TextEditingController commentController =
        TextEditingController(text: comment);
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          child: Column(
            children: [
              const Text('Comment'),
              TextField(
                controller: commentController,
                autofocus: true,
                maxLines: 5,
                showCursor: true,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(11),
                  border: InputBorder.none,
                  hintText: 'Your comment here',
                ),
              ),
            ],
          ),
        ),
      ),
      btnOkText: 'Save',
      btnCancelText: 'Close',
      btnCancelColor: Colors.grey,
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Provider.of<HabitsManager>(context, listen: false).addEvent(
            id, date, [DayType.values[index], commentController.text]);
        parent.events[date] = [DayType.values[index], commentController.text];
        callback();
      },
    ).show();
  }
}
