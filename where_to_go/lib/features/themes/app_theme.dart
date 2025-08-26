// app_theme.dart
import "package:flutter/material.dart";

abstract interface class AppThemeData {
  ThemeData get light;
  ThemeData get dark;
}

class AppThemeImplementation implements AppThemeData {
  @override
  ThemeData get dark => _buildDarkTheme();

  @override
  ThemeData get light => _buildLightTheme();

  ThemeData _buildLightTheme() {
    return ThemeData(
      primaryColor: Colors.grey[50],
      scaffoldBackgroundColor: Colors.pink[300],
      colorScheme: ColorScheme.light(
        primary: Colors.grey[50]!,
        secondary: Colors.black,
        tertiary: const Color.fromARGB(255, 236, 219, 249),
        surface: const Color.fromARGB(255, 240, 98, 146),
        onPrimary: Colors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        color: Colors.grey[50],
        surfaceTintColor: Colors.grey[50],
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      primaryColor: Colors.grey[800],
      scaffoldBackgroundColor: Colors.grey[900],
      colorScheme: ColorScheme.dark(
        primary: Colors.grey[800]!,
        secondary: Colors.white,
        tertiary: Colors.grey[900],
        surface: Colors.grey[900]!,
        onPrimary: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        color: Colors.grey[800],
        surfaceTintColor: Colors.grey[800],
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, color: Color.fromARGB(255, 245, 245, 245)),
        bodyMedium: TextStyle(fontSize: 14, color: Color.fromARGB(255, 238, 238, 238)),
      ),
    );
  }
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
