import 'package:Habo/helpers.dart';
import 'package:Habo/statistics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OverallStatisticsCard extends StatelessWidget {
  const OverallStatisticsCard({Key key, this.total, this.habits})
      : super(key: key);

  final OverallStatisticsData total;
  final int habits;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Container(
              height: 200,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: showingSections(),
                    ),
                    swapAnimationDuration:
                        Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Habits:",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          habits.toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      color: HaboColors.primary,
                    ),
                    Text(
                      total.checks.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.last_page,
                      color: HaboColors.skip,
                    ),
                    Text(
                      total.skips.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.close,
                      color: HaboColors.red,
                    ),
                    Text(
                      total.fails.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: HaboColors.primary,
        value: total.checks.toDouble(),
        badgeWidget: Icon(
          Icons.check,
          color: Colors.white,
        ),
        title: "",
        radius: 25.0,
        titleStyle: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: HaboColors.skip,
        value: total.skips.toDouble(),
        badgeWidget: Icon(
          Icons.last_page,
          color: Colors.white,
        ),
        title: "",
        radius: 25.0,
        titleStyle: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: HaboColors.red,
        value: total.fails.toDouble(),
        badgeWidget: Icon(
          Icons.close,
          color: Colors.white,
        ),
        title: "",
        radius: 25.0,
        titleStyle: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}
