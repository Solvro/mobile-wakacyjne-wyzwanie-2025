import "package:flutter/material.dart";

import "views/bucket_list_screen.dart";

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Travel App",
      home: BucketListScreen(),
    );
  }
}
