import "dart:typed_data";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "features/auth/authentication_repository_provider.dart";
import "features/auth/tokens_provider.dart";
import "features/database/dream_place_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/local_theme_repository.dart";
import "features/theme/theme.dart" show ThemePalette;

class HomeScreen extends ConsumerWidget {
  HomeScreen();

  final palette = ThemePalette();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    final dreamPlacesAsync = ref.watch(dreamPlacesProvider);
    final dreamPlaceRepositoryProviderAsync = ref.read(dreamPlaceRepositoryProvider);

    return dreamPlacesAsync.when(
      data: (data) {
        final dreamPlaces = data.first["results"] as List<dynamic>;
        print("dreamPlaces: $dreamPlaces");
        print("dreamPlaces: $dreamPlaces");
        return themeAsync.when(
            data: (currentTheme) {
              final icon = currentTheme == LocalTheme.light ? Icons.light_mode : Icons.dark_mode;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Scaffold(
                      key: ValueKey(currentTheme),
                      backgroundColor: palette.getPrimaryColor(currentTheme, context),
                      appBar: AppBar(
                        leading: IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: palette.getSecondaryColor(currentTheme, context),
                            size: 28,
                          ),
                          onPressed: () async {
                            await ref.read(authenticationRepositoryProvider).deleteTokens();
                            print("deleting tokens");
                            ref.invalidate(tokensProvider);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: palette.getPrimaryColor(currentTheme, context),
                          ),
                        ),
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
                          // Add tile
                          GestureDetector(
                            onTap: () async => context.push("/add"),
                            child: Card(
                              color: palette.getPrimaryColor(currentTheme, context),
                              shadowColor: palette.getSecondaryColor(currentTheme, context),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child:
                                    Icon(Icons.add, size: 64, color: palette.getSecondaryColor(currentTheme, context)),
                              ),
                            ),
                          ),
                          // One grid item per place, stable key per place
                          ...dreamPlaces.map((place) {
                            final id = place["id"];
                            return GestureDetector(
                              key: ValueKey("place_$id"),
                              onTap: () async => context.push("/details/$id"),
                              child: Card(
                                color: palette.getPrimaryColor(currentTheme, context),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        child: FutureBuilder<Uint8List?>(
                                          future: (() async {
                                            final repo = await ref.read(dreamPlaceRepositoryProvider.future);
                                            final tokens = await ref.read(tokensProvider.future);
                                            final access = tokens.$1; // nullable
                                            return repo.getPhotoBytes(place["imageUrl"] as String, access);
                                          })(),
                                          builder: (context, snap) {
                                            if (snap.connectionState == ConnectionState.waiting) {
                                              return const Center(child: CircularProgressIndicator());
                                            }
                                            final bytes = snap.data;
                                            if (bytes == null || bytes.isEmpty) {
                                              return Container(color: Colors.grey[200]); // placeholder
                                            }
                                            return Image.memory(
                                              bytes,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              gaplessPlayback: true,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              place["name"] as String,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: palette.getSecondaryColor(currentTheme, context),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Icon(
                                            place["isFavourite"] as bool ? Icons.favorite : Icons.favorite_border,
                                            color: place["isFavourite"] as bool
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
                            );
                          }),
                        ],
                      )));
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text("Error: $err"));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading dreamPlaces")),
    );
  }
}
