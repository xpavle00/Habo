import 'package:Habo/helpers.dart';
import 'package:Habo/provider.dart';
import 'package:Habo/widgets/in_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class OneDayButton extends StatelessWidget {
  const OneDayButton(
      {Key key,
      this.date,
      this.color,
      this.child,
      this.id,
      this.parent,
      this.callback,
      this.event})
      : super(key: key);

  final int id;
  final DateTime date;
  final Color color;
  final Widget child;
  final parent;
  final void Function() callback;
  final event;

  @override
  Widget build(BuildContext context) {
    List<InButton> icons = [
      InButton(
        text: this.child != null
            ? this.child
            : Text(
                this.date.day.toString(),
                textAlign: TextAlign.center,
              ),
      ),
      InButton(
        icon: Icon(
          Icons.check,
          color: HaboColors.primary,
          semanticLabel: 'Check',
        ),
      ),
      InButton(
        icon: Icon(
          Icons.close,
          color: HaboColors.red,
          semanticLabel: 'Fail',
        ),
      ),
      InButton(
        icon: Icon(
          Icons.last_page,
          semanticLabel: 'Skip',
        ),
      ),
      InButton(
        icon: Icon(
          Icons.chat_bubble_outline,
          semanticLabel: 'Comment',
          color: HaboColors.comment,
        ),
      )
    ];

    int index = 0;
    String comment = "";

    if (event != null) {
      if (event[0] != 0) {
        index = (event[0].index);
      }

      if (event.length > 1 && event[1] != null && event[1] != "") {
        comment = (event[1]);
      }
    }

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
            alignment: Alignment.center,
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
              parent.controller.setSelectedDay(date);
            },
            onChanged: (value) {
              if (icons.indexOf(value) > 0 &&
                  icons.indexOf(value) < icons.length - 1) {
                Provider.of<Bloc>(context, listen: false).addEvent(
                    id, date, [DayType.values[icons.indexOf(value)], comment]);
                parent.events[date] = [
                  DayType.values[icons.indexOf(value)],
                  comment
                ];
                if (icons.indexOf(value) == 1) {
                  parent.showRewardNotification(date);
                  Provider.of<Bloc>(context, listen: false).playCheckSound();
                } else {
                  Provider.of<Bloc>(context, listen: false).playClickSound();
                }
              } else if (icons.indexOf(value) == icons.length - 1) {
                showCommentDialog(context, index, comment);
              } else {
                if (comment != null && comment != "") {
                  Provider.of<Bloc>(context, listen: false)
                      .addEvent(id, date, [DayType.Clear, comment]);
                  parent.events[date] = [DayType.Clear, comment];
                } else {
                  Provider.of<Bloc>(context, listen: false)
                      .deleteEvent(id, date);
                  parent.events.remove(date);
                }
              }
              callback();
            },
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
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          child: Column(
            children: [
              Text("Comment"),
              TextField(
                controller: commentController,
                autofocus: true,
                maxLines: 5,
                showCursor: true,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(11),
                  border: InputBorder.none,
                  hintText: "Your comment here",
                ),
              ),
            ],
          ),
        ),
      ),
      btnOkText: "Save",
      btnCancelText: "Close",
      btnCancelColor: Colors.grey,
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Provider.of<Bloc>(context, listen: false).addEvent(
            id, date, [DayType.values[index], commentController.text]);
        parent.events[date] = [DayType.values[index], commentController.text];
        callback();
      },
    )..show();
  }
}
