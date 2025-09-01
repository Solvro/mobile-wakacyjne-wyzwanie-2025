import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "app_router.dart";

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouter);
    return MaterialApp.router(
      routerConfig: router,
      title: "Where to go",
    );
  }
}
