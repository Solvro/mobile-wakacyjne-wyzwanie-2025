import "package:flutter/material.dart" hide ThemeMode;
import "package:hooks_riverpod/hooks_riverpod.dart";
import "app/router.dart";
import "app/theme/app_theme.dart";
import "app/theme/theme_mode.dart";
import "app/theme/theme_notifier.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final currentTheme = themeAsync.value ?? ThemeMode.system;
    final themeToSet = (currentTheme == ThemeMode.system)
        ? (MediaQuery.platformBrightnessOf(context) == Brightness.light ? ThemeMode.light : ThemeMode.dark)
        : currentTheme;

    return MaterialApp.router(
      title: "Where to Go",
      theme: themeToSet == ThemeMode.light ? AppTheme().light : AppTheme().dark,
      routerConfig: goRouter,
    );
  }
}
