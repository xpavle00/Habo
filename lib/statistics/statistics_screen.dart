import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habo/statistics/statistics.dart';
import 'package:habo/statistics/statistics_card.dart';
import '../constant_helpers/constants.dart';
import '../habits/habits_manager.dart';
import '../navigation/routes.dart';
import 'empty_statistics_image.dart';
import 'overall_statistics_card.dart';

class StatisticsScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Routes.statisticsPath,
      key: ValueKey(Routes.statisticsPath),
      child: const StatisticsScreen(),
    );
  }

  const StatisticsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Statistics',
        ),
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: FutureBuilder(
          future: Provider.of<HabitsManager>(context).getFutureStatsData(),
          builder:
              (BuildContext context, AsyncSnapshot<AllStatistics> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: HaboColors.primary,
                ),
              );
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Center(
                child: Text('Error loading data'),
              );
            } else if (snapshot.data!.habitsData.isEmpty) {
              return const SizedBox(child: EmptyStatisticsImage());
            } else {
              // Your existing code for rendering statistics data
            }
            if (snapshot.hasData) {
              if (snapshot.data!.habitsData.isEmpty) {
                return const SizedBox(child: EmptyStatisticsImage());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          child: OverallStatisticsCard(
                            total: snapshot.data!.total,
                            habits: snapshot.data!.habitsData.length,
                          ),
                        ),
                        //dulpicate id found error
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: snapshot.data!.habitsData
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: StatisticsCard(
                                          data: e,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: HaboColors.primary,
                ),
              );
            }
          }),
    );
  }
}
