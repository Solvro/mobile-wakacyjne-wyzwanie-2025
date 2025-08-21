import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "views/bucket_list_screen.dart";

void main() {
  runApp(const ProviderScope(child: TravelApp()));
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
