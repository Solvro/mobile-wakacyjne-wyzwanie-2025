import "package:flutter/material.dart";

import "../../themes/color_palette.dart";
import "../../utils/task_variants/places_widget_inherited.dart";

class DreamPlaceScreenInherited extends StatelessWidget {
  final String id;
  static String route = "/dream_place";

  const DreamPlaceScreenInherited({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final places = PlacesWidgetInherited.of(context);
    final place = places.places.firstWhere((place) => place.id == id);

    return Scaffold(
        backgroundColor: ColorPalette.iceBlueLight,
        appBar: AppBar(
          backgroundColor: ColorPalette.iceBlueDark,
          title: Text(place.title),
          actions: [
            IconButton(
              onPressed: () {
                places.toggleFavorite(id);
              },
              icon: place.isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
              color: place.isFavorite ? Colors.red : null,
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
                Text(place.description)
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
