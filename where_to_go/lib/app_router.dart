import "package:go_router/go_router.dart";
import "dream_place_screen.dart";
import "place_screen_list.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const PlaceScreenList(),
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
