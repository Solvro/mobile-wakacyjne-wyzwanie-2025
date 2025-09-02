// app_router.dart
import "package:go_router/go_router.dart";
import "screens/details_screen.dart";
import "screens/dream_place_screen.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const DreamPlacesScreen(),
    ),
    GoRoute(
      path: "/details/:id",
      builder: (context, state) {
        final id = int.parse(state.pathParameters["id"]!);
        return DetailsScreen(placeId: id);
      },
    ),
  ],
);
