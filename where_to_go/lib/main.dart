import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "dream_place_screen.dart";

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dream Places",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const DreamPlaceScreen(),
    );
  }
}
