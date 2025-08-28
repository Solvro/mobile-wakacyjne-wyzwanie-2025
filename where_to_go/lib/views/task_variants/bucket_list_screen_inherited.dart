import "package:flutter/material.dart";

import "../../themes/color_palette.dart";
import "../../utils/task_variants/places_widget_inherited.dart";
import "../../widgets/task_variants/build_list_inherited.dart";

class BucketListScreenInherited extends StatelessWidget {
  const BucketListScreenInherited({super.key});

  @override
  Widget build(BuildContext context) {
    final places = PlacesWidgetInherited.of(context);

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
            return BuildListInherited(
              id: places.places[index].id,
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
