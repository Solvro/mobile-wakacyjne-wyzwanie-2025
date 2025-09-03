import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "app_router.dart";
import "providers/theme_provider.dart";

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: "Dream Places",
      themeMode: themeMode,
      routerConfig: goRouter,
    );
  }
}
