import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "features/places/places_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/local_theme_repository.dart";
import "features/theme/theme.dart" show ThemePalette;
import "gen/assets.gen.dart";

class HomeScreen extends ConsumerWidget {
  HomeScreen();

  final palette = ThemePalette();

  Widget getImageWidget(dynamic imageSource, LocalTheme currentTheme, BuildContext context) {
    if (imageSource is String) {
      return Image.asset(
        imageSource,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (imageSource is AssetGenImage) {
      return imageSource.image(
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return ColoredBox(
      color: palette.getSecondaryColor(currentTheme, context),
      child: const Icon(Icons.image_not_supported, size: 50),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final themeAsync = ref.watch(localThemeNotifierProvider);
    return themeAsync.when(
      data: (currentTheme) {
        final icon = currentTheme == LocalTheme.light ? Icons.light_mode : Icons.dark_mode;

        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Scaffold(
                key: ValueKey(currentTheme),
                backgroundColor: palette.getPrimaryColor(currentTheme, context),
                appBar: AppBar(
                  title: Text("My Favorite Places",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: palette.getSecondaryColor(currentTheme, context))),
                  actions: [
                    IconButton(
                      icon: Icon(
                        icon,
                        color: palette.getSecondaryColor(currentTheme, context),
                        size: 28,
                      ),
                      onPressed: () async {
                        await ref.read(localThemeNotifierProvider.notifier).toggleTheme();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: palette.getPrimaryColor(currentTheme, context),
                      ),
                    ),
                  ],
                  backgroundColor: palette.getPrimaryColor(currentTheme, context),
                ),
                body: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [
                      for (final place in places)
                        GestureDetector(
                          onTap: () async {
                            await context.push("/details/${place.id}");
                          },
                          child: Card(
                            color: palette.getPrimaryColor(currentTheme, context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: place.image.image(
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          place.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: palette.getSecondaryColor(currentTheme, context),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        place.isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: place.isFavorite
                                            ? Colors.red
                                            : palette.getSecondaryColor(currentTheme, context),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ].toList())));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading theme")),
    );
  }
}
