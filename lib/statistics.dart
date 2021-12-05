import 'dart:collection';

import 'package:Habo/helpers.dart';
import 'package:Habo/widgets/habit.dart';

class StatisticsData {
  String title = "";
  int topStreak = 0;
  int actualStreak = 0;
  int checks = 0;
  int skips = 0;
  int fails = 0;
  SplayTreeMap<int, Map<DayType, List<int>>> monthlyCheck = new SplayTreeMap();
}

class OverallStatisticsData {
  int checks = 0;
  int skips = 0;
  int fails = 0;
}

class AllStatistics {
  OverallStatisticsData total = new OverallStatisticsData();
  List<StatisticsData> habitsData = [];
}

// TODO: Make it truly async by running in isolate
class Statistics {
  static Future<AllStatistics> calculateStatistics(List<Habit> _habits) async {
    AllStatistics stats = new AllStatistics();

    if (_habits == null) return stats;

    _habits.forEach(
      (habit) {
        var stat = StatisticsData();
        stat.title = habit.habitData.title;

        bool usingTwoDayRule = false;

        var lastDay = habit.habitData.events.firstKey();

        habit.habitData.events.forEach(
          (key, value) {
            if (value[0] != null && value[0] != DayType.Clear) {
              if (key.difference(lastDay).inDays > 1) {
                stat.actualStreak = 0;
              }

              switch (value[0]) {
                case DayType.Check:
                  stat.checks++;
                  stat.actualStreak++;
                  if (stat.actualStreak > stat.topStreak) {
                    stat.topStreak = stat.actualStreak;
                  }
                  usingTwoDayRule = false;
                  break;
                case DayType.Skip:
                  stat.skips++;
                  if (usingTwoDayRule) {
                    stat.actualStreak = 0;
                  }
                  break;
                case DayType.Fail:
                  stat.fails++;
                  if (habit.habitData.twoDayRule) {
                    if (usingTwoDayRule) {
                      stat.actualStreak = 0;
                    } else {
                      usingTwoDayRule = true;
                    }
                  } else {
                    stat.actualStreak = 0;
                  }
                  break;
              }

              generateYearIfNull(stat, key.year);

              try {
                if (value[0] != DayType.Clear)
                  stat.monthlyCheck[key.year][value[0]][key.month - 1]++;
              } catch (e) {}

              lastDay = key;
            }
          },
        );

        generateYearIfNull(stat, DateTime.now().year);
        stats.habitsData.add(stat);
        stats.total.checks += stat.checks;
        stats.total.fails += stat.fails;
        stats.total.skips += stat.skips;
      },
    );
    return stats;
  }

  static generateYearIfNull(StatisticsData stat, int year) {
    if (stat.monthlyCheck[year] == null) {
      stat.monthlyCheck[year] = {
        DayType.Check: new List.filled(12, 0),
        DayType.Skip: new List.filled(12, 0),
        DayType.Fail: new List.filled(12, 0),
      };
    }
  }
}
