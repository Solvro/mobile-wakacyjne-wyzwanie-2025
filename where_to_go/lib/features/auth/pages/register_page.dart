import "package:flutter/widgets.dart";

import "../views/login_view.dart";

class RegisterPage extends StatelessWidget {
  static const route = "/register";

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginView(redirectToRegister: () {}, onLogin: () {});
  }
}
