// ignore_for_file: non_const_argument_for_const_parameter, type=lint
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../auth_provider.dart";
import "../../theme_provider.dart";
import "add_edit_place_screen.dart";
import "places_provider.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    final themeState = ref.watch(themeNotifierProvider);
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    final isSystemDark = systemBrightness == Brightness.dark;
    final isLightMode = themeState.value ?? !isSystemDark;
    final textColor = Theme.of(context).textTheme.bodySmall?.color;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AddEditPlaceScreen.routeName),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Wymarzone Miejsca",
          style: TextStyle(
            color: colors.primary,
            fontFamily: "Roboto",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Odśwież",
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(placesProvider),
          ),
          IconButton(
            tooltip: "Zmień motyw",
            icon: Icon(
              isLightMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).setTheme(!isLightMode);
            },
          ),
          IconButton(
            tooltip: "Wyloguj się",
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: placesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Błąd: $err"),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.invalidate(placesProvider),
                child: const Text("Spróbuj ponownie"),
              ),
            ],
          ),
        ),
        data: (places) {
          if (places.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(placesProvider),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      "Brak miejsc w bazie danych.\nDodaj nowe miejsce przez aplikację!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(placesProvider),
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Dismissible(
                  key: Key(place.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Usuń miejsce'),
                        content: const Text('Czy na pewno chcesz usunąć to miejsce?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Anuluj'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('Usuń', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (_) async {
                    await ref.read(placesRepositoryProvider).deletePlace(place.id!);
                    ref.invalidate(placesProvider);
                  },
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: place.imageUrl.isNotEmpty
                          ? Image.network(
                              place.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.broken_image),
                            )
                          : const Icon(Icons.place, size: 40),
                    ),
                    title: Text(place.name),
                    subtitle: Text(
                      place.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            place.isFavourite ? Icons.favorite : Icons.favorite_border,
                            color: place.isFavourite ? Colors.red : textColor,
                          ),
                          onPressed: () {
                            ref
                                .read(placesNotifierProvider)
                                .toggleFavorite(place.id!, place.isFavourite);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            context.push(
                              AddEditPlaceScreen.routeName,
                              extra: place,
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      unawaited(
                        GoRouter.of(context).push("${DreamPlaceScreen.route}/${place.id}"),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DreamPlaceScreen extends ConsumerWidget {
  static const route = "/details";
  final int id;

  const DreamPlaceScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);
    final ThemeData theme = Theme.of(context);
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: placesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Błąd: $err")),
        data: (places) {
          final place = places.firstWhere(
            (element) => element.id == id,
            orElse: () => throw Exception("Not found"),
          );

          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                place.name,
                style: const TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: theme.appBarTheme.backgroundColor,
              actions: [
                IconButton(
                  icon: Icon(
                    place.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: place.isFavourite ? Colors.red : textColor,
                  ),
                  onPressed: () {
                    ref
                        .read(placesNotifierProvider)
                        .toggleFavorite(place.id!, place.isFavourite);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.push(
                      AddEditPlaceScreen.routeName,
                      extra: place,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Usuń miejsce'),
                        content: const Text('Czy na pewno chcesz usunąć to miejsce?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Anuluj'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('Usuń', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await ref.read(placesRepositoryProvider).deletePlace(place.id!);
                      ref.invalidate(placesProvider);
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 300,
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (place.imageUrl.isNotEmpty)
                              Image.network(
                                place.imageUrl,
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image, size: 100),
                              )
                            else
                              const SizedBox(
                                height: 150,
                                child: Center(child: Icon(Icons.place, size: 80)),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    place.description,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}