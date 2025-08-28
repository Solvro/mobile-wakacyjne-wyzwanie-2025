import "package:flutter/material.dart";

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => MediaQuery.platformBrightnessOf(this) == Brightness.dark;
}
