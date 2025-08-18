import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../app/colors.dart";
import "../app/ui_config.dart";
import "../features/places/places_provider.dart";

class DreamPlaceScreenConsumerWidget extends ConsumerWidget {
  const DreamPlaceScreenConsumerWidget({super.key, required this.id});

  static String route = "/dream_place";
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamPlace = ref.watch(placesProvider.select((places) => places.firstWhere((place) => place.id == id)));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dreamPlace.location),
        actions: [
          IconButton(
              onPressed: () => ref.read(placesProvider.notifier).toggleFavorite(id),
              icon: Icon(
                dreamPlace.isFavorited ? Icons.favorite : Icons.favorite_border,
                color: dreamPlace.isFavorited ? Colors.red : null,
              ))
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
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
                    style: const TextStyle(
                      fontSize: DreamPlaceScreenConfig.descriptionFontSize,
                      color: AppColors.secondaryTextColor,
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
