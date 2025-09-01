import "package:flutter/material.dart" hide ThemeMode;
import "package:hooks_riverpod/hooks_riverpod.dart";
import "app/router.dart";
import "app/theme/app_theme.dart";
import "app/theme/theme_extension.dart";
import "app/theme/theme_mode.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeToSet = context.setTheme(ref);
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: "Where to Go",
      theme: themeToSet == ThemeMode.light ? AppTheme().light : AppTheme().dark,
      routerConfig: router,
    );
  }
}
