import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../utils/color_palette.dart";
import "../utils/old/place_old.dart";

class DreamPlaceScreenHook extends HookWidget {
  final PlaceOld place;

  const DreamPlaceScreenHook({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final isFavorite = useState(place.isFavorite);

    return Scaffold(
        backgroundColor: ColorPalette.iceBlueLight,
        appBar: AppBar(
          backgroundColor: ColorPalette.iceBlueDark,
          title: Text(place.title),
          actions: [
            IconButton(
              onPressed: () {
                isFavorite.value = !isFavorite.value;
                place.isFavorite = isFavorite.value;
              },
              icon: isFavorite.value ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
              color: isFavorite.value ? Colors.red : null,
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                place.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(place.text)
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            for (final attraction in place.attractionList)
              Column(children: [Icon(attraction.icon), Text(attraction.title)])
          ])
        ])));
  }
}
