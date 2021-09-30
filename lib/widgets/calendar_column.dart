import 'package:Habo/provider.dart';
import 'package:Habo/widgets/calendar_header.dart';
import 'package:Habo/widgets/empty_list_image.dart';
import 'package:Habo/widgets/habit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Habit> calendars = Provider.of<Bloc>(context).getAllHabits;

    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
            child: CalendarHeader(),
          ),
        ),
        Expanded(
          child: (calendars.length != 0)
              ? Container(
                  child: ReorderableListView(
                    children: calendars
                        .map(
                          (index) => Container(
                            key: ObjectKey(index),
                            child: index,
                          ),
                        )
                        .toList(),
                    onReorder: (oldIndex, newIndex) {
                      Provider.of<Bloc>(context, listen: false)
                          .reorderList(oldIndex, newIndex);
                    },
                  ),
                )
              : EmptyListImage(),
        ),
      ],
    );
  }
}
