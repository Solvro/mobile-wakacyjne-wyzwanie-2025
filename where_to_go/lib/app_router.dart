import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "auth_view.dart";
import "dream_place_screen.dart";
import "features/auth/tokens_provider.dart";
import "home_screen.dart";
import "loading_view.dart";
import "places_form_view.dart";

class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Ref ref) {
    // listen to tokensProvider changes and notify GoRouter
    ref.listen(tokensProvider, (_, __) => notifyListeners());
  }
}

final goRouter = Provider<GoRouter>((ref) {
  final refresh = _AuthRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
      refreshListenable: refresh,
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: "/details/:id",
          builder: (context, state) {
            final id = state.pathParameters["id"]!;
            return DreamPlaceScreen(id: int.parse(id));
          },
        ),
        GoRoute(path: "/add", builder: (context, state) => const PlacesFormView()),
        GoRoute(
          path: "/auth",
          builder: (context, state) => const AuthView(),
        ),
        GoRoute(path: "/loading", builder: (context, state) => const LoadingView()),
      ],
      redirect: (context, state) {
        final tokensAsync = ref.read(tokensProvider);

        bool? loggedIn;

        tokensAsync.when(
          data: (tokens) {
            {
              debugPrint(tokens.toString());
              loggedIn = tokens.$1 != null && tokens.$2 != null;
            }
          },
          loading: () => loggedIn = null,
          error: (error, stack) => loggedIn = false,
        );

        // now make the redirect decision based on loggedIn
        if (loggedIn == null) {
          if (state.matchedLocation != "/loading") return "/loading";
          return null;
        } else if (loggedIn != null) {
          if (loggedIn!) {
            if (state.matchedLocation == "/auth" || state.matchedLocation == "/loading") return "/";
            return null;
          } else {
            if (state.matchedLocation != "/auth") return "/auth";
            return null;
          }
        }
        return null;
      });
});
