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

    return themeAsync.when(
      data: (currentTheme) {
        final icon = currentTheme == LocalTheme.light ? Icons.light_mode : Icons.dark_mode;
        return dreamPlacesAsync.when(
          data: (dreamPlaces) {
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
                          for (final place in dreamPlaces)
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
                                        child: Image.asset(
                                          place.image,
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
                                            place.isFavourite ? Icons.favorite : Icons.favorite_border,
                                            color: place.isFavourite
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
          error: (err, stack) => const Center(child: Text("Error loading database")),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading theme")),
    );
  }
}
