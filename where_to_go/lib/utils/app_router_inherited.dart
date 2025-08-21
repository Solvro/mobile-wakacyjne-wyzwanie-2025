import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../views/bucket_list_screen_inherited.dart";
import "../views/dream_place_screen_inherited.dart";

final goRouterInherited = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const BucketListScreenInherited(),
    ),
    GoRoute(
      path: "${DreamPlaceScreenInherited.route}/:id",
      pageBuilder: (context, state) {
        final id = state.pathParameters["id"]!;
        return CustomTransitionPage(
          child: DreamPlaceScreenInherited(id: id),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0, 1);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
      },
    ),
  ],
);
