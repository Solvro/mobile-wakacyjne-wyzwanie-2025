import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_router.dart';

import 'theme/app.theme.dart';
import 'theme/local_theme.dart';
import 'theme/providers.dart';

import 'features/places/dreamplace.dart';
import 'features/places/dreamplace_adapter.dart';
import 'features/places/dreamplacerep.dart' show DreamPlacesRepositoryHive;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(DreamPlaceAdapter());
  final box = await Hive.openBox<DreamPlace>(DreamPlacesRepositoryHive.boxName);

  final repo = DreamPlacesRepositoryHive(box);
  await repo.seedIfEmpty();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChoice = ref.watch(themeChoiceProvider);

    if (themeChoice.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final choice = themeChoice.value ?? AppThemeChoice.system;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: mapChoiceToThemeMode(
        choice,
        MediaQuery.platformBrightnessOf(context),
      ),
    );
  }
}
