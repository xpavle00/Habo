import 'package:Habo/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarHeader extends StatelessWidget {
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
          BuildContext ctx,
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
              child: Text(bloc.getWeekStartList[day], style: tex),
            ),
          );
        },
      ),
    );
  }
}
