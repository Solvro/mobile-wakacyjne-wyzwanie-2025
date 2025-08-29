import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../features/auth/auth_notifier.dart";
import "../features/auth/pages/login_page.dart";
import "../features/auth/pages/register_page.dart";
import "../features/places/views/dream_place_screen_consumer_widget.dart";
import "../features/places/views/places_list_screen.dart";

part "router.g.dart";

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final auth = ref.watch(authNotifierProvider);
  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final loggedIn = auth != null;
      final loggingIn = state.fullPath == LoginPage.route || state.fullPath == RegisterPage.route;

      if (!loggedIn && !loggingIn) {
        return LoginPage.route;
      }

      if (loggedIn && loggingIn) {
        return "/";
      }

      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const PlacesListScreen(),
      ),
      GoRoute(
        path: "${DreamPlaceScreenConsumerWidget.route}/:id",
        builder: (context, state) {
          final id = state.pathParameters["id"]!;
          return DreamPlaceScreenConsumerWidget(id: id);
        },
      ),
      GoRoute(
        path: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RegisterPage.route,
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
}
