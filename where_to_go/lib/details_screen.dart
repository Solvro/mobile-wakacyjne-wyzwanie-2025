import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "features/places/place_details_provider.dart";
import "features/places/places_provider.dart";

class DetailsScreen extends ConsumerWidget {
  static const route = "/details";
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(PlaceProvider(id: id));

    final isFavorited = place.isFavorite;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Icon(
                isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey<bool>(isFavorited),
                color: isFavorited ? Colors.redAccent.shade400 : null,
              ),
            ),
            onPressed: () {
              ref.read(placesProvider.notifier).toggleFavorite(id);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: place.title,
            child: Image.asset(
              place.image.path,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.placeName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                  width: double.infinity,
                ),
                Text(place.placeDescription)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: place.infoColumns
                .map((e) => InfoColumn(
                      icon: e.icon,
                      text: e.text,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(
          height: 4,
        ),
        Text(text)
      ],
    );
  }
}
