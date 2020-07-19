import 'package:Habo/helpers.dart';
import 'package:Habo/provider.dart';
import 'package:Habo/widgets/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class CalendarColumn extends StatefulWidget {
  CalendarColumn({Key key}) : super(key: key);

  @override
  _CalendarColumnState createState() => _CalendarColumnState();
}

class _CalendarColumnState extends State<CalendarColumn> {
  List<Habit> _calendars = [];

  @override
  Widget build(BuildContext context) {
    _calendars = Provider.of<Bloc>(context).getAllHabits;

    return Column(
      children: <Widget>[
        Container(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
              child: CalendarHeader()),
        ),
        Expanded(
          child: (_calendars.length != 0)
              ? Container(
                  child: ReorderableListView(
                    children: _calendars
                        .map((index) => Container(
                              key: ObjectKey(index),
                              child: index,
                            ))
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

class CalendarHeader extends StatelessWidget {
  CalendarHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
    return Container(
        height: 30.0,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: bloc.getWeekStartList.length,
            itemBuilder: (
              BuildContext ctxt,
              int index,
            ) {
              int start = bloc.getWeekStartEnum.index;
              int day = (start + index) % bloc.getWeekStartList.length;
              TextStyle tex = TextStyle(fontSize: 18, color: Colors.grey);
              if (bloc.getWeekStartList[day] == "Sa" ||
                  bloc.getWeekStartList[day] == "Su") {
                tex = TextStyle(fontSize: 18, color: Colors.red[300]);
              }
              return Container(
                  width: (MediaQuery.of(context).size.width - 32) * 0.141,
                  child: Center(
                      child: Text(bloc.getWeekStartList[day], style: tex)));
            }));
  }
}

class EmptyListImage extends StatelessWidget {
  const EmptyListImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToCreatePage(context);
      },
      child: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  child: SvgPicture.asset('assets/images/emptyList.svg',
                      semanticsLabel: 'Empty list'),
                ),
                Text(
                  "Create your first habit.",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
