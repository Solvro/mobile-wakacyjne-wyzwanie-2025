//lib/screens/auth_screen.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Navigate to Login Screen
                await Navigator.pushNamed(context, "/login");
              },
              child: const Text("Zaloguj się"),
            ),
            ElevatedButton(
              onPressed: () async {
                // Navigate to Register Screen
                await Navigator.pushNamed(context, "/register");
              },
              child: const Text("Zarejestruj się"),
            ),
          ],
        ),
      ),
    );
  }
}
