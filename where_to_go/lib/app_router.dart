// @dart=3.0
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "auth_provider.dart";
import "features/auth/auth_screens.dart";
import "features/places/screens.dart";

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final auth = ref.read(authNotifierProvider);
      final isAuthRoute = state.matchedLocation == "/login" ||
          state.matchedLocation == "/register";
      if (auth.isLoading) return null;
      if (auth.value != true && !isAuthRoute) return "/login";
      if (auth.value == true && isAuthRoute) return "/";
      return null;
    },
    routes: [
      GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
      GoRoute(
          path: "/login",
          builder: (context, state) => const AuthScreen(isRegistering: false)),
      GoRoute(
          path: "/register",
          builder: (context, state) => const AuthScreen(isRegistering: true)),
      GoRoute(
        path: "${DreamPlaceScreen.route}/:id",
        builder: (context, state) {
          // Konwersja String z URL na int dla widoku ekranu
          final id = int.parse(state.pathParameters["id"]!);
          return DreamPlaceScreen(id: id);
        },
      ),
    ],
  );
  ref.listen(authNotifierProvider, (_, __) => router.refresh());
  ref.onDispose(router.dispose);
  return router;
});
