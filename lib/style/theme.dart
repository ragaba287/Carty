import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color accentColor = Color(0xff5568FE);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  accentColor: accentColor,
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
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: accentColor),
    titleTextStyle: TextStyle(color: Colors.black),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
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
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: accentColor),
    titleTextStyle: TextStyle(color: Colors.white),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff181920),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
);
