import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/theme/app_theme.dart";
import "../../auth/auth_notifier.dart";
import "../../common/widgets/theme_selector_button.dart";
import "../providers/places_provider.dart";
import "../widgets/list_view_tile.dart";
import "dream_place_screen_consumer_widget.dart";

class PlacesListScreen extends ConsumerWidget {
  final void Function() onLogout;
  const PlacesListScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamPlacesList = ref.watch(placesProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Przeglądaj piękne miejsca"),
        leading: IconButton(onPressed: onLogout, icon: const Icon(Icons.exit_to_app)),
        actions: [ThemeSelectorButton()],
      ),
      body: dreamPlacesList.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          ref.read(authNotifierProvider.notifier).logout();
          return null;
        },
        data: (places) => ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => GoRouter.of(context).push("${DreamPlaceScreenConsumerWidget.route}/${places[index].id}"),
            child: ListViewTile(dreamPlace: places[index]),
          ),
        ),
      ),
    );
  }
}
