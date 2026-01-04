import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
          color:
              Provider.of<SettingsManager>(context, listen: false).checkColor,
          semanticLabel: S.of(context).check,
        ),
      ),
      // Add plus icon for numeric habits
      if (parent.widget.habitData.isNumeric)
        InButton(
          key: const Key('Plus'),
          icon: Icon(
            Icons.add,
            color: Provider.of<SettingsManager>(context, listen: false)
                .progressColor,
            semanticLabel: 'Add Progress',
          ),
        ),
      InButton(
        key: const Key('Fail'),
        icon: Icon(
          Icons.close,
          color: Provider.of<SettingsManager>(context, listen: false).failColor,
          semanticLabel: S.of(context).fail,
        ),
      ),
      InButton(
        key: const Key('Skip'),
        icon: Icon(
          Icons.last_page,
          color: Provider.of<SettingsManager>(context, listen: false).skipColor,
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
      // Find the index in the icons list that matches the event DayType
      final dayType = event![0];
      if (dayType != DayType.clear) {
        Key targetKey;
        switch (dayType) {
          case DayType.check:
            targetKey = const Key('Check');
            break;
          case DayType.fail:
            targetKey = const Key('Fail');
            break;
          case DayType.skip:
            targetKey = const Key('Skip');
            break;
          case DayType.progress:
            targetKey = const Key('Plus');
            break;
          default:
            targetKey = const Key('Date');
        }

        // Find index in the possibly dynamic icons list
        final foundIndex = icons.indexWhere((icon) => icon.key == targetKey);
        if (foundIndex != -1) {
          index = foundIndex;
        }
      }

      if (event!.length > 1 && event![1] != null && event![1] != '') {
        comment = (event![1]);
      }
    }

    // Helper method to handle selection
    void handleSelection(InButton value) {
      if (value.key == const Key('Check') ||
          value.key == const Key('Fail') ||
          value.key == const Key('Skip')) {
        // For numeric habits, Check means complete the habit fully
        if (value.key == const Key('Check') &&
            parent.widget.habitData.isNumeric) {
          Provider.of<SettingsManager>(context, listen: false).playCheckSound();
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

    final oneTapCheck = Provider.of<SettingsManager>(context).getOneTapCheck;

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
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: Builder(
                builder: (BuildContext context) {
                  return RawGestureDetector(
                    gestures: <Type, GestureRecognizerFactory>{
                      TapGestureRecognizer:
                          GestureRecognizerFactoryWithHandlers<
                              TapGestureRecognizer>(
                        () => TapGestureRecognizer(),
                        (TapGestureRecognizer instance) {
                          instance.onTap = () {
                            parent.setSelectedDay(date);
                            if (oneTapCheck) {
                              // For numeric habits, add increment instead of full check
                              if (parent.widget.habitData.isNumeric) {
                                _addIncrement(context);
                              } else {
                                // Perform Check action for non-numeric habits
                                final checkItem = icons.firstWhere(
                                  (element) =>
                                      element.key == const Key('Check'),
                                  orElse: () => icons[1],
                                );
                                handleSelection(checkItem);
                              }
                            } else {
                              // Show menu
                              _showMenu(context, icons, index, color,
                                  handleSelection);
                            }
                          };
                        },
                      ),
                      LongPressGestureRecognizer:
                          GestureRecognizerFactoryWithHandlers<
                              LongPressGestureRecognizer>(
                        () => LongPressGestureRecognizer(
                            duration: const Duration(milliseconds: 400)),
                        (LongPressGestureRecognizer instance) {
                          instance.onLongPress = () {
                            if (oneTapCheck) {
                              // Show menu
                              _showMenu(context, icons, index, color,
                                  handleSelection);
                            } else {
                              // For numeric habits, add increment instead of full check
                              if (parent.widget.habitData.isNumeric) {
                                _addIncrement(context);
                              } else {
                                // Perform Check action for non-numeric habits
                                final checkItem = icons.firstWhere(
                                  (element) =>
                                      element.key == const Key('Check'),
                                  orElse: () => icons[1],
                                );
                                handleSelection(checkItem);
                              }
                            }
                          };
                        },
                      ),
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: icons[index], // Render the current state icon/text
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context, List<InButton> icons, int selectedIndex,
      Color? color, Function(InButton) onSelected) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    const double menuWidth = 60.0; // Fixed width for consistent centering
    const double itemHeight = 45.0; // Must match PopupMenuItem height

    // Calculate global position of the button
    final buttonTopLeft =
        renderBox.localToGlobal(Offset.zero, ancestor: overlay);
    final buttonBottomRight = renderBox.localToGlobal(
        renderBox.size.bottomRight(Offset.zero),
        ancestor: overlay);
    final buttonRect = Rect.fromPoints(buttonTopLeft, buttonBottomRight);

    // Calculate vertical offset to align the selected item with the button
    // The menu starts at 'top', so we shift 'top' up by (index * height)
    final double verticalOffset = selectedIndex * itemHeight;

    // Calculate centered position for the menu
    final centeredRect = Rect.fromLTWH(
      buttonRect.left + (buttonRect.width - menuWidth) / 2,
      buttonRect.top - verticalOffset,
      menuWidth,
      buttonRect.height +
          verticalOffset, // Height doesn't strictly matter for RelativeRect position anchor, but this is safe
    );

    showMenu<InButton>(
      context: context,
      color: color,
      constraints: const BoxConstraints(
        minWidth: menuWidth,
        maxWidth: menuWidth,
      ),
      position: RelativeRect.fromRect(
        centeredRect,
        Offset.zero & overlay.size,
      ),
      items: icons.map((InButton value) {
        return PopupMenuItem<InButton>(
          value: value,
          height: itemHeight, // Increased height for better spacing
          padding: EdgeInsets.zero, // Remove default padding
          child: Center(child: value),
        );
      }).toList(),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ).then((InButton? value) {
      if (value != null) {
        onSelected(value);
      }
    });
  }

  void showCommentDialog(BuildContext context, int index, String comment) {
    TextEditingController commentController =
        TextEditingController(text: comment);

    // Get the current event to preserve its DayType and progress value
    final currentEvent = event;
    final currentDayType = (currentEvent != null && currentEvent.isNotEmpty)
        ? currentEvent[0] as DayType
        : DayType.clear;
    // Preserve progress value for numeric habits
    final progressValue = (currentEvent != null && currentEvent.length > 2)
        ? currentEvent[2]
        : null;

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
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // Build event data preserving progress value for numeric habits
        final List eventData = progressValue != null
            ? [currentDayType, commentController.text, progressValue]
            : [currentDayType, commentController.text];

        Provider.of<HabitsManager>(context, listen: false)
            .addEvent(id, date, eventData);
        parent.events[date] = eventData;
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
    // Preserve existing comment
    final existingComment =
        (event != null && event!.length > 1) ? event![1] as String : '';

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
            // Add progress event preserving existing comment
            Provider.of<HabitsManager>(context, listen: false).addEvent(
                id, date, [DayType.progress, existingComment, progressValue]);
            parent.events[date] = [
              DayType.progress,
              existingComment,
              progressValue
            ];

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

  void _addIncrement(BuildContext context) {
    final habitData = parent.widget.habitData;
    final currentProgress = habitData.getProgressForDate(date);
    final increment = habitData.partialValue;
    final newProgress = currentProgress + increment;
    // Preserve existing comment
    final existingComment =
        (event != null && event!.length > 1) ? event![1] as String : '';

    // Add progress event with the incremented value, preserving comment
    Provider.of<HabitsManager>(context, listen: false)
        .addEvent(id, date, [DayType.progress, existingComment, newProgress]);
    parent.events[date] = [DayType.progress, existingComment, newProgress];

    // Play appropriate sound and show notification
    if (newProgress >= habitData.targetValue) {
      parent.showRewardNotification(date);
      Provider.of<SettingsManager>(context, listen: false).playCheckSound();
    } else {
      Provider.of<SettingsManager>(context, listen: false).playClickSound();
    }

    callback();
  }
}
