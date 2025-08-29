import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "app_router.dart";
import "features/table/dream_place_providers.dart";
import "features/table/dream_place_repository.dart";
import "features/table/dream_place_table.dart";
import "features/theme/theme_provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  final repo = DreamPlaceRepository(db);

  await repo.seedDatabase();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        dreamPlacesRepositoryProvider.overrideWithValue(repo),
      ],
      child:const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {        
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
    );
  }
}
