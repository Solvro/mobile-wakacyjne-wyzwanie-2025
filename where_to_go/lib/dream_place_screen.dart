import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "feature_icon.dart";
import "place.dart";

class DreamPlaceScreen extends HookWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              isFavorited.value = !isFavorited.value;
            },
            icon: Icon(
              isFavorited.value ? Icons.favorite : Icons.favorite_border,
              color: isFavorited.value ? Colors.red : null,
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
