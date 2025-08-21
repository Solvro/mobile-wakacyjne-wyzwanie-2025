import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "utils/app_router.dart";

void main() {
  runApp(const ProviderScope(child: TravelApp()));
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: "Travel App",
    );
  }
}
