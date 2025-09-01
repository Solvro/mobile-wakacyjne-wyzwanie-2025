import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../auth_notifier.dart";
import "../views/login_view.dart";
import "register_page.dart";

class LoginPage extends ConsumerWidget {
  static const route = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoginView(redirectToRegister: () async {
      await GoRouter.of(context).push(RegisterPage.route);
    }, onLogin: (email, password) async {
      return ref.read(authNotifierProvider.notifier).login(email, password);
    });
  }
}
