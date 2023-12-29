import 'package:habo/constants.dart';
import 'package:habo/custom_extensions.dart';

class UserAction {
  final DateTime? dateTime;
  final ActionType action;

  UserAction({
    this.dateTime,
    required this.action,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime?.toUtc().toIso8601String() ??
          DateTime.now().toUtc().toIso8601String(),
      'action': action.toShortString(),
    };
  }
}
