import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "dream_place_list.dart";
import "dream_place_screen.dart";

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const DreamPlaceList(),
        routes: [
          GoRoute(
            path: "${DreamPlaceScreen.route}/:id",
            builder: (context, state) {
              final id = state.pathParameters["id"];

              if (id == null || id.isEmpty) {
                return const DreamPlaceList();
              }

              return DreamPlaceScreen(placeId: id);
            },
          ),
        ],
      ),
    ],
  );
});
