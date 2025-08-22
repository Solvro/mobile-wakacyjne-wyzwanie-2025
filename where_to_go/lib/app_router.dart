import "package:go_router/go_router.dart";
import "dream_place_screen.dart";
import "my_app.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MyApp(),
    ),
    GoRoute(
      path: "/details/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);
