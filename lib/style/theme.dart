import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color accentColor = Color(0xff5568FE);
Brightness statusBarIconBrightness = Brightness.dark;

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  accentColor: accentColor,
  fontFamily: 'exo2',
  textTheme: TextTheme(
    headline5: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: .5,
    ),
    headline6: TextStyle(
      color: Colors.grey[900],
    ),
  ),
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff181920),
  accentColor: accentColor,
  textTheme: TextTheme(
    headline5: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: .5,
    ),
    headline6: TextStyle(
      color: Colors.white,
    ),
  ),
  brightness: Brightness.dark,
);
