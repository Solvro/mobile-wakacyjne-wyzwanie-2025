import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../utils/places_widget_inherited.dart";
import "../views/dream_place_screen_inherited.dart";

class BuildListInherited extends StatelessWidget {
  final String id;
  final int index;

  const BuildListInherited({super.key, required this.id, required this.index});

  @override
  Widget build(BuildContext context) {
    final places = PlacesWidgetInherited.of(context);
    final place = places.places.firstWhere((place) => place.id == id);

    return GestureDetector(
      onTap: () async {
        await GoRouter.of(context).push("${DreamPlaceScreenInherited.route}/${place.id}");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(place.path, width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(place.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ),
    );
  }
}
