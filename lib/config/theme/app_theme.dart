import 'package:flutter/material.dart';

/*
  Apptheme is a class which contains global styles for widgets, fonts and styles.
*/

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w600),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          )),
      useMaterial3: true,
      colorSchemeSeed: Colors.green.shade600,
    );
  }
}
