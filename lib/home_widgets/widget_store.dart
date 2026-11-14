import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

/// Keys in the App Group shared with the native widgets.
///
/// Each key has exactly one writer (see the iOS widgets design spec):
/// Dart writes [snapshot] and [appliedSeq]; native widget code writes
/// [pendingActions] and [pendingSeq]. Never write a key you don't own.
abstract final class WidgetKeys {
  static const String snapshot = 'widget_snapshot';
  static const String appliedSeq = 'widget_applied_seq';
  static const String pendingActions = 'widget_pending_actions';
  static const String pendingSeq = 'widget_pending_seq';
}

/// Widget kinds registered by the iOS widget extension.
abstract final class WidgetKinds {
  static const String today = 'HaboWidget';
  static const String checkIn = 'HaboCheckInWidget';
  static const String heatmap = 'HaboHeatmapWidget';
  static const String todayList = 'HaboTodayListWidget';
  static const List<String> all = [today, checkIn, heatmap, todayList];
}

/// Android widget providers that draw themselves from the shared snapshot.
abstract final class AndroidWidgetProviders {
  static const String today = 'com.pavlenko.Habo.HaboWidget';
  static const String checkIn =
      'com.pavlenko.Habo.widgets.CheckInWidgetProvider';
  static const String year = 'com.pavlenko.Habo.widgets.YearWidgetProvider';
  static const String todayList =
      'com.pavlenko.Habo.widgets.TodayListWidgetProvider';
  static const List<String> all = [today, checkIn, year, todayList];
}

/// Seam over the shared App Group storage, so widget logic is testable
/// without platform channels.
abstract class WidgetStore {
  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<void> setString(String key, String value);
  Future<void> setInt(String key, int value);

  /// Asks the OS to reload the native widgets: the given kinds on iOS,
  /// every snapshot-drawn provider on Android.
  Future<void> reloadKinds(List<String> iosKinds);
}

/// Production [WidgetStore] backed by the `home_widget` plugin.
class HomeWidgetStore implements WidgetStore {
  const HomeWidgetStore();

  @override
  Future<String?> getString(String key) =>
      HomeWidget.getWidgetData<String>(key);

  @override
  Future<int?> getInt(String key) => HomeWidget.getWidgetData<int>(key);

  @override
  Future<void> setString(String key, String value) async {
    await HomeWidget.saveWidgetData<String>(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await HomeWidget.saveWidgetData<int>(key, value);
  }

  @override
  Future<void> reloadKinds(List<String> iosKinds) async {
    if (kIsWeb) return;
    if (Platform.isIOS) {
      for (final kind in iosKinds) {
        await HomeWidget.updateWidget(iOSName: kind);
      }
    } else if (Platform.isAndroid) {
      for (final provider in AndroidWidgetProviders.all) {
        await HomeWidget.updateWidget(qualifiedAndroidName: provider);
      }
    }
  }
}
