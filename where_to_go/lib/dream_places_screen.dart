import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "places_provider.dart";

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key, required this.id});
  final int id;

  static const route = "places";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(singleDreamPlaceProvider(id));

    const colorAccent = Color.fromARGB(255, 154, 63, 11);
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset(
          place.imagePath,
          fit: BoxFit.cover,
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title2,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  place.description,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: place.attractions
                .map(
                  (e) => Column(
                    children: [
                      Icon(
                        e.icon,
                        size: 35,
                        color: colorAccent,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          e.subtitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
                .toList())
      ]),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(place.title),
        titleTextStyle: const TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(dreamPlacesProvider.notifier).toggleFavorite(id);
              },
              icon: Icon(
                place.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: place.isFavorite ? const Color.fromARGB(255, 174, 14, 14) : colorAccent,
              ))
        ],
        iconTheme: const IconThemeData(
          color: colorAccent,
        ),
      ),
    );
  }
}
