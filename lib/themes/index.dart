import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';

class AppTheme {
  //
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColorLight: Colors.grey[300],
    primaryColorDark: Colors.blue[50],
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Colors.red,
    ),
    cardTheme: const CardTheme(
      color: Color(0xfff5f8fd),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Colors.black87,
      ),
      displayLarge: TextStyle(
        color: Colors.black87,
      ),
      displaySmall: TextStyle(color: Colors.black87),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor, foregroundColor: Colors.white),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    primaryColorLight: Colors.grey[900],
    primaryColorDark: Colors.grey[700],
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      secondary: Colors.black45,
    ),
    cardTheme: const CardTheme(
      color: Color(0xfff5f8fd),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white70,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Colors.white70,
      ),
      displayLarge: TextStyle(
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  );
}
