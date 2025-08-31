import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/database/dream_place_provider.dart";
import "features/places/places_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/theme.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final int id;

  const DreamPlaceScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    final dreamPlacesAsync = ref.watch(dreamPlacesProvider);
    return themeAsync.when(
      data: (currentTheme) {
        final themePalette = ThemePalette();
        return dreamPlacesAsync.when(
          data: (dreamPlaces) {
            final places = ref.watch(placesProvider);
            final place = places.firstWhere((p) => p.id == id.toString());
            final dreamPlace = dreamPlaces.firstWhere((dp) => dp.id == id);
            final isFavourited = dreamPlace.isFavourite;
            final icon = isFavourited ? Icons.favorite : Icons.favorite_border;

            return Scaffold(
              backgroundColor: themePalette.getPrimaryColor(currentTheme, context),
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: themePalette.getSecondaryColor(currentTheme, context), // Set back button color
                ),
                backgroundColor: themePalette.getPrimaryColor(currentTheme, context),
                title: Text(dreamPlace.name,
                    style: TextStyle(color: themePalette.getSecondaryColor(currentTheme, context))),
                actions: [
                  IconButton(
                    icon: Icon(
                      icon,
                      color: isFavourited ? Colors.red : themePalette.getSecondaryColor(currentTheme, context),
                      size: 28,
                    ),
                    onPressed: () async {
                      print("clicking favourite button");
                      await ref.read(toggleDreamPlaceFavouriteProvider(dreamPlace.id).future);
                      ref.invalidate(toggleDreamPlaceFavouriteProvider(id));
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
                        Text(dreamPlace.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: themePalette.getSecondaryColor(currentTheme, context),
                            )),
                        const SizedBox(height: 8),
                        Text(dreamPlace.description,
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
          error: (err, stack) => const Center(child: Text("Error loading dreamPlaces")),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading theme")),
    );
  }
}
