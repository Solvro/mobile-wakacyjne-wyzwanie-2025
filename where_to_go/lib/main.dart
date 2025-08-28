import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "app_router.dart";
import "data/data.dart";
import "data_classes/place.dart";
import "dream_places/details_screen.dart";
import "gen/assets.gen.dart";
import "providers/places_provider.dart";
import "providers/theme_provider.dart";
import "theme_preference/theme_preference.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemePreference.init();

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
    final theme = ref.watch(themesProvider);
    final places;

    bool getTheme() {
      final bool? theme = ThemePreference.getTheme();
      if (theme != null) {
        return theme;
      } else {
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark;
      }
    }

    final isDark = useState<bool>(getTheme());

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(themesProvider.notifier).toggleTheme(isDark: isDark.value);
      });
      return null;
    }, [isDark.value]);

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
