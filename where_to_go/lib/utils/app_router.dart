import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../views/bucket_list_screen.dart";
import "../views/dream_place_screen_consumer_router.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const BucketListScreen(),
    ),
    GoRoute(
      path: "${DreamPlaceScreenConsumerRouter.route}/:id",
      pageBuilder: (context, state) {
        final id = state.pathParameters["id"]!;
        //return DreamPlaceScreen(id: id);
        return CustomTransitionPage(
          child: DreamPlaceScreenConsumerRouter(id: id),
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
