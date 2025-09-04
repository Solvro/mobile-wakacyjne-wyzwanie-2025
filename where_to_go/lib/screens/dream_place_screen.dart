import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/theme/local_theme_repository.dart";
import "../models/dream_place.dart";
import "../providers/dream_places_provider.dart";
import "../providers/theme_provider.dart";
import "add_place_dialog.dart";

class DreamPlacesScreen extends ConsumerWidget {
  const DreamPlacesScreen({super.key});
  static const routeName = "/";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlaces = ref.watch(dreamPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ulubione miejsca!"),
        actions: [
          PopupMenuButton<ThemeChoice>(
            icon: const Icon(Icons.color_lens),
            onSelected: (choice) async {
              await ref.read(themeControllerProvider.notifier).setChoice(choice);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: ThemeChoice.system,
                child: Text("System"),
              ),
              PopupMenuItem(
                value: ThemeChoice.light,
                child: Text("Jasny"),
              ),
              PopupMenuItem(
                value: ThemeChoice.dark,
                child: Text("Ciemny"),
              ),
            ],
          ),
        ],
      ),
      body: asyncPlaces.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Błąd: $err")),
        data: (places) => places.isEmpty
            ? const Center(child: Text("Brak miejsc — dodaj coś nowego!"))
            : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];

                  return GestureDetector(
                    onTap: () {
                      context.go("/details/${place.id}");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ColoredBox(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          children: [
                            Expanded(
                              child: place.imageUrl.isNotEmpty
                                  ? Image.network(
                                      place.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (c, e, s) => const Center(child: Icon(Icons.broken_image)),
                                    )
                                  : const Center(child: Icon(Icons.image)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      place.name,
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    place.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: place.isFavorite ? Colors.red : Theme.of(context).iconTheme.color,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newPlace = await showDialog<DreamPlace>(
            context: context,
            builder: (_) => const AddPlaceDialog(),
          );
          if (newPlace != null) {
            final repo = ref.read(dreamPlaceRepositoryProvider);
            await repo.addDreamPlace(newPlace);
            ref.invalidate(dreamPlacesProvider); // 🔄 odśwież listę
          }
        },
      ),
    );
  }
}
