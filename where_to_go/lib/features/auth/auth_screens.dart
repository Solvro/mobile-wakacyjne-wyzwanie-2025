import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../auth_provider.dart";
import "../places/places_provider.dart";

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, required this.isRegistering});

  final bool isRegistering;

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final notifier = ref.read(authNotifierProvider.notifier);
      if (widget.isRegistering) {
        await notifier.register(
            email: _emailController.text.trim(),
            username: _usernameController.text.trim(),
            password: _passwordController.text);
      } else {
        await notifier.login(
            identifier: _emailController.text.trim(),
            password: _passwordController.text);
      }
      final auth = ref.read(authNotifierProvider);
      if (mounted && auth.hasError) {
        setState(() => _error = _message(auth.error));
      } else if (mounted) {
        ref.invalidate(placesProvider);
        context.go("/");
      }
    } on DioException catch (error) {
      if (mounted) setState(() => _error = _message(error));
    } on FormatException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String _message(Object? error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map && data["message"] is String) {
        return data["message"] as String;
      }
      return "Nie udało się połączyć z API (${error.response?.statusCode ?? "brak odpowiedzi"}).";
    }
    return error?.toString() ?? "Wystąpił nieznany błąd.";
  }

  @override
  Widget build(BuildContext context) {
    final registering = widget.isRegistering;
    return Scaffold(
      appBar: AppBar(title: Text(registering ? "Rejestracja" : "Logowanie")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(registering ? "Utwórz konto" : "Witaj ponownie",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  if (registering) ...[
                    TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                            labelText: "Nazwa użytkownika"),
                        validator: _required),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: registering
                              ? "Email"
                              : "Email lub nazwa użytkownika"),
                      validator: _required),
                  const SizedBox(height: 12),
                  TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Hasło"),
                      validator: _required),
                  if (_error != null) ...[
                    const SizedBox(height: 16),
                    Text(_error!, style: const TextStyle(color: Colors.red))
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? const CircularProgressIndicator()
                          : Text(
                              registering ? "Zarejestruj się" : "Zaloguj się")),
                  TextButton(
                      onPressed: _submitting
                          ? null
                          : () =>
                              context.go(registering ? "/login" : "/register"),
                      child: Text(registering
                          ? "Mam już konto"
                          : "Nie mam jeszcze konta")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? "To pole jest wymagane" : null;
}
