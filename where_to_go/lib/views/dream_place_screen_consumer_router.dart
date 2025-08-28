import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/places/places_provider.dart";
import "../themes/utils.dart";

class DreamPlaceScreenConsumerRouter extends ConsumerWidget {
  final String id;
  static String route = "/dream_place";

  const DreamPlaceScreenConsumerRouter({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(placeProvider(id));

    return placeAsync.when(
      data: (place) {
        return Scaffold(
            backgroundColor: context.colorScheme.primary,
            appBar: AppBar(
              backgroundColor: context.colorScheme.surface,
              title: Text(place.title),
              actions: [
                IconButton(
                  onPressed: () async {
                    await ref.read(placesProvider.notifier).toggleFavorite(id);
                  },
                  icon: place.isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                  color: place.isFavorite ? Colors.red : null,
                )
              ],
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    place.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(place.description)
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                for (final attraction in place.attractionList)
                  Column(children: [Icon(attraction.icon), Text(attraction.title)])
              ])
            ])));
      },
      error: (error, stack) => const Center(child: Text("Blad")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
