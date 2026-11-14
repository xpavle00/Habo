import 'package:home_widget/home_widget.dart';

class HomeWidgetService {
  static const String _groupId = 'group.com.pavlenko.Habo';

  /// Points `home_widget` at the App Group the iOS widgets read from.
  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(_groupId);
  }
}
