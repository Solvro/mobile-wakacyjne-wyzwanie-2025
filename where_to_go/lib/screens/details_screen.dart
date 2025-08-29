import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../features/places/places_provider.dart";

class DetailsScreen extends ConsumerWidget {
  static const route = "/details";
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placesProvider).firstWhere((p) => p.id == id);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8DD),
      appBar: AppBar(
        title: Text(place.title),
        backgroundColor: Colors.amber[200],
        actions: [
          IconButton(
            icon: Icon(place.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: place.isFavorite ? Colors.red : Colors.white,
            onPressed: () {
              ref.read(placesProvider.notifier).toggleFavorite(id);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            place.imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
          const SizedBox(height: 20),
          Text(place.title, style: const TextStyle(fontSize: 32)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              place.description,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
