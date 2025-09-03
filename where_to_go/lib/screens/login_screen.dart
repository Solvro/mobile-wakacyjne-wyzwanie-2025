import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../auth/auth_provider.dart";
import "../auth/auth_state.dart";

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Błąd logowania: $message")),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Logowanie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "E-mail"),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Hasło"),
              obscureText: true,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  final authNotifier = ref.read(authNotifierProvider.notifier);
                  await authNotifier.login(email, password);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wypełnij wszystkie pola")));
                }
              },
              child: const Text("Zaloguj"),
            ),
            TextButton(
              onPressed: () {
                context.go("/register");
              },
              child: const Text("Nie masz konta? Zarejestruj się"),
            ),
          ],
        ),
      ),
    );
  }
}
