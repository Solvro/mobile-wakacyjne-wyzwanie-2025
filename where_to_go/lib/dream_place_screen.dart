import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/places/places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final String id;

  const DreamPlaceScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourited = ref.watch(placesProvider.select((places) => places.firstWhere((p) => p.id == id).isFavorite));
    final icon = isFavourited ? Icons.favorite : Icons.favorite_border;

    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        actions: [
          IconButton(
            icon: Icon(
              icon,
              color: isFavourited ? Colors.red : Colors.black,
              size: 28,
            ),
            onPressed: () async {
              await ref.read(placesProvider.notifier).toggleFavorite(id);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
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
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text(place.description),
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
                          Icon(entry.value),
                          Text(entry.key),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
