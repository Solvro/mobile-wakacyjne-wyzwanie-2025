import "package:go_router/go_router.dart";

import "ui/dream_place_list_screen.dart";
import "ui/dream_place_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const DreamPlaceListScreen(),
    ),
    GoRoute(
      path: "${DreamPlaceScreen.route}/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreen(placeId: id);
      },
    ),
  ],
);
