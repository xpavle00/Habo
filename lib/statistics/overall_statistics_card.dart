import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/statistics/statistics.dart';
import 'package:provider/provider.dart';

class OverallStatisticsCard extends StatelessWidget {
  const OverallStatisticsCard(
      {super.key, required this.total, required this.habits});

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
                    duration: const Duration(milliseconds: 150), // Optional
                    curve: Curves.linear, // Optional
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).habits,
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
            const SizedBox(
              height: 22,
            ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
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
                const SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      color:
                          Provider.of<SettingsManager>(context, listen: false)
                              .progressColor,
                    ),
                    Text(
                      total.progress.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.last_page,
                      color:
                          Provider.of<SettingsManager>(context, listen: false)
                              .skipColor,
                    ),
                    Text(
                      total.skips.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
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
          color: Provider.of<SettingsManager>(context).checkColor,
          value: total.checks.toDouble(),
          badgeWidget: Icon(
            Icons.check,
            color: Provider.of<SettingsManager>(context).iconColor,
          ),
          title: '',
          radius: 25.0,
          titleStyle: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      if (total.skips != 0)
        PieChartSectionData(
          color: Provider.of<SettingsManager>(context).skipColor,
          value: total.skips.toDouble(),
          badgeWidget: Icon(
            Icons.last_page,
            color: Provider.of<SettingsManager>(context).iconColor,
          ),
          title: '',
          radius: 25.0,
          titleStyle: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      if (total.progress != 0)
        PieChartSectionData(
          color: Provider.of<SettingsManager>(context).progressColor,
          value: total.progress.toDouble(),
          badgeWidget: Icon(
            Icons.trending_up,
            color: Provider.of<SettingsManager>(context).iconColor,
          ),
          title: '',
          radius: 25.0,
          titleStyle: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      if (total.fails != 0)
        PieChartSectionData(
          color: Provider.of<SettingsManager>(context).failColor,
          value: total.fails.toDouble(),
          badgeWidget: Icon(
            Icons.close,
            color: Provider.of<SettingsManager>(context).iconColor,
          ),
          title: '',
          radius: 25.0,
          titleStyle: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
    ];
  }
}
