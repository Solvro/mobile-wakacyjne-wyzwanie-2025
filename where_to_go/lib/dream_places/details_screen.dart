import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../providers/places_provider.dart";

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({required this.id, super.key});
  final String id;

  static String get route => "DetailsScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placesProvider)[int.parse(id)];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 123, 144, 118),
      appBar: AppBar(
        title: Text(place.placeText, style: const TextStyle(color: Color.fromARGB(255, 248, 231, 148))),
        backgroundColor: const Color.fromARGB(255, 40, 65, 57),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(placesProvider.notifier).toggleFavorite(id);
              },
              icon: Icon(place.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: place.isFavorite ? const Color.fromARGB(255, 255, 0, 0) : const Color.fromARGB(255, 248, 231, 148))
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            place.image,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.titleText,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(place.descriptionText)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: place.attractions
                .map((att) => Column(
                      children: [Icon(att.icon), Text(att.text)],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
