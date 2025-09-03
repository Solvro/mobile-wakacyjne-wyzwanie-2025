//lib/screens/auth_screen.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});
  static const routeName = "/auth";

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
            Icon(
              Icons.location_on,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Witamy w aplikacji Dream Place!",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(height: 8),
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
