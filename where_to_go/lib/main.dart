import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "features/auth/http_provider.dart";
import "features/theme/theme_provider.dart";
import "themes/app_theme.dart";
import "themes/enums/mode_theme.dart";
import "themes/utils.dart";
import "utils/app_router.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: TravelApp()));
}

class TravelApp extends ConsumerWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = ref.watch(clientDioProvider);
    final goRouter = ref.watch(goRouterProvider);
    final baseTheme = _getTheme(context, ref);

    return dio.when(
      data: (_) => MaterialApp.router(
        routerConfig: goRouter,
        title: "Travel App",
        theme: baseTheme,
      ),
      error: (error, stack) => const Center(child: Text("Blad")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  ThemeData _getTheme(BuildContext context, WidgetRef ref) {
    final appTheme = AppTheme();
    final themeAsync = ref.watch(themeNotifierProvider);
    final modeTheme = themeAsync.valueOrNull ?? ModeTheme.system;

    ThemeData baseTheme = appTheme.light;

    switch (modeTheme) {
      case ModeTheme.light:
        baseTheme = appTheme.light;
      case ModeTheme.dark:
        baseTheme = appTheme.dark;
      case ModeTheme.system:
        baseTheme = context.isDarkMode ? appTheme.dark : appTheme.light;
    }

    return baseTheme;
  }
}
