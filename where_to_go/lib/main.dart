import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "gen/fonts.gen.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Where2Go",
      theme: ThemeData(fontFamily: FontFamily.plusJakartaSans),
      routerConfig: goRouter,
    );
  }
}
