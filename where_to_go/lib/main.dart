import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "app_router.dart";
import "dream_places/details_screen.dart";
import "hive/boxes.dart";
import "hive/dream_place.dart";
import "hive/seed_box.dart";
import "providers/places_provider.dart";
import "providers/theme_provider.dart";
import "theme_preference/theme_preference.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemePreference.init();

  await Hive.initFlutter();
  Hive.registerAdapter(DreamPlaceAdapter());
  Hive.registerAdapter(AttractionAdapter());
  boxDreamPlaces = await Hive.openBox<DreamPlace>("dreamPlaceBox");

  if (boxDreamPlaces.isEmpty) {
    await seedBox(boxDreamPlaces);
  }

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
    return MaterialApp.router(routerConfig: goRouter);
  }
}

// ignore: unreachable_from_main
class HomeScreen extends HookConsumerWidget {
  // ignore: unreachable_from_main
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool getTheme() {
      final bool? theme = ThemePreference.getTheme();
      if (theme != null) {
        return theme;
      } else {
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark;
      }
    }

    final theme = ref.watch(themesProvider);
    final isDark = useState<bool>(getTheme());

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(themesProvider.notifier).toggleTheme(isDark: isDark.value);
      });
      return null;
    }, [isDark.value]);

    final places = ref.watch(placesProvider);

    Future<void> toggleTheme() async {
      isDark.value = !isDark.value;
      await ThemePreference.setTheme(isDark: isDark.value);
      ref.read(themesProvider.notifier).toggleTheme(isDark: isDark.value);
    }

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text("Strona główna", style: TextStyle(color: theme.color)),
          backgroundColor: theme.primary,
          actions: [
            IconButton(
                onPressed: () async {
                  await toggleTheme();
                },
                icon: Icon(isDark.value ? Icons.nightlight : Icons.sunny),
                color: theme.color)
          ],
        ),
        body: ListView(
          children: places
              .map((place) => GestureDetector(
                    onTap: () async {
                      await GoRouter.of(context).push("/${DetailsScreen.route}/${place.id}");
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: theme.primary, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Image.asset(
                            place.image,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            place.placeText,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.color),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ));
  }
}
