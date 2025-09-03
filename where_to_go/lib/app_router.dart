import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "auth/auth_provider.dart";
import "auth/auth_state.dart";
import "screens/create_dream_place_screen.dart";
import "screens/details_screen.dart";
import "screens/favorites_screen.dart";
import "screens/home_screen.dart";
import "screens/login_screen.dart";
import "screens/register_screen.dart";
import "screens/settings_screen.dart";

GoRouter createRouter(WidgetRef ref) {
  final authListener = AuthNotifierListener(ref);

  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "${DetailsScreen.route}/:id", // dynamiczny parametr
        builder: (context, state) {
          final id = int.parse(state.pathParameters["id"]!);
          return DetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: "/favorites",
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: "/settings",
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: "/create",
        builder: (context, state) => CreateDreamPlaceScreen(),
      ),
    ],
    refreshListenable: authListener,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);

      final isLoggingIn = state.uri.toString() == "/login" || state.uri.toString() == "/register";

      return authState.maybeWhen(
          authenticated: () {
            if (isLoggingIn) {
              return "/";
            }
            return null;
          },
          unauthenticated: () {
            if (!isLoggingIn) {
              return "/login";
            }
            return null;
          },
          orElse: () => null);
    },
  );
}
