import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";
import "../providers/places_inherited_provider.dart";
import "dream_place_screen_inherited_widget.dart";

class PlacesListScreenInheritedWidget extends StatelessWidget {
  const PlacesListScreenInheritedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dreamPlacesList = DreamPlacesInheritedProvider.of(context).places;
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Przeglądaj piękne miejsca"),
      ),
      body: ListView.builder(
        itemCount: dreamPlacesList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () =>
              GoRouter.of(context).push("${DreamPlaceScreenInheritedWidget.route}/${dreamPlacesList[index].id}"),
          child: Container(
            margin: const EdgeInsets.all(AppPaddings.tiny),
            decoration: BoxDecoration(
              color: context.colorScheme.shadow,
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
