import "package:flutter/material.dart";

import "../utils/place_list.dart";
import "../widgets/build_list.dart";

class BucketListScreen extends StatelessWidget {
  const BucketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 253, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 216, 246, 252),
        surfaceTintColor: Colors.transparent,
        title: const Text("Bucket List"),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) {
            return BuildList(
              place: placesList[index],
              index: index,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 24);
          },
          itemCount: 5),
    );
  }
}
