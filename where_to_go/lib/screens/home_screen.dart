import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../providers.dart";
import "../theme/local_theme_repository.dart";
import "../theme/theme_notifier.dart";
import "details_screen.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(allPlacesProvider);
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);

    final Widget body = switch (places) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(child: Text("Error: $error")),
      AsyncData(:final value) => GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3 / 2,
          ),
          itemCount: value.length,
          itemBuilder: (context, index) {
            final place = value[index];
            return GestureDetector(
              onTap: () async {
                await context.push("${DetailsScreen.route}/${place.id}");
              },
              child: Card(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: place.title,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                              child: Image.network(
                                place.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            place.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () async {
                          final repo = ref.read(repositoryProvider);
                          await repo.updateFavorite(place.id, isFavorite: !place.isFavorite);
                          ref.invalidate(placeDetailsProvider(place.id));
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(6, 6, 6, 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(175),
                            shape: BoxShape.circle,
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                            child: Icon(
                              place.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              key: ValueKey<bool>(place.isFavorite),
                              color: place.isFavorite ? Colors.redAccent.shade400 : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      _ => const Center(child: Text("No places found")),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista miejsc"),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeNotifierProvider).value == AppThemeMode.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
            ),
            onPressed: themeNotifier.toggleTheme,
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Strona główna",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: "Ulubione",
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        onTap: (index) {
          if (index == 0) {
            context.go("/");
          } else if (index == 1) {
            context.go("/favorites");
          }
        },
      ),
    );
  }
}
