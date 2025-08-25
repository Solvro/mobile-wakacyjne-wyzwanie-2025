import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/places/places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  static const route = "/details";
  final String placeId;

  const DreamPlaceScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == placeId);
    final isFavorited = place.isFavorite;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(placesProvider.notifier).toggleFavorite(place.id);
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text(place.description, style: const TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: place.features
                .map((f) => Column(
                      children: [
                        Icon(f.icon),
                        Text(f.label),
                      ],
                    ))
                .toList(),
          )
        ]),
      ),
    );
  }
}
