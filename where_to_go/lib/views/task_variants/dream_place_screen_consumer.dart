import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../features/favorite/favorite_provider.dart";
import "../../themes/color_palette.dart";
import "../../utils/old/place_old.dart";

class DreamPlaceScreenConsumer extends ConsumerWidget {
  final PlaceOld place;

  const DreamPlaceScreenConsumer({super.key, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final isFavorite = ref.watch(favoriteProvider(place));
    final isFavorite = ref.watch(favoriteProvider);

    return Scaffold(
        backgroundColor: ColorPalette.iceBlueLight,
        appBar: AppBar(
          backgroundColor: ColorPalette.iceBlueDark,
          title: Text(place.title),
          actions: [
            IconButton(
              onPressed: () {
                /*ref.read(favoriteProvider(place).notifier).toggle();
                place.isFavorite = !place.isFavorite;*/
                ref.read(favoriteProvider.notifier).toggle();
              },
              icon: isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
              color: isFavorite ? Colors.red : null,
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
