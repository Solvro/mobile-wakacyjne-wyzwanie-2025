// lib/app_router.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../providers/auth_providers.dart";
import "screens/auth_screen.dart";
import "screens/details_screen.dart";
import "screens/dream_place_screen.dart";
import "screens/login_screen.dart";
import "screens/register_screen.dart";

class RouteNames {
  static const auth = "/auth";
  static const login = "/login";
  static const register = "/register";
  static const home = "/";
  static const details = "/details";
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.auth,
    redirect: (context, state) async {
      // Odczytaj authRepo bez watch (aby uniknąć cyklicznych zależności)
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.initialize();
      final isAuthenticated = await authRepo.isLoggedIn;

      final isAuthPath = state.matchedLocation == RouteNames.auth ||
          state.matchedLocation == RouteNames.login ||
          state.matchedLocation == RouteNames.register;

      // Jeśli użytkownik jest zalogowany i próbuje wejść na auth screen
      if (isAuthenticated && isAuthPath) {
        return RouteNames.home;
      }

      // Jeśli użytkownik NIE jest zalogowany i próbuje wejść na chronione ścieżki
      if (!isAuthenticated && !isAuthPath) {
        return RouteNames.auth;
      }

      return null;
    },
    routes: [
      // Auth flow
      GoRoute(
        path: RouteNames.auth,
        name: "auth",
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: "register",
        builder: (context, state) => const RegisterScreen(),
      ),

      // Main app flow (chronione)
      GoRoute(
        path: RouteNames.home,
        name: "home",
        builder: (context, state) => const DreamPlacesScreen(),
      ),
      GoRoute(
        path: "${RouteNames.details}/:id",
        name: "details",
        builder: (context, state) {
          final id = int.parse(state.pathParameters["id"]!);
          return DetailsScreen(placeId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text("Błąd 404: Strona nie znaleziona"),
      ),
    ),
  );
});
