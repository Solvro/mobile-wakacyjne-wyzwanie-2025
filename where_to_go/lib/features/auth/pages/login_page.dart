import "package:flutter/widgets.dart";

import "../views/login_view.dart";

class LoginPage extends StatelessWidget {
  static const route = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginView(redirectToRegister: () {}, onLogin: () {});
  }
}
