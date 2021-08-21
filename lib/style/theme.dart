import 'package:flutter/material.dart';

Color accentColor = Color(0xff5568FE);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  accentColor: accentColor,
  fontFamily: 'exo2',
  cardColor: Colors.white,
  textTheme: TextTheme(
    headline5: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: .5,
    ),
    headline6: TextStyle(
      color: Colors.grey[900],
    ),
    subtitle1: TextStyle(
      color: Colors.grey[600],
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: .5,
    ),
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(),
    brightness: Brightness.light,
    actionsIconTheme: IconThemeData(),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff181920),
  accentColor: accentColor,
  fontFamily: 'exo2',
  cardColor: Color(0xff252A34),
  textTheme: TextTheme(
    headline5: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: .5,
    ),
    headline6: TextStyle(
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      color: Colors.grey[600],
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: .5,
    ),
  ),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(),
    brightness: Brightness.dark,
    actionsIconTheme: IconThemeData(),
  ),
);
