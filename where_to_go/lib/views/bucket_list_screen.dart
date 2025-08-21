import "package:flutter/material.dart";

import "../utils/color_palette.dart";
import "../utils/place_list.dart";
import "../widgets/build_list.dart";

class BucketListScreen extends StatelessWidget {
  const BucketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.iceBlueLight,
      appBar: AppBar(
        backgroundColor: ColorPalette.iceBlueDark,
        surfaceTintColor: Colors.transparent,
        title: const Text("Bucket List"),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) {
            return BuildList(
              id: placesList[index].id,
              index: index,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 24);
          },
          itemCount: 5),
    );
  }
}
