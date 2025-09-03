// app_router.dart
import "dart:async";

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
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.auth,
    redirect: (context, state) {
      // Sprawdź stan uwierzytelnienia
      final isAuthenticated = authState.when(
        data: (value) => value, //  Zwraca bool gdy dane są dostępne
        loading: () => false, // Podczas ładowania traktuj jako niezalogowany
        error: (_, __) => false, // 👈 Przy błędzie traktuj jako niezalogowany
      );
      // Ścieżki związane z uwierzytelnianiem
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

      // Pozwól na normalną nawigację
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
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text("Błąd 404: Strona nie znaleziona ${state.error}"),
      ),
    ),
  );
});

// Potrzebna klasa do obsługi refreshListenable z Riverpod
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
