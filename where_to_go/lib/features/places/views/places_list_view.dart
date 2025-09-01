import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/theme/app_theme.dart";
import "../../common/widgets/profile_button.dart";
import "../../common/widgets/theme_selector_button.dart";
import "../pages/create_place_page.dart";
import "../service/dream_place_service.dart";
import "../widgets/dream_place_list_tile.dart";
import "place_detail_view.dart";

class PlacesListView extends ConsumerWidget {
  final void Function() onError;
  const PlacesListView({super.key, required this.onError});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamPlacesList = ref.watch(dreamPlaceServiceProvider);

    return Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Przeglądaj piękne miejsca"),
          leading: const ProfileButton(),
          actions: [ThemeSelectorButton()],
        ),
        body: dreamPlacesList.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            print("got error: $error");
            onError();
            return null;
          },
          data: (places) => ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => GoRouter.of(context).push("${PlaceDetailView.route}/${places[index].id}"),
              child: DreamPlaceListTile(dreamPlace: places[index]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await GoRouter.of(context).push(CreatePlacePage.route);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
