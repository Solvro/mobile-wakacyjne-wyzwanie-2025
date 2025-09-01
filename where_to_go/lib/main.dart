// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/dream_place.dart';
import 'features/theme/theme_provider.dart';
import 'screens/dream_place_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicjalizacja Hive (potrzebne do działania na urządzeniu)
  await Hive.initFlutter();

  // Zarejestruj adapter wygenerowany przez hive_generator
  Hive.registerAdapter(DreamPlaceAdapter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ThemeMode pobieramy globalnie z providera
    final themeMode = ref.watch(themeControllerProvider);

    final light = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      useMaterial3: true,
    );

    final dark = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber, brightness: Brightness.dark),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'Dream Places',
      theme: light,
      darkTheme: dark,
      themeMode: themeMode,
      home: const DreamPlaceScreen(),
    );
  }
}
