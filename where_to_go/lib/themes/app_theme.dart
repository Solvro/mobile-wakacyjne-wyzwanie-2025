import "package:flutter/material.dart";

import "app_theme_data.dart";
import "color_palette.dart";

class AppTheme implements AppThemeData {
  @override
  ThemeData get dark => ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: ColorPalette.navyBlueLight,
          surface: ColorPalette.navyBlueDark,
          onSurface: Colors.white70,
          surfaceTint: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.turquoiseLight,
          foregroundColor: Colors.white,
          disabledBackgroundColor: ColorPalette.turquoiseLightDisabled,
          disabledForegroundColor: Colors.white70,
        )),
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.white70)),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.turquoiseLightDisabled)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.turquoiseLightDisabled)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
          labelStyle: TextStyle(color: Colors.white70),
          hintStyle: TextStyle(color: Colors.white70),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white70,
          selectionColor: ColorPalette.turquoiseLightDisabled,
          selectionHandleColor: ColorPalette.turquoiseLightDisabled,
        ),
      );

  @override
  ThemeData get light => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: ColorPalette.iceBlueLight,
          surface: ColorPalette.iceBlueDark,
          surfaceTint: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.greyLight,
          foregroundColor: Colors.black,
          disabledBackgroundColor: ColorPalette.greyLightDisabled,
          disabledForegroundColor: Colors.black,
        )),
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.black)),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.greyLightDisabled)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.greyLightDisabled)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black87,
          selectionColor: ColorPalette.greyLightDisabled,
          selectionHandleColor: ColorPalette.greyLightDisabled,
        ),
      );
}
