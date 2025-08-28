import "package:go_router/go_router.dart";

import "../features/places/views/dream_place_screen_consumer_widget.dart";
import "../features/places/views/places_list_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const PlacesListScreen(),
    ),
    GoRoute(
      path: "${DreamPlaceScreenConsumerWidget.route}/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreenConsumerWidget(id: id);
      },
    ),
  ],
);
