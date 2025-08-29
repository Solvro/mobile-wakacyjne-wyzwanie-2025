import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../auth_notifier.dart";
import "../views/register_view.dart";
import "login_page.dart";

class RegisterPage extends ConsumerWidget {
  static const route = "/register";

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RegisterView(redirectToLogin: () async {
      await GoRouter.of(context).push(LoginPage.route);
    }, onRegister: (email, password) async {
      await ref.read(authNotifierProvider.notifier).register(email, password);
    });
  }
}
