import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";
import "../providers/places_provider.dart";

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
        title: Text(dreamPlace.name),
        actions: [
          IconButton(
              // onPressed: () => ref.read(placesProvider.notifier).toggleFavorite(id),
              onPressed: () {},
              icon: Icon(
                dreamPlace.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: dreamPlace.isFavourite ? context.colorScheme.tertiary : null,
              ))
        ],
      ),
      backgroundColor: context.colorScheme.surface,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(fit: BoxFit.fitWidth, dreamPlace.imageUrl, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(AppPaddings.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dreamPlace.name,
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
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: dreamPlace.attractions.map((attraction) {
          //       return Column(
          //         children: [
          //           Icon(attraction.icon, size: DreamPlaceScreenConfig.iconSize),
          //           Text(attraction.title),
          //         ],
          //       );
          //     }).toList())
        ],
      ),
    );
  }
}
