import 'package:flutter/material.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/statistics/monthly_graph.dart';
import 'package:habo/statistics/statistics.dart';
import 'package:provider/provider.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.data,
  });

  final StatisticsData data;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).shadowColor,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      S.of(context).topStreak,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      data.topStreak.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      S.of(context).currentStreak,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      data.actualStreak.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S.of(context).total,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 16,
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
                      data.checks.toString(),
                      style: const TextStyle(
                        fontSize: 22,
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
                      data.progress.toString(),
                      style: const TextStyle(
                        fontSize: 22,
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
                      data.skips.toString(),
                      style: const TextStyle(
                        fontSize: 22,
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
                      data.fails.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            MonthlyGraph(data: data),
          ],
        ),
      ),
    );
  }
}
