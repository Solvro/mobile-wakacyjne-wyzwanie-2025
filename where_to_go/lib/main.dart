import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";

import "app_router.dart";

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 100, 180, 255),
    );

    return MaterialApp.router(
      title: "Dream Place App",
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme: appColorScheme,
        scaffoldBackgroundColor: appColorScheme.surfaceContainer,
        cardTheme: CardThemeData(
          color: appColorScheme.surfaceBright,
          elevation: 4,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: appColorScheme.primary,
          foregroundColor: appColorScheme.onPrimary,
          centerTitle: true,
        ),
      ),
      routerConfig: goRouter,
    );
  }
}
