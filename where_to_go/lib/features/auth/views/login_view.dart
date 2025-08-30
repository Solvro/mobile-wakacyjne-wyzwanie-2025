import "package:flutter/material.dart";

import "../../../app/ui_config.dart";
import "../../common/widgets/error_snack_bar.dart";
import "../widgets/auth_screen_footer.dart";
import "../widgets/auth_screen_title.dart";

class LoginView extends StatefulWidget {
  final void Function() redirectToRegister;
  final Future<bool> Function(String email, String passoword) onLogin;
  const LoginView({super.key, required this.redirectToRegister, required this.onLogin});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppPaddings.large),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthScreenTitle(
                  title: "Login to your account", helper: "Please log in to explore the Dream Places"),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: AuthViewsConfig.fieldGap),
              TextFormField(
                obscureText: _obscurePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: AuthViewsConfig.buttonGap),
              AuthScreenFooter(
                isLogin: true,
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final success = await widget.onLogin(
                      _emailController.text.trim(),
                      _passwordController.text,
                    );
                    if (!success) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.showErrorSnackBar("Could not log in. Wrong email or password.");
                      });
                    }
                  }
                },
                onRedirect: () {
                  _formKey.currentState?.reset();
                  widget.redirectToRegister();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
