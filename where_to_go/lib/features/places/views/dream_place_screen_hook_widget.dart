import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";
import "../../../models/dream_place.dart";

class DreamPlaceScreenHookWidget extends HookWidget {
  const DreamPlaceScreenHookWidget({super.key, required this.dreamPlace});

  final DreamPlace dreamPlace;

  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dreamPlace.location),
        actions: [
          IconButton(
              onPressed: () => isFavorited.value = !isFavorited.value,
              icon: Icon(isFavorited.value ? Icons.favorite : Icons.favorite_border,
                  color: isFavorited.value ? Colors.red : null))
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
