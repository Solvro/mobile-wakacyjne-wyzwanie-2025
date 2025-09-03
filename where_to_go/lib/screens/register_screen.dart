//lib/screens/register_screen.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers/auth_providers.dart";

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();
  var _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwdController.dispose();
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
    return "Wystąpił błąd. Spróbuj ponownie.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rejestracja"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Proszę wprowadzić email.";
                  }
                  final emailRegex = RegExp(r"^[^@]+@[^@]+\.[^@]+");
                  if (!emailRegex.hasMatch(value)) {
                    return "Proszę wprowadzić prawidłowy email.";
                  }
                  return null;
                },
              ),
              TextFormField(
                  controller: _passwdController,
                  decoration: const InputDecoration(labelText: "Hasło"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Proszę wprowadzić hasło.";
                    }
                    if (value.length < 3) {
                      return "Hasło musi mieć co najmniej 3 znaków.";
                    }
                    return null;
                  }),
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
                ElevatedButton(
                  onPressed: _register,
                  child: const Text("Zarejestruj się"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
