import "package:flutter/material.dart";

import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";
import "../providers/places_inherited_provider.dart";

class DreamPlaceScreenInheritedWidget extends StatelessWidget {
  const DreamPlaceScreenInheritedWidget({super.key, required this.id});

  static String route = "/dream_place";
  final String id;
  @override
  Widget build(BuildContext context) {
    final dreamPlace = DreamPlacesInheritedProvider.of(context).places.firstWhere((place) => place.id == id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dreamPlace.location),
        actions: [
          IconButton(
              onPressed: () => DreamPlacesInheritedProvider.of(context).toggleFavorite(id),
              icon: Icon(
                dreamPlace.isFavorited ? Icons.favorite : Icons.favorite_border,
                color: dreamPlace.isFavorited ? Colors.red : null,
              ))
        ],
      ),
      backgroundColor: context.colorScheme.surface,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(fit: BoxFit.fitWidth, dreamPlace.imagePath, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(AppPaddings.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dreamPlace.title,
                  style: const TextStyle(
                    fontSize: DreamPlaceScreenConfig.titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: AppPaddings.small,
                ),
                Text(dreamPlace.description,
                    style: TextStyle(
                      fontSize: DreamPlaceScreenConfig.descriptionFontSize,
                      color: context.colorScheme.secondary,
                    )),
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: dreamPlace.attractions.map((attraction) {
                return Column(
                  children: [
                    Icon(attraction.icon, size: DreamPlaceScreenConfig.iconSize),
                    Text(attraction.title),
                  ],
                );
              }).toList())
        ],
      ),
    );
  }
}
