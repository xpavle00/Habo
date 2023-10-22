import 'package:flutter/material.dart';
import 'package:habo/extensions.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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
        itemCount: StartingDayOfWeek.values.length,
        itemBuilder: (
          BuildContext ctx,
          int index,
        ) {
          int start = settingsManager.getWeekStartEnum.index;
          int day = (start + index) % StartingDayOfWeek.values.length;
          TextStyle tex = const TextStyle(fontSize: 18, color: Colors.grey);
          if (day == 5 || day == 6) // Sat or Sun
          {
            tex = TextStyle(fontSize: 18, color: Colors.red[300]);
          }
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 32) * 0.141,
            child: Center(
              child: Text(
                  DateFormat('E', Intl.getCurrentLocale())
                      .dateSymbols
                      .WEEKDAYS[(day + 1) % 7]
                      .substring(0, 2)
                      .capitalize(),
                  style: tex),
            ),
          );
        },
      ),
    );
  }
}
