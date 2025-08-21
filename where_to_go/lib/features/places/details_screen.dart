import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "places_provider.dart";

class DetailsScreen extends ConsumerWidget {
  static const route = "/details";
  const DetailsScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placesProvider).firstWhere((p) => p.id == id);

    return Scaffold(
      backgroundColor: place.backgroundColor,
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            onPressed: () => ref.read(placesProvider.notifier).toggleFavorite(place.id),
            icon: Icon(place.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: place.isFavorite ? Colors.red : null,
            tooltip: place.isFavorite ? "Usuń z ulubionych" : "Dodaj do ulubionych",
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(place.imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(place.description, style: const TextStyle(fontSize: 16, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
