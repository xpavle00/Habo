import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habo/constants.dart';

class HaboTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      dialogTheme: const DialogThemeData(surfaceTintColor: Colors.white),
      brightness: Brightness.light,
      primaryColor: const Color(0xFF09BF30),
      timePickerTheme: TimePickerThemeData(
        hourMinuteColor: Colors.grey[100],
        dialBackgroundColor: Colors.grey[100],
      ),
      colorScheme: ColorScheme.light(
        primaryContainer: Colors.white,
        secondaryContainer: Colors.grey[100],
        tertiaryContainer: HaboColors.primary,
        onPrimaryContainer: HaboColors.primary,
        primary: HaboColors.primary,
        outline: const Color(0xFF505050),
      ),
      fontFamily: GoogleFonts.nunito().fontFamily,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF09BF30),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xFFFAFAFA),
          systemNavigationBarDividerColor: Color(0xFFFAFAFA),
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF303030),
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF505050),
        surfaceTintColor: Colors.transparent,
      ),
      primaryColor: Colors.grey,
      fontFamily: GoogleFonts.nunito().fontFamily,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith(getSwitchColorThumb),
        trackColor: MaterialStateProperty.resolveWith(getSwitchTrackColor),
      ),
      timePickerTheme: const TimePickerThemeData(
        dayPeriodTextColor: Colors.white,
        hourMinuteColor: Color(0xFF353535),
        dialBackgroundColor: Color(0xFF353535),
        dialTextColor: Colors.white,
        backgroundColor: Color(0xFF505050),
      ),
      colorScheme: const ColorScheme.dark(
        primaryContainer: Color(0xFF505050),
        secondaryContainer: Color(0xFF353535),
        onPrimary: Colors.white,
        tertiaryContainer: HaboColors.primary,
        primary: HaboColors.primary,
        outline: Colors.grey,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF09BF30),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFF303030),
          systemNavigationBarDividerColor: Color(0xFF303030),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }

  static ThemeData get oledTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF282828),
        surfaceTintColor: Colors.transparent,
      ),
      primaryColor: Colors.grey,
      fontFamily: GoogleFonts.nunito().fontFamily,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith(getSwitchColorThumb),
        trackColor: MaterialStateProperty.resolveWith(getSwitchTrackColor),
      ),
      timePickerTheme: const TimePickerThemeData(
        dayPeriodTextColor: Colors.white,
        hourMinuteColor: Color(0xFF191919),
        dialBackgroundColor: Color(0xFF191919),
        dialTextColor: Colors.white,
        backgroundColor: Color(0xFF282828),
      ),
      colorScheme: const ColorScheme.dark(
        primaryContainer: Color(0xFF282828),
        secondaryContainer: Color(0xFF191919),
        tertiaryContainer: HaboColors.primary,
        onPrimary: Colors.white,
        primary: HaboColors.primary,
        outline: Colors.grey,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF09BF30),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarDividerColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }
}

Color getSwitchColorThumb(Set<MaterialState> states) {
  if (states.contains(MaterialState.selected)) {
    return const Color(0xFF303030);
  }

  return Colors.grey;
}

Color getSwitchTrackColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return const Color(0xFF505050);
  }

  if (states.contains(MaterialState.selected)) {
    return HaboColors.primary;
  }

  return const Color(0xFF353535);
}
