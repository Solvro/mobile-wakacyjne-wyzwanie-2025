import "package:flutter/material.dart";

import "dream_place_screen.dart";
import "gen/fonts.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Where2Go",
      theme: ThemeData(fontFamily: FontFamily.plusJakartaSans),
      home: const DreamPlaceScreen(),
    );
  }
}
