import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "theme.dart";
import "theme_provider.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Zwykły ProviderScope wystarczy, bo nie inicjalizujemy już ręcznie bazy danych
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);

    final ThemeMode themeMode = themeState.when(
      data: (isLight) {
        if (isLight == true) return ThemeMode.light;
        if (isLight == false) return ThemeMode.dark;
        return ThemeMode.system;
      },
      loading: () => ThemeMode.light,
      error: (_, __) => ThemeMode.light,
    );

    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      title: "Wymarzone Miejsca",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
    );
  }
}