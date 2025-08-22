import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "main.dart";

class DreamPlaceScreen extends HookWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(196, 195, 218, 230),
      appBar: AppBar(
        title: Text(place.titleText),
        actions: [
          IconButton(
            onPressed: () => isFavorited.value = !isFavorited.value,
            icon: Icon(
              isFavorited.value ? Icons.favorite : Icons.favorite_border,
              color: isFavorited.value ? Colors.red : null,
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