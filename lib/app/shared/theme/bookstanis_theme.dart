import 'package:flutter/material.dart';

class BookstanisTheme {
  static final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(centerTitle: true),
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, brightness: Brightness.dark));

  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(centerTitle: true),
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, brightness: Brightness.light));
}
