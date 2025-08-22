import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/favorite/favorite_provider.dart";

import "main.dart";

class DreamPlaceScreen extends ConsumerWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider); // obserwujemy stan providera, przy jego zmianie metoda build widgeta uruchomi się jeszcze raz odświerzając nam ui z nowym jej stanem

    return Scaffold(
      backgroundColor: const Color.fromARGB(196, 195, 218, 230),
      appBar: AppBar(
        title: Text(place.titleText),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle(); // tutaj odczytujemy jednorazowo stan notifiera ponieważ nie chcemy nasłuchiwać zmian na obiekcie do zarządzania stanem
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Image(image: place.image, height: 250, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                place.placeName,
                const SizedBox(
                  height: 8,
                ),
                place.catchPhrase
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [place.feature1, place.feature2, place.feature3],
          )
        ],
      ),
    );
  }
}