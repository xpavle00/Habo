import 'package:habo/constants.dart';

extension ParseToString on ActionType {
  String toShortString() {
    return toString().split('.').last;
  }
}
