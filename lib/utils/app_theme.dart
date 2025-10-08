import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.teal,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 1),
    cardTheme: CardThemeData(
      surfaceTintColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.teal,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    cardTheme: CardThemeData(
      surfaceTintColor: Colors.black,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  );
}
