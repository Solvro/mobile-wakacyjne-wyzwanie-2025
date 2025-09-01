import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "app_router.dart";
import "features/theme/theme_provider.dart";

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    final light = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      appBarTheme: const AppBarTheme(centerTitle: false),
      useMaterial3: true,
    );

    final dark = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber, brightness: Brightness.dark),
      appBarTheme: const AppBarTheme(centerTitle: false),
      useMaterial3: true,
    );

    return MaterialApp.router(
      title: "Dream Places",
      theme: light,
      darkTheme: dark,
      themeMode: themeMode,
      routerConfig: goRouter,
    );
  }
}
