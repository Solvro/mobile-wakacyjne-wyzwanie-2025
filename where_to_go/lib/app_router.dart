import "package:go_router/go_router.dart";

import "main.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: "/${DreamPlaceScreen.route}/:id", // dynamiczny parametr
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DreamPlaceScreen(id: int.parse(id));
      },
    ),
  ],
);
