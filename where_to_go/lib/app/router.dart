import "package:go_router/go_router.dart";

// import "../views/dream_place_screen_consumer_widget.dart";
import "../views/dream_place_screen_inherited_widget.dart";
// import "../views/places_list_screen.dart";
import "../views/places_list_screen_inherited_widget.dart";

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      // builder: (context, state) => const PlacesListScreen(),
      builder: (context, state) => const PlacesListScreenInheritedWidget(),
    ),
    GoRoute(
      // path: "${DreamPlaceScreenConsumerWidget.route}/:id",
      path: "${DreamPlaceScreenInheritedWidget.route}/:id",
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        // return DreamPlaceScreenConsumerWidget(id: id);
        return DreamPlaceScreenInheritedWidget(id: id);
      },
    ),
  ],
);
