import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme=ThemeData(

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white54,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,

    unselectedLabelStyle: const TextStyle(
      color: Colors.grey,
    ),
    showUnselectedLabels: true,
  ),
  appBarTheme:  const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.blue,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    )
  ),
  scaffoldBackgroundColor: Colors.white,
  primarySwatch:defaultColor,



);