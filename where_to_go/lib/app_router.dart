import "package:go_router/go_router.dart";

import "details_screen.dart";
import "favorites_screen.dart";
import "places_list.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const PlacesList(),
    ),
    GoRoute(
      path: "${DetailsScreen.route}/:id", // dynamiczny parametr
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: "/favorites",
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
);
