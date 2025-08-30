import "package:flutter/material.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();
  ThemeData get dark => ThemeData.dark();
}

class AppTheme implements AppThemeData {
  @override
  ThemeData get dark => ThemeData(
        colorScheme: const ColorScheme.dark(
          surface: Color.fromARGB(255, 4, 40, 38),
          onSurface: Color.fromARGB(255, 189, 220, 218),
          secondary: Color.fromARGB(255, 224, 224, 231),
          onSecondary: Color.fromARGB(255, 43, 43, 44),
          tertiary: Color.fromARGB(255, 226, 67, 67),
          shadow: Color.fromARGB(25, 219, 219, 221),
          error: Color.fromARGB(255, 212, 84, 84),
        ),
        textTheme: _textTheme,
      );

  @override
  ThemeData get light => ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Color.fromARGB(255, 189, 220, 218),
          onSurface: Color.fromARGB(255, 4, 40, 38),
          secondary: Color.fromARGB(255, 43, 43, 44),
          onSecondary: Color.fromARGB(255, 224, 224, 231),
          tertiary: Color.fromARGB(255, 118, 13, 13),
          shadow: Color.fromARGB(25, 43, 43, 44),
          error: Color.fromARGB(255, 173, 48, 48),
        ),
        textTheme: _textTheme,
      );

  static const _textTheme = TextTheme(
    titleMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
