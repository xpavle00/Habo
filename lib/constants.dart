import 'package:flutter/material.dart';

enum Themes { device, light, dark, oled, materialYou }

enum HabitType { boolean, numeric }

enum DayType { clear, check, fail, skip, progress }

class HaboColors {
  static const Color primary = Color(0xFF09BF30);
  static const Color red = Color(0xFFF44336);
  static const Color skip = Color(0xFFFBC02D);
  static const Color orange = Color(0xFFFF9800);
  static const Color progress = Color(0xFF2196F3);
  static const Color progressBackground = Color(0xFFE3F2FD);
}
