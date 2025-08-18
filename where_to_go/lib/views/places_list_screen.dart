import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../app/colors.dart";
import "../app/ui_config.dart";
import "../features/places/places_provider.dart";
import "dream_place_screen_consumer_widget.dart";

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamPlacesList = ref.watch(placesProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Przeglądaj piękne miejsca"),
      ),
      body: ListView.builder(
        itemCount: dreamPlacesList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () =>
              GoRouter.of(context).push("${DreamPlaceScreenConsumerWidget.route}/${dreamPlacesList[index].id}"),
          child: Container(
            margin: const EdgeInsets.all(AppPaddings.tiny),
            decoration: BoxDecoration(
              color: AppColors.shadow,
              borderRadius: BorderRadius.circular(PlacesListScreenConfig.radius),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(PlacesListScreenConfig.radius),
                    bottomLeft: Radius.circular(PlacesListScreenConfig.radius),
                  ),
                  child: Image.asset(
                    dreamPlacesList[index].imagePath,
                    width: PlacesListScreenConfig.imageSize,
                    height: PlacesListScreenConfig.imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: AppPaddings.small),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppPaddings.medium),
                    child: Text(
                      dreamPlacesList[index].title,
                      style:
                          const TextStyle(fontSize: PlacesListScreenConfig.titleFontSize, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                if (dreamPlacesList[index].isFavorited)
                  const Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: AppPaddings.large),
                      child: Icon(Icons.favorite)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
