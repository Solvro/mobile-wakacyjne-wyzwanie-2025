import 'package:go_router/go_router.dart';
import 'package:hello_flutter/screens/list_view_screen.dart';
import 'package:hello_flutter/screens/riverpod_widget.dart';
import 'package:hello_flutter/models/dream_place_model.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      name: "home",
      path: "/home",
      builder: (context, state) {
        return const ListViewScreen();
      },
    ),
    GoRoute(
      name: "details",
      path: "/details",
      builder: (context, state) {
        final DreamPlace place = state.extra as DreamPlace;
        return DreamPlaceScreen(place: place);
      },
    ),
  ],
);
