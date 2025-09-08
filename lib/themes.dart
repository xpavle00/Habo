import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habo/constants.dart';

class HaboTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll<Color>(
          Colors.grey,
        )),
      ),
      dialogTheme: const DialogThemeData(surfaceTintColor: Colors.white),
      brightness: Brightness.light,
      primaryColor: const Color(0xFF09BF30),
      timePickerTheme: TimePickerThemeData(
        hourMinuteColor: Colors.grey[100],
        dialBackgroundColor: Colors.grey[100],
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.withAlpha(50),
      ),
      colorScheme: ColorScheme.light(
        primaryContainer: Colors.white,
        secondaryContainer: Colors.grey[100],
        tertiaryContainer: HaboColors.primary,
        onPrimaryContainer: HaboColors.primary,
        onPrimary: Color(0xFF505050),
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
      listTileTheme: ListTileThemeData(
        titleTextStyle: ThemeData.light().textTheme.titleMedium,
        subtitleTextStyle: ThemeData.light().textTheme.bodyMedium,
      ),
      canvasColor: Colors.white,
      focusColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF303030),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll<Color>(
          Colors.grey,
        )),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF505050),
        surfaceTintColor: Colors.transparent,
      ),
      primaryColor: Colors.grey,
      fontFamily: GoogleFonts.nunito().fontFamily,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(getSwitchColorThumb),
        trackColor: WidgetStateProperty.resolveWith(getSwitchTrackColor),
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
      listTileTheme: ListTileThemeData(
        titleTextStyle: ThemeData.dark().textTheme.titleMedium,
        subtitleTextStyle: ThemeData.dark().textTheme.bodyMedium,
      ),
      canvasColor: Color(0xFF505050),
      focusColor: Color(0xFF505050),
    );
  }

  static ThemeData get oledTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll<Color>(
          Colors.grey,
        )),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF282828),
        surfaceTintColor: Colors.transparent,
      ),
      primaryColor: Colors.grey,
      fontFamily: GoogleFonts.nunito().fontFamily,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(getSwitchColorThumb),
        trackColor: WidgetStateProperty.resolveWith(getSwitchTrackColor),
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
      listTileTheme: ListTileThemeData(
        titleTextStyle: ThemeData.dark().textTheme.titleMedium,
        subtitleTextStyle: ThemeData.dark().textTheme.bodyMedium,
      ),
      canvasColor: Color(0xFF282828),
      focusColor: Color(0xFF282828),
    );
  }

  static ThemeData get draculaTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: draculaBackground,
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: draculaYellow),
        titleMedium: TextStyle(color: draculaYellow),
        titleSmall: TextStyle(color: draculaYellow),
        labelLarge: TextStyle(color: draculaPink),
        labelMedium: TextStyle(color: draculaPink),
        labelSmall: TextStyle(color: draculaPink),
        bodyLarge: TextStyle(color: draculaForeground),
        bodyMedium: TextStyle(color: draculaForeground),
        bodySmall: TextStyle(color: draculaForeground),
        displayLarge: TextStyle(color: draculaGreen),
        displayMedium: TextStyle(color: draculaGreen),
        displaySmall: TextStyle(color: draculaGreen),
        headlineLarge: TextStyle(color: draculaPurple),
        headlineMedium: TextStyle(color: draculaPurple),
        headlineSmall: TextStyle(color: draculaPurple),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll<Color>(Color(0xFFFF79C6))),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: draculaSelection,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF21222C),
        surfaceTintColor: Colors.transparent,
      ),
      primaryColor: Colors.grey,
      fontFamily: GoogleFonts.nunito().fontFamily,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(getSwitchColorThumb),
        trackColor: WidgetStateProperty.resolveWith(getSwitchTrackDraculaColor),
      ),
      timePickerTheme: const TimePickerThemeData(
        dayPeriodTextColor: draculaGreen,
        hourMinuteColor: draculaGreen,
        dialBackgroundColor: Color(0xFF191919),
        dialTextColor: Colors.white,
        backgroundColor: draculaBackground,
      ),
      colorScheme: const ColorScheme.dark(
        primaryContainer: draculaBackground,
        secondaryContainer: Color(0xFF191919),
        tertiaryContainer: draculaGreen,
        onPrimary: draculaForeground,
        primary: draculaPink,
        outline: draculaSelection,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: draculaPurple,
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
        iconTheme: IconThemeData(color: draculaPurple),
        actionsIconTheme: IconThemeData(color: draculaOrange),
        titleTextStyle: TextStyle(
          color: draculaYellow,
          fontSize: 20,
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(draculaGreen),
          textStyle: WidgetStatePropertyAll<TextStyle>(
            const TextStyle(color: draculaRed),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: ThemeData.dark().textTheme.titleMedium?.copyWith(
              color: draculaYellow,
            ),
        subtitleTextStyle: ThemeData.dark().textTheme.bodyMedium?.copyWith(
              color: draculaCyan,
            ),
      ),
      canvasColor: Color(0xFF282828),
      focusColor: draculaSelection,
    );
  }
}

Color getSwitchColorThumb(Set<WidgetState> states) {
  if (states.contains(WidgetState.selected)) {
    return const Color(0xFF303030);
  }

  return Colors.grey;
}

Color getSwitchTrackColor(Set<WidgetState> states) {
  const Set<WidgetState> interactiveStates = <WidgetState>{
    WidgetState.pressed,
    WidgetState.hovered,
    WidgetState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return const Color(0xFF505050);
  }

  if (states.contains(WidgetState.selected)) {
    return HaboColors.primary;
  }

  return const Color(0xFF353535);
}

Color getSwitchTrackDraculaColor(Set<WidgetState> states) {
  const Set<WidgetState> interactiveStates = <WidgetState>{
    WidgetState.pressed,
    WidgetState.hovered,
    WidgetState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return const Color(0xFF505050);
  }

  if (states.contains(WidgetState.selected)) {
    return Color(0xFFFF5555);
  }

  return const Color(0xFF353535);
}

const draculaBackground = Color(0xFF282A36);
const draculaForeground = Color(0xFFF8F8F2);
const draculaYellow = Color(0xFFF1FA8C);
const draculaRed = Color(0xFFFF5555);
const draculaPink = Color(0xFFFF79C6);
const draculaOrange = Color(0xFFFFB86C);
const draculaGreen = Color(0xFF50FA7B);
const draculaPurple = Color(0xFFBD93F9);
const draculaSelection = Color(0xFF44475A);
const draculaCyan = Color(0xFF8BE9FD);
