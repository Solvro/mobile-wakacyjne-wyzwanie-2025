import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/places/places_provider.dart";
import "../models/dream_place.dart";
import "dream_place_screen.dart";

class DreamPlaceListScreen extends ConsumerWidget {
  const DreamPlaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DreamPlace> places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Where2Go"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9,
          children: places.map((place) => DreamPlaceListTile(place: place)).toList(),
        ),
      ),
    );
  }
}

class DreamPlaceListTile extends StatelessWidget {
  const DreamPlaceListTile({super.key, required this.place});

  final DreamPlace place;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoRouter.of(context).push("${DreamPlaceScreen.route}/${place.id}"),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(place.imagePath, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Icon(
                    place.isFavorited ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: place.isFavorited ? Colors.red : const Color(0xFF141414),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
