import "package:flutter/material.dart";
import "local_theme_repository.dart";

class ThemePalette {
  final ThemeRepository themeRepository = LocalThemeRepository();
  late Future<LocalTheme> currentTheme;
  Color primaryColor = Colors.black;
  Color secondaryColor = Colors.white;
  Color tertiaryColor = Colors.grey;

  ThemePalette() {
    currentTheme = themeRepository.getTheme();
  }

  Color getPrimaryColor(LocalTheme theme, BuildContext context) {
    switch (theme) {
      case LocalTheme.light:
        return Colors.white;
      case LocalTheme.dark:
        return Colors.black;
      case LocalTheme.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark ? Colors.black : Colors.white;
    }
  }

  Color getSecondaryColor(LocalTheme theme, BuildContext context) {
    switch (theme) {
      case LocalTheme.light:
        return Colors.black;
      case LocalTheme.dark:
        return Colors.white;
      case LocalTheme.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark ? Colors.white : Colors.black;
    }
  }

  Color getTertiaryColor(LocalTheme theme) {
    return Colors.grey;
  }
}
