import "package:flutter/material.dart";

import "../../../app/theme/app_theme.dart";
import "../../../app/ui_config.dart";

extension ErrorSnackBar on BuildContext {
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: textTheme.labelMedium),
        padding: const EdgeInsets.all(AppPaddings.medium),
        backgroundColor: colorScheme.error,
      ),
    );
  }
}
