import "package:go_router/go_router.dart";
import "screens/details_screen.dart";
import "screens/dream_place_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const DreamPlaceScreen(),
    ),
    GoRoute(
      path: "${DetailsScreen.route}/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DetailsScreen(id: id);
      },
    ),
  ],
);
