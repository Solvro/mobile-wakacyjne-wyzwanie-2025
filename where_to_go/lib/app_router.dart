import "package:go_router/go_router.dart";
import "dream_places/details_screen.dart";
import "main.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/${DetailsScreen.route}/:id", // dynamiczny parametr
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DetailsScreen(id: id);
      },
    ),
  ],
);
