import 'package:flutter/material.dart';

List<String> months = [
  "",
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

enum Themes { device, light, dark, oled }

enum DayType { clear, check, fail, skip }

class HaboColors {
  static const Color primary = Color(0xFF09BF30);
  static const Color red = Color(0xFFF44336);
  static const Color skip = Color(0xFFFBC02D);
  static const Color orange = Color(0xFFFF9800);
}
