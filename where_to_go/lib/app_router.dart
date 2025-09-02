import "package:go_router/go_router.dart";

import "screens/details_screen.dart";
import "screens/favorites_screen.dart";
import "screens/home_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "${DetailsScreen.route}/:id", // dynamiczny parametr
      builder: (context, state) {
        final id = int.parse(state.pathParameters["id"]!);
        return DetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: "/favorites",
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
);
