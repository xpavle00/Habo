import 'package:flutter/material.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsManager = Provider.of<SettingsManager>(context);
    return SizedBox(
      height: 30.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: settingsManager.getWeekStartList.length,
        itemBuilder: (
          BuildContext ctx,
          int index,
        ) {
          int start = settingsManager.getWeekStartEnum.index;
          int day = (start + index) % settingsManager.getWeekStartList.length;
          TextStyle tex = const TextStyle(fontSize: 18, color: Colors.grey);
          if (settingsManager.getWeekStartList[day] == "Sa" ||
              settingsManager.getWeekStartList[day] == "Su") {
            tex = TextStyle(fontSize: 18, color: Colors.red[300]);
          }
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 32) * 0.141,
            child: Center(
              child: Text(settingsManager.getWeekStartList[day], style: tex),
            ),
          );
        },
      ),
    );
  }
}
