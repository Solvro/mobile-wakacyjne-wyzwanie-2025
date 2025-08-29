import "package:flutter/widgets.dart";

import "../../../app/theme/app_theme.dart";

class AuthScreenTitle extends StatelessWidget {
  final String title;
  final String helper;

  const AuthScreenTitle({super.key, required this.title, required this.helper});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        title,
        style: context.textTheme.headlineLarge,
      ),
      const SizedBox(height: 10),
      Text(
        helper,
        style: context.textTheme.bodyMedium,
      ),
      const SizedBox(height: 60),
    ]);
  }
}
