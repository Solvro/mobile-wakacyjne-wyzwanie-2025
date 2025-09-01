import "package:flutter/widgets.dart";

import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";

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
      const SizedBox(height: AuthViewsConfig.fieldGap),
      Text(
        helper,
        style: context.textTheme.bodyMedium,
      ),
      const SizedBox(height: AuthViewsConfig.titleGap),
    ]);
  }
}
