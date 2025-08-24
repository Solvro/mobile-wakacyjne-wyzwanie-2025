import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "../data_classes/place.dart";
import "../gen/assets.gen.dart";

class DreamPlaceScreenHook extends HookWidget {
  const DreamPlaceScreenHook({required this.place, super.key});
  final Place place;

  @override
  Widget build(BuildContext context) {

    final isFavorited = useState<bool>(false);

    void toggleFavorite() {
      isFavorited.value = !isFavorited.value;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 123, 144, 118),
      appBar: AppBar(
        title: Text(place.placeText, style: const TextStyle(color: Color.fromARGB(255, 248, 231, 148))),
        backgroundColor: const Color.fromARGB(255, 40, 65, 57),
        actions: [
          IconButton(
              onPressed: toggleFavorite,
              icon: Icon(isFavorited.value ? Icons.favorite : Icons.favorite_border),
              color: isFavorited.value ? const Color.fromARGB(255, 255, 0, 0) : const Color.fromARGB(255, 248, 231, 148))
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
                //Dodać 4
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: place.attractions.map((att) => Column(
                    children: [Icon(att.icon), Text(att.text)],
                  )).toList(),
          )
        ],
      ),
    );
  }
}
