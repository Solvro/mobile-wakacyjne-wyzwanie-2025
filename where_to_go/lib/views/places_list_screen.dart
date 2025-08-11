import "package:flutter/material.dart";

import "../app/colors.dart";
import "../app/ui_config.dart";
import "../data/places.dart";
import "dream_place_screen.dart";

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Browse Beautiful Places"),
      ),
      body: ListView.builder(
        itemCount: dreamPlacesList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (context) => DreamPlaceScreen(
                  dreamPlace: dreamPlacesList[index],
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(AppPaddings.tiny),
            decoration: BoxDecoration(
              color: AppColors.shadow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
