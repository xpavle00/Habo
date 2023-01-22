import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habo/constants.dart';

class HaboTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF09BF30),
      colorScheme: ColorScheme.light(
        primaryContainer: Colors.white,
        secondaryContainer: Colors.grey[100],
        primary: HaboColors.primary,
      ),
      fontFamily: GoogleFonts.nunito().fontFamily,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF09BF30),
      ),
      toggleableActiveColor: HaboColors.primary,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: Colors.grey,
      appBarTheme: const AppBarTheme(elevation: 0),
      fontFamily: GoogleFonts.nunito().fontFamily,
      textTheme: ThemeData.dark().textTheme,
      colorScheme: const ColorScheme.dark(
        primaryContainer: Color(0xFF505050),
        secondaryContainer: Color(0xFF353535),
        primary: HaboColors.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF09BF30),
      ),
      toggleableActiveColor: HaboColors.primary,
    );
  }
}
