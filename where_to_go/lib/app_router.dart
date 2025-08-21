import "package:go_router/go_router.dart";
import "dream_place_list_screen.dart";
import "dream_place_screen.dart";

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const DreamPlacesListScreen(),
    ),
    GoRoute(
      path: "${DreamPlaceScreen.route}/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);
