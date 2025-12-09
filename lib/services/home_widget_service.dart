import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomeWidgetService {
  static const String _groupId = 'group.com.pavlenko.Habo';
  static const String _iosWidgetName = 'HaboWidget';
  static const String _androidWidgetName = 'HaboWidget';
  static const String _widgetImageKey = 'widgetImage';

  /// Initialize the home widget with app group ID
  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(_groupId);
  }

  /// Update the home widget with current and empty state widgets
  static Future<void> updateWidget(
    Widget currentWidget,
    Widget emptyWidget,
  ) async {
    try {
      // Render current state (with today's progress)
      final currentResult = await HomeWidget.renderFlutterWidget(
        currentWidget,
        key: _widgetImageKey,
        logicalSize: const Size(170, 170),
      );

      // Render empty state (for next day)
      final emptyResult = await HomeWidget.renderFlutterWidget(
        emptyWidget,
        key: '${_widgetImageKey}_empty',
        logicalSize: const Size(170, 170),
      );

      // Save both filenames and the last update date
      await HomeWidget.saveWidgetData<String>('filename', currentResult);
      await HomeWidget.saveWidgetData<String>('filename_empty', emptyResult);
      await HomeWidget.saveWidgetData<String>(
          'lastUpdateDate', DateTime.now().toIso8601String());

      // Update the widget
      await HomeWidget.updateWidget(
        iOSName: _iosWidgetName,
        androidName: _androidWidgetName,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error updating home widget: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
