import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/theme/app_theme.dart";
import "../../common/widgets/theme_selector_button.dart";
import "../providers/places_provider.dart";
import "../widgets/list_view_tile.dart";
import "dream_place_screen_consumer_widget.dart";

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamPlacesList = ref.watch(placesProvider);
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Przeglądaj piękne miejsca"),
        actions: [ThemeSelectorButton()],
      ),
      body: ListView.builder(
        itemCount: dreamPlacesList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () =>
              GoRouter.of(context).push("${DreamPlaceScreenConsumerWidget.route}/${dreamPlacesList[index].id}"),
          child: ListViewTile(
            index: index,
            dreamPlacesList: dreamPlacesList,
          ),
        ),
      ),
    );
  }
}
