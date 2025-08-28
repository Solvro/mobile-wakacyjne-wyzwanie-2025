import "package:flutter/material.dart";

import "app_theme_data.dart";
import "color_palette.dart";

class AppTheme implements AppThemeData {
  @override
  ThemeData get dark => ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: ColorPalette.navyBlueLight,
          surface: ColorPalette.navyBlueDark,
          surfaceTint: Colors.transparent,
        ),
      );

  @override
  ThemeData get light => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: ColorPalette.iceBlueLight,
          surface: ColorPalette.iceBlueDark,
          surfaceTint: Colors.transparent,
        ),
      );
}
