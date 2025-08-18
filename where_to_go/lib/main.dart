import "package:flutter/material.dart";
// import "package:hooks_riverpod/hooks_riverpod.dart";
import "app/router.dart";
import "features/places/places_inherited_wrapper.dart";

void main() {
  runApp(const PlacesInheritedWrapper(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Where to Go",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
