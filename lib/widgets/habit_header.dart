import 'package:Habo/widgets/habit.dart';
import 'package:flutter/material.dart';

import 'package:Habo/helpers.dart';

class HabitHeader extends StatelessWidget {
  const HabitHeader({
    Key key,
    @required this.name,
    @required this.widget,
    @required bool streakVisible,
    @required bool orangeStreak,
    @required int streak,
  })  : _streakVisible = streakVisible,
        _orangeStreak = orangeStreak,
        _streak = streak,
        super(key: key);

  final String name;
  final Habit widget;
  final bool _streakVisible;
  final bool _orangeStreak;
  final int _streak;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
          constraints:
              BoxConstraints(minHeight: 36, minWidth: 36, maxHeight: 48),
          icon: Icon(
            Icons.edit_outlined,
            semanticLabel: 'Modify',
          ),
          color: Colors.grey,
          tooltip: 'Modify',
          onPressed: () {
            //createAlertDialog(context);
            widget.navigateToEditPage(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
          child: Visibility(
            visible: _streakVisible,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: (this._orangeStreak)
                        ? HaboColors.orange
                        : HaboColors.primary,
                  ),
                  color: (this._orangeStreak)
                      ? HaboColors.orange
                      : HaboColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset.fromDirection(1, 3),
                        color: Color(0x21000000))
                  ]),
              alignment: Alignment.center,
              child: Text(
                "$_streak",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
