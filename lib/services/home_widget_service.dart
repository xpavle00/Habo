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
    Widget currentWidgetLight,
    Widget currentWidgetDark,
    Widget emptyWidgetLight,
    Widget emptyWidgetDark,
  ) async {
    try {
      // Render current state (with today's progress)
      final currentResultLight = await HomeWidget.renderFlutterWidget(
        currentWidgetLight,
        key: _widgetImageKey,
        logicalSize: const Size(170, 170),
      );

      final currentResultDark = await HomeWidget.renderFlutterWidget(
        currentWidgetDark,
        key: '${_widgetImageKey}_dark',
        logicalSize: const Size(170, 170),
      );

      // Render empty state (for next day)
      final emptyResultLight = await HomeWidget.renderFlutterWidget(
        emptyWidgetLight,
        key: '${_widgetImageKey}_empty',
        logicalSize: const Size(170, 170),
      );

      final emptyResultDark = await HomeWidget.renderFlutterWidget(
        emptyWidgetDark,
        key: '${_widgetImageKey}_empty_dark',
        logicalSize: const Size(170, 170),
      );

      // Save both filenames and the last update date
      // Keep legacy keys for compatibility with older native code.
      await HomeWidget.saveWidgetData<String>('filename', currentResultLight);
      await HomeWidget.saveWidgetData<String>(
        'filename_empty',
        emptyResultLight,
      );

      // Theme-aware keys used by updated native widget implementations.
      await HomeWidget.saveWidgetData<String>(
        'filename_light',
        currentResultLight,
      );
      await HomeWidget.saveWidgetData<String>(
        'filename_dark',
        currentResultDark,
      );
      await HomeWidget.saveWidgetData<String>(
        'filename_empty_light',
        emptyResultLight,
      );
      await HomeWidget.saveWidgetData<String>(
        'filename_empty_dark',
        emptyResultDark,
      );
      await HomeWidget.saveWidgetData<String>(
        'lastUpdateDate',
        DateTime.now().toIso8601String(),
      );

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
