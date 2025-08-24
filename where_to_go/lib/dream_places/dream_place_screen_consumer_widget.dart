import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../data_classes/place.dart";
import "../gen/assets.gen.dart";
import "../providers/favorite_provider.dart";

class DreamPlaceScreenConsumer extends ConsumerWidget {
  const DreamPlaceScreenConsumer({required this.place, super.key});
  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 123, 144, 118),
      appBar: AppBar(
        title: Text(place.placeText, style: const TextStyle(color: Color.fromARGB(255, 248, 231, 148))),
        backgroundColor: const Color.fromARGB(255, 40, 65, 57),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(favoriteProvider.notifier).toggle();
              },
              icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
              color: isFavorited ? const Color.fromARGB(255, 255, 0, 0) : const Color.fromARGB(255, 248, 231, 148))
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
