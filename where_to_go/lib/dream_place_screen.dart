import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/places/places_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/theme.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final String id;

  const DreamPlaceScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    return themeAsync.when(
      data: (currentTheme) {
        final themePalette = ThemePalette();
        final isFavourited =
            ref.watch(placesProvider.select((places) => places.firstWhere((p) => p.id == id).isFavorite));
        final icon = isFavourited ? Icons.favorite : Icons.favorite_border;

        final places = ref.watch(placesProvider);
        final place = places.firstWhere((p) => p.id == id);

        return Scaffold(
          backgroundColor: themePalette.getPrimaryColor(currentTheme, context),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: themePalette.getSecondaryColor(currentTheme, context), // Set back button color
            ),
            backgroundColor: themePalette.getPrimaryColor(currentTheme, context),
            title: Text(place.name, style: TextStyle(color: themePalette.getSecondaryColor(currentTheme, context))),
            actions: [
              IconButton(
                icon: Icon(
                  icon,
                  color: isFavourited ? Colors.red : themePalette.getSecondaryColor(currentTheme, context),
                  size: 28,
                ),
                onPressed: () async {
                  await ref.read(placesProvider.notifier).toggleFavorite(id);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: themePalette.getPrimaryColor(currentTheme, context),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              place.image.image(
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: ThemePalette().secondaryColor,
                        )),
                    const SizedBox(height: 8),
                    Text(place.description,
                        style: TextStyle(color: themePalette.getSecondaryColor(currentTheme, context))),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: place.attractions.entries
                      .map((entry) => Column(
                            children: [
                              Icon(entry.value, color: themePalette.getSecondaryColor(currentTheme, context)),
                              Text(entry.key,
                                  style: TextStyle(color: themePalette.getSecondaryColor(currentTheme, context))),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading theme")),
    );
  }
}
