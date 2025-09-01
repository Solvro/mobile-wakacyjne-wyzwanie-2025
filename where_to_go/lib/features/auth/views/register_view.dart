import "package:dio/dio.dart";
import "package:flutter/material.dart";

import "../../../app/ui_config.dart";
import "../../common/widgets/error_snack_bar.dart";
import "../widgets/auth_screen_footer.dart";
import "../widgets/auth_screen_title.dart";

class RegisterView extends StatefulWidget {
  final void Function() redirectToLogin;
  final Future<void> Function(String email, String passoword) onRegister;
  const RegisterView({super.key, required this.redirectToLogin, required this.onRegister});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

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
                  title: "Register to create a new account",
                  helper: "Only one step separates you from discovering Dream Places"),
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
              const SizedBox(height: AuthViewsConfig.fieldGap),
              TextFormField(
                obscureText: _obscureRepeatPassword,
                controller: _passwordRepeatController,
                decoration: InputDecoration(
                  labelText: "Repeat password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureRepeatPassword = !_obscureRepeatPassword;
                        });
                      },
                      icon: _obscureRepeatPassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please repeat your password.";
                  } else if (_passwordController.text.trim() != _passwordRepeatController.text.trim()) {
                    return "Passwords must match!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: AuthViewsConfig.buttonGap),
              AuthScreenFooter(
                isLogin: false,
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      await widget.onRegister(
                        _emailController.text.trim(),
                        _passwordController.text,
                      );
                    } on DioException catch (e) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final errorData = e.response?.data;
                        String detailedMessage = "";
                        if (errorData is Map &&
                            errorData["message"] is List &&
                            (errorData["message"] as List).isNotEmpty &&
                            (errorData["message"] as List)[0] is Map &&
                            ((errorData["message"] as List)[0] as Map)["message"] is String) {
                          detailedMessage = ((errorData["message"] as List)[0] as Map)["message"] as String;
                        }
                        if (errorData is Map && errorData["message"] is String) {
                          detailedMessage = errorData["message"] as String;
                        }

                        context.showErrorSnackBar("Could not log in. $detailedMessage");
                      });
                    }
                  }
                },
                onRedirect: () {
                  _formKey.currentState?.reset();
                  widget.redirectToLogin();
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
    _passwordRepeatController.dispose();
    super.dispose();
  }
}
