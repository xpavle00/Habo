import 'package:Habo/helpers.dart';
import 'package:Habo/statistics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyGraph extends StatefulWidget {
  final StatisticsData data;

  const MonthlyGraph({Key key, this.data}) : super(key: key);

  @override
  State<MonthlyGraph> createState() => _MonthlyGraphState(data);
}

class _MonthlyGraphState extends State<MonthlyGraph> {
  final StatisticsData data;

  bool showCheck = true;
  bool showSkip = false;
  bool showFail = false;
  int year;

  _MonthlyGraphState(this.data) {
    year = data.monthlyCheck.lastKey();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    color: showCheck
                        ? HaboColors.primary
                        : Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 2,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.check,
                          size: 16,
                        ),
                        color: showCheck ? Colors.white : HaboColors.primary,
                        onPressed: () {
                          showCheck = !showCheck;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    color: showSkip
                        ? HaboColors.skip
                        : Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 2,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.last_page,
                          size: 16,
                        ),
                        color: showSkip ? Colors.white : HaboColors.skip,
                        onPressed: () {
                          showSkip = !showSkip;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    color: showFail
                        ? HaboColors.red
                        : Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 2,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.close,
                          size: 16,
                        ),
                        color: showFail ? Colors.white : HaboColors.red,
                        onPressed: () {
                          showFail = !showFail;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: data.monthlyCheck.keys.map((int value) {
                  return new DropdownMenuItem<String>(
                    value: value.toString(),
                    child: new Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                value: year.toString(),
                onChanged: (value) {
                  year = int.parse(value);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Container(
          height: 200,
          child: BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData,
              borderData: borderData,
              barGroups: barGroups(),
              alignment: BarChartAlignment.spaceAround,
              gridData: FlGridData(
                show: false,
              ),
              maxY: 31,
            ),
            swapAnimationDuration: Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
      ],
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              "",
              const TextStyle(
                color: Colors.transparent,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'J';
              case 1:
                return 'F';
              case 2:
                return 'M';
              case 3:
                return 'A';
              case 4:
                return 'M';
              case 5:
                return 'J';
              case 6:
                return 'J';
              case 7:
                return 'A';
              case 8:
                return 'S';
              case 9:
                return 'O';
              case 10:
                return 'N';
              case 11:
                return 'D';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> barGroups() {
    List<BarChartGroupData> result = [];

    double width = 10;
    if (showCheck) width -= 2;
    if (showSkip) width -= 2;
    if (showFail) width -= 2;

    for (int i = 0; i < data.monthlyCheck[year][DayType.Check].length; ++i) {
      result.add(
        BarChartGroupData(
          x: i,
          barRods: [
            if (showCheck)
              BarChartRodData(
                y: data.monthlyCheck[year][DayType.Check][i].toDouble(),
                colors: [HaboColors.primary],
                width: width,
              ),
            if (showSkip)
              BarChartRodData(
                y: data.monthlyCheck[year][DayType.Skip][i].toDouble(),
                colors: [HaboColors.skip],
                width: width,
              ),
            if (showFail)
              BarChartRodData(
                y: data.monthlyCheck[year][DayType.Fail][i].toDouble(),
                colors: [HaboColors.red],
                width: width,
              ),
            if (!showCheck && !showSkip && !showFail)
              BarChartRodData(
                y: 0,
                colors: [Colors.transparent],
                width: 4,
              ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return result;
  }
}
