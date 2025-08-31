import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "features/auth/authentication_repository_provider.dart";
import "features/auth/tokens_provider.dart";

class AuthView extends HookConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isSignup = useState(false);
    String email = "";
    String password = "";
    final authRepo = ref.read(authenticationRepositoryProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Please log in to continue"),
            TextField(
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              autocorrect: false,
              onChanged: (value) => email = value.trim(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
              autocorrect: false,
              onChanged: (value) => password = value,
            ),
            if (isSignup.value) ...[
              const TextField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                ),
                obscureText: true,
                autocorrect: false,
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final response = await authRepo.signIn(email, password);

                    if (response != (null, null)) {
                      final accessToken = response.$1;
                      final refreshToken = response.$2;
                      await authRepo.saveTokens(accessToken, refreshToken);
                      ref.invalidate(tokensProvider);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text("Sign Up"),
              ),
              TextButton(
                onPressed: () {
                  isSignup.value = !isSignup.value;
                },
                child: const Text("Log In instead"),
              ),
            ] else ...[
              TextButton(
                onPressed: () async {
                  try {
                    final response = await authRepo.logIn(email, password);
                    if (response != (null, null)) {
                      final accessToken = response.$1;
                      final refreshToken = response.$2;
                      await authRepo.saveTokens(accessToken, refreshToken);
                      ref.invalidate(tokensProvider);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text("Log In"),
              ),
              TextButton(
                onPressed: () {
                  isSignup.value = !isSignup.value;
                },
                child: const Text("Sign In instead"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
