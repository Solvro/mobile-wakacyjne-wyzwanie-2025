import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "feature_icon.dart";
import "features/favorite/favorite_provider.dart";
import "place.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle();
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          place.image.image(
            fit: BoxFit.cover,
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.subtitle, style: textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(place.description, style: textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FeatureIcon(
                icon: Icons.wb_sunny,
                color: Colors.orange,
                label: "Słońce",
              ),
              FeatureIcon(
                icon: Icons.beach_access,
                color: Colors.blueAccent,
                label: "Plaże",
              ),
              FeatureIcon(
                icon: Icons.restaurant,
                color: Colors.red,
                label: "Jedzenie",
              ),
              FeatureIcon(
                icon: Icons.landscape,
                color: Colors.green,
                label: "Widoki",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
