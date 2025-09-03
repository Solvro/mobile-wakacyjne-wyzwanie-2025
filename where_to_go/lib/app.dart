// lib/app.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "app_router.dart";
import "providers/theme_provider.dart";

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: "Dream Places",
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: goRouter,
    );
  }
}
