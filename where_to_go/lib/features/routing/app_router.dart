import "package:go_router/go_router.dart";
import "../../details_screen.dart";
import "../../home_screen.dart";

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
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
