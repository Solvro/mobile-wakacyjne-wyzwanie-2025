import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "app_router.dart";

final baseTheme = ThemeData.light();

final ThemeData customLightTheme = baseTheme.copyWith(
  colorScheme: baseTheme.colorScheme.copyWith(
    primary: const Color(0xFF0D47A1),
    secondary: const Color(0xFF1976D2),
    surface: const Color(0xFFF5F5F5),
  ),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme).copyWith(
    headlineMedium: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Color(0xFF333333),
    ),
    bodyMedium: const TextStyle(
      fontSize: 16,
      height: 1.5,
      color: Color(0xFF555555),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0D47A1),
    foregroundColor: Colors.white,
    elevation: 4,
  ),
  cardTheme: CardThemeData(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

void main() {
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
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Dream Places",
      routerConfig: router,
      theme: customLightTheme,
    );
  }
}
