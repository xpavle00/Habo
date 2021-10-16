import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Nunito',
  primaryColor: Colors.grey,
  primaryColorBrightness: Brightness.light,
  dividerColor: Color(0x00FAFAFA),
  unselectedWidgetColor: Colors.black,
  toggleableActiveColor: Color(0xFF09BF30),
  colorScheme: ColorScheme.light(
      primary: Colors.black,
      primaryVariant: Colors.white,
      secondaryVariant: Colors.grey[100],
      onSecondary: Color(0xFF4A4A4A),
      onPrimary: Colors.white),
  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
  iconTheme: IconThemeData(color: Color(0xFF333333)),
  appBarTheme: AppBarTheme(elevation: 0),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Color(0xFF09BF30)),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Color(0xFFD2D1D1)),
    bodyText2: TextStyle(color: Colors.black),
    headline5: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Nunito',
  primaryColorBrightness: Brightness.dark,
  unselectedWidgetColor: Colors.white,
  toggleableActiveColor: Color(0xFF09BF30),
  colorScheme: ColorScheme.dark(
      primary: Colors.white,
      primaryVariant: Color(0xFF505050),
      secondaryVariant: Color(0xFF353535),
      onSecondary: Color(0xFF4A4A4A),
      onPrimary: Colors.black),
  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
  iconTheme: IconThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(elevation: 0),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Color(0xFF09BF30)),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Color(0xFF4A4A4A)),
    bodyText2: TextStyle(color: Colors.white),
    headline5: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
  ),
);
