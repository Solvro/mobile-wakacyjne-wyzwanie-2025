import "package:go_router/go_router.dart";
import "features/places/places_screen.dart";
import "features/places/details_screen.dart";

final appRouter = GoRouter(
  initialLocation: "/", // pierwsza strona po uruchomieniu
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const PlacesScreen(), // tu lista miejsc
    ),
    GoRoute(
      path: "/details/:id", // :id = parametr dynamiczny
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DetailsScreen(id: id); // przekazujemy id do szczegółów
      },
    ),
  ],
);
