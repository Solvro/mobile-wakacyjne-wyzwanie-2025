import "package:go_router/go_router.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "classes/dreamPlaceScreen.dart";
import "classes/placeListScreen.dart";

final goRouterProvider = Provider<GoRouter>((ref) {
return GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const PlaceListScreen(),
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
}
);




