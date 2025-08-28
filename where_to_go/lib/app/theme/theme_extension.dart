import "package:flutter/material.dart" hide ThemeMode;
import "package:hooks_riverpod/hooks_riverpod.dart";

import "theme_mode.dart";
import "theme_notifier.dart";

extension SetThemeExtension on BuildContext {
  ThemeMode setTheme(WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final currentTheme = themeAsync.value ?? ThemeMode.system;
    return (currentTheme == ThemeMode.system)
        ? (MediaQuery.platformBrightnessOf(this) == Brightness.light ? ThemeMode.light : ThemeMode.dark)
        : currentTheme;
  }
}
