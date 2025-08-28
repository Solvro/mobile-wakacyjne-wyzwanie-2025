import "package:flutter/material.dart";

import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";
import "../../../data/models/dream_place.dart";

class ListViewTile extends StatelessWidget {
  const ListViewTile({required this.dreamPlace});

  final DreamPlace dreamPlace;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              dreamPlace.imagePath,
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
                dreamPlace.title,
                style: const TextStyle(fontSize: PlacesListScreenConfig.titleFontSize, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          if (dreamPlace.isFavorited)
            const Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: AppPaddings.large), child: Icon(Icons.favorite)),
        ],
      ),
    );
  }
}
