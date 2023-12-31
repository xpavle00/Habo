import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habo/statistics/statistics.dart';

import '../settings/settings_manager.dart';

class OverallStatisticsCard extends StatelessWidget {
  const OverallStatisticsCard(
      {Key? key, required this.total, required this.habits})
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
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: showingSections(context),
                    ),
                    swapAnimationDuration:
                        const Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Habits:",
                          style: TextStyle(
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
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      color:
                          Provider.of<SettingsManager>(context, listen: false)
                              .checkColor,
                    ),
                    Text(
                      total.checks.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.close,
                      color:
                          Provider.of<SettingsManager>(context, listen: false)
                              .failColor,
                    ),
                    Text(
                      total.fails.toString(),
                      style: const TextStyle(
                        fontSize: 24,
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

  List<PieChartSectionData> showingSections(BuildContext context) {
    return [
      if (total.checks != 0)
        PieChartSectionData(
          color:
              Provider.of<SettingsManager>(context, listen: false).checkColor,
          value: total.checks.toDouble(),
          badgeWidget: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          title: "",
          radius: 25.0,
          titleStyle: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      if (total.fails != 0)
        PieChartSectionData(
          color: Provider.of<SettingsManager>(context, listen: false).failColor,
          value: total.fails.toDouble(),
          badgeWidget: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          title: "",
          radius: 25.0,
          titleStyle: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
    ];
  }
}
