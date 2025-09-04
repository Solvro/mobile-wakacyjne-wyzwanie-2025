// lib/screens/register_screen.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers/auth_providers.dart";

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = "/register";

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();
  final _confirmPasswdController = TextEditingController();
  var _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwdController.dispose();
    _confirmPasswdController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.register(_emailController.text, _passwdController.text);
    } on Exception catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e);
        _isLoading = false;
      });
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains("Email already in use")) {
      return "Ten email jest już w użyciu.";
    } else if (error.toString().contains("Network error")) {
      return "Błąd sieci. Sprawdź połączenie internetowe.";
    }
    print("Unexpected error: $error");
    return "Wystąpił błąd. Spróbuj ponownie.";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Rejestracja")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_add, size: 64, color: theme.colorScheme.primary),
                    const SizedBox(height: 16),
                    Text(
                      "Załóż konto",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Proszę wprowadzić email.";
                        }
                        if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                          return "Proszę wprowadzić prawidłowy email.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwdController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Hasło",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Proszę wprowadzić hasło.";
                        }
                        if (value.length < 3) {
                          return "Hasło musi mieć co najmniej 3 znaki.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswdController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Potwierdź hasło",
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Proszę potwierdzić hasło.";
                        }
                        if (value != _passwdController.text) {
                          return "Hasła nie są zgodne.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 20),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Zarejestruj się"),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
