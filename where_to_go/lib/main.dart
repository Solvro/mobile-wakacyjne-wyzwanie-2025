import "package:flutter/material.dart";

import "gen/fonts.gen.dart";
import "models/dream_place.dart";
import "ui/dream_place_list_screen.dart";

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
      home: DreamPlaceListScreen(places: exampleDreamPlaces),
    );
  }
}
