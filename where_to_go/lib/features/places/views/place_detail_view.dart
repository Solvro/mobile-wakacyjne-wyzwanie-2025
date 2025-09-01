import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../../app/remote/paths.dart";
import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";
import "../service/dream_place_service.dart";

class PlaceDetailView extends ConsumerWidget {
  const PlaceDetailView({super.key, required this.id});

  static String route = "/dream_place";
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeByIdProvider(id));
    if (place == null) return const Text("Not found");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(place.name),
        actions: [
          IconButton(
              onPressed: () => ref.read(dreamPlaceServiceProvider.notifier).toggleFavorite(place.id),
              icon: Icon(
                place.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: place.isFavourite ? context.colorScheme.tertiary : null,
              ))
        ],
      ),
      backgroundColor: context.colorScheme.surface,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imagePath + place.imageUrl,
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPaddings.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: DreamPlaceScreenConfig.titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: AppPaddings.small,
                ),
                Text(place.description,
                    style: TextStyle(
                      fontSize: DreamPlaceScreenConfig.descriptionFontSize,
                      color: context.colorScheme.secondary,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
