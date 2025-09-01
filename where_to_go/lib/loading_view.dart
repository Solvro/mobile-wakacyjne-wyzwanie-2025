import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/theme.dart";

class LoadingView extends ConsumerWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    return themeAsync.when(
      data: (currentTheme) {
        final themePalette = ThemePalette();
        return Scaffold(
            backgroundColor: themePalette.getPrimaryColor(currentTheme, context),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themePalette.getPrimaryColor(currentTheme, context)),
              ),
            ));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading theme")),
    );
  }
}
