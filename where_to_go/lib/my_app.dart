import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "auth_view.dart";
import "features/auth/tokens_provider.dart";
import "home_screen.dart";

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(tokensProvider.future),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final tokens = snapshot.data;
        final loggedIn = tokens != null && tokens.$1 != null && tokens.$2 != null;
        return loggedIn ? HomeScreen() : const AuthView();
      },
    );
  }
}
