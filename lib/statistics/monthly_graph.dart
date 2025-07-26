import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/statistics/statistics.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MonthlyGraph extends StatefulWidget {
  final StatisticsData data;

  const MonthlyGraph({super.key, required this.data});

  @override
  State<MonthlyGraph> createState() => _MonthlyGraphState();
}

class _MonthlyGraphState extends State<MonthlyGraph> {
  bool showCheck = true;
  bool showSkip = true;
  bool showFail = true;
  int year = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    year = widget.data.monthlyCheck.lastKey()!;
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
                        ? Provider.of<SettingsManager>(context, listen: false)
                            .checkColor
                        : Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 2,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: const Icon(
                          Icons.check,
                          size: 16,
                        ),
                        color: showCheck
                            ? Colors.white
                            : Provider.of<SettingsManager>(context,
                                    listen: false)
                                .checkColor,
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
                        ? Provider.of<SettingsManager>(context, listen: false)
                            .skipColor
                        : Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 2,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: const Icon(
                          Icons.last_page,
                          size: 16,
                        ),
                        color: showSkip
                            ? Colors.white
                            : Provider.of<SettingsManager>(context,
                                    listen: false)
                                .skipColor,
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
                        ? Provider.of<SettingsManager>(context, listen: false)
                            .failColor
                        : Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 2,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                        ),
                        color: showFail
                            ? Colors.white
                            : Provider.of<SettingsManager>(context,
                                    listen: false)
                                .failColor,
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
                items: widget.data.monthlyCheck.keys.map((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                value: year.toString(),
                onChanged: (value) {
                  year = int.parse(value!);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 150,
          child: BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData,
              borderData: borderData,
              barGroups: barGroups(),
              alignment: BarChartAlignment.spaceAround,
              gridData: const FlGridData(
                show: false,
              ),
              maxY: 31,
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.linear,
          ),
        ),
      ],
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              '',
              const TextStyle(
                color: Colors.transparent,
                fontSize: 0,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, reservedSize: 30, getTitlesWidget: getTitles),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 58, 114, 182),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    text = DateFormat('M', Intl.getCurrentLocale())
        .dateSymbols
        .NARROWMONTHS[value.toInt()]
        .toUpperCase();
    return SideTitleWidget(
      space: 4,
      meta: meta,
      child: Text(text, style: style),
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> barGroups() {
    List<BarChartGroupData> result = [];

    double width = 10;
    if (showCheck) width -= 2;
    if (showSkip) width -= 2;
    if (showFail) width -= 2;

    if (widget.data.monthlyCheck.isNotEmpty) {
      for (int i = 0;
          i < widget.data.monthlyCheck[year]![DayType.check]!.length;
          ++i) {
        result.add(
          BarChartGroupData(
            x: i,
            barRods: [
              if (showCheck)
                BarChartRodData(
                  toY: widget.data.monthlyCheck[year]![DayType.check]![i]
                      .toDouble(),
                  color: Provider.of<SettingsManager>(context, listen: false)
                      .checkColor,
                  width: width,
                ),
              if (showSkip)
                BarChartRodData(
                  toY: widget.data.monthlyCheck[year]![DayType.skip]![i]
                      .toDouble(),
                  color: Provider.of<SettingsManager>(context, listen: false)
                      .skipColor,
                  width: width,
                ),
              if (showFail)
                BarChartRodData(
                  toY: widget.data.monthlyCheck[year]![DayType.fail]![i]
                      .toDouble(),
                  color: Provider.of<SettingsManager>(context, listen: false)
                      .failColor,
                  width: width,
                ),
              if (!showCheck && !showSkip && !showFail)
                BarChartRodData(
                  toY: 0,
                  color: Colors.transparent,
                  width: 4,
                ),
            ],
            showingTooltipIndicators: [0],
          ),
        );
      }
    } else {
      result.add(
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              width: width,
              toY: 0,
            ),
          ],
        ),
      );
    }
    return result;
  }
}
