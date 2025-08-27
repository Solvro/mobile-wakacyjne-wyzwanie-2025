import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/favorite/favorite_provider.dart";
import "../models/dream_place.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final DreamPlace place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider);

    return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          title: Text(place.name),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(favoriteProvider.notifier).toggle();
                },
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                ),
                color: isFavorited ? Colors.red : const Color(0xFF141414))
          ],
        ),
        body: Column(children: [
          Image.asset(place.imagePath, fit: BoxFit.cover),
          DreamPlaceHeader(
            name: place.name,
            description: place.description,
          ),
          DreamPlaceAttractions(
            attractions: place.attractions,
          )
        ]));
  }
}

class DreamPlaceHeader extends StatelessWidget {
  final String name;
  final String description;

  const DreamPlaceHeader({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF141414),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ));
  }
}

class DreamPlaceAttractions extends StatelessWidget {
  final List<Attraction> attractions;

  const DreamPlaceAttractions({
    super.key,
    required this.attractions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Attractions",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: attractions
              .map((attraction) => DreamPlaceAttractionTile(
                    attraction: attraction,
                  ))
              .toList(),
        )
      ],
    );
  }
}

class DreamPlaceAttractionTile extends StatelessWidget {
  final Attraction attraction;

  const DreamPlaceAttractionTile({
    super.key,
    required this.attraction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(attraction.icon), Text(attraction.label)],
    );
  }
}
