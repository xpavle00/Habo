import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/habits/in_button.dart';
import 'package:habo/helpers.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/widgets/progress_input_modal.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OneDayButton extends StatelessWidget {
  OneDayButton(
      {super.key,
      required date,
      this.color,
      this.child,
      required this.id,
      required this.parent,
      required this.callback,
      required this.event})
      : date = transformDate(date);

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
          color: Provider.of<SettingsManager>(context).checkColor,
          semanticLabel: S.of(context).check,
        ),
      ),
      // Add plus icon for numeric habits
      if (parent.widget.habitData.isNumeric)
        InButton(
          key: const Key('Plus'),
          icon: Icon(
            Icons.add,
            color: Provider.of<SettingsManager>(context).progressColor,
            semanticLabel: 'Add Progress',
          ),
        ),
      InButton(
        key: const Key('Fail'),
        icon: Icon(
          Icons.close,
          color: Provider.of<SettingsManager>(context).failColor,
          semanticLabel: S.of(context).fail,
        ),
      ),
      InButton(
        key: const Key('Skip'),
        icon: Icon(
          Icons.last_page,
          color: Provider.of<SettingsManager>(context).skipColor,
          semanticLabel: S.of(context).skip,
        ),
      ),
      InButton(
        key: const Key('Comment'),
        icon: Icon(
          Icons.chat_bubble_outline,
          semanticLabel: S.of(context).note,
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
                borderRadius: BorderRadius.circular(10.0),
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
                      // For numeric habits, Check means complete the habit fully
                      if (value.key == const Key('Check') &&
                          parent.widget.habitData.isNumeric) {
                        Provider.of<SettingsManager>(context, listen: false)
                            .playCheckSound();
                        // Complete the habit with full target value
                        Provider.of<HabitsManager>(context, listen: false)
                            .addEvent(id, date, [DayType.check, comment]);
                        parent.events[date] = [DayType.check, comment];
                        parent.showRewardNotification(date);
                      } else {
                        final dayType = _getDayTypeFromKey(value.key);
                        Provider.of<HabitsManager>(context, listen: false)
                            .addEvent(id, date, [dayType, comment]);
                        parent.events[date] = [dayType, comment];
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
                      }
                    } else if (value.key == const Key('Plus')) {
                      // Plus icon shows the progress input modal for numeric habits
                      _showProgressInputModal(context);
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

  void showCommentDialog(BuildContext context, int index, String comment) {
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
              Text(S.of(context).note),
              TextField(
                controller: commentController,
                autofocus: true,
                maxLines: 5,
                showCursor: true,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(11),
                  border: InputBorder.none,
                  hintText: S.of(context).yourCommentHere,
                ),
              ),
            ],
          ),
        ),
      ),
      btnOkText: S.of(context).save,
      btnCancelText: S.of(context).close,
      btnCancelColor: Colors.grey,
      btnOkColor: Theme.of(context).colorScheme.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Provider.of<HabitsManager>(context, listen: false).addEvent(
            id, date, [DayType.values[index], commentController.text]);
        parent.events[date] = [DayType.values[index], commentController.text];
        callback();
      },
    ).show();
  }

  DayType _getDayTypeFromKey(Key? key) {
    // Reliable mapping from icon keys to DayType values
    if (key == const Key('Check')) {
      return DayType.check;
    } else if (key == const Key('Fail')) {
      return DayType.fail;
    } else if (key == const Key('Skip')) {
      return DayType.skip;
    } else if (key == const Key('Plus')) {
      return DayType.progress;
    } else {
      return DayType.clear;
    }
  }

  void _showProgressInputModal(BuildContext context) {
    final habitData = parent.widget.habitData;
    final currentProgress = habitData.getProgressForDate(date);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProgressInputModal(
          habitTitle: habitData.title,
          targetValue: habitData.targetValue,
          partialValue: habitData.partialValue,
          unit: habitData.unit,
          currentProgress: currentProgress,
          onProgressChanged: (double progressValue) {
            // Add progress event
            Provider.of<HabitsManager>(context, listen: false)
                .addEvent(id, date, [DayType.progress, '', progressValue]);
            parent.events[date] = [DayType.progress, '', progressValue];

            // Play appropriate sound and show notification
            if (progressValue >= habitData.targetValue) {
              parent.showRewardNotification(date);
              Provider.of<SettingsManager>(context, listen: false)
                  .playCheckSound();
            } else {
              Provider.of<SettingsManager>(context, listen: false)
                  .playClickSound();
            }

            callback();
          },
        );
      },
    );
  }
}
