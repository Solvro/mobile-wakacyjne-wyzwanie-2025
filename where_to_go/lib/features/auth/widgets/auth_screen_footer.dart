import "package:flutter/material.dart";

class AuthScreenFooter extends StatelessWidget {
  final void Function() onPressed;
  final void Function() onRedirect;
  final bool isLogin;

  const AuthScreenFooter({required this.isLogin, required this.onPressed, required this.onRedirect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Text(isLogin ? "Login" : "Register"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isLogin ? "Don't have an account?" : "Already have an account?"),
            TextButton(
              onPressed: onRedirect,
              child: Text(isLogin ? "Register" : "Login"),
            ),
          ],
        )
      ],
    );
  }
}
