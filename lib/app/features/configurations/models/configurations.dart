import 'package:flutter/material.dart';

class Configurations {
  final ThemeMode themeMode;
  final Locale locale;

  Configurations({required this.themeMode, required this.locale});

  Configurations.empty()
      : themeMode = ThemeMode.light,
        locale = const Locale("pt", "BR");

  Configurations copyWith({ThemeMode? themeMode, Locale? locale}) {
    return Configurations(
        themeMode: themeMode ?? this.themeMode, locale: locale ?? this.locale);
  }
}
