import "package:flutter/material.dart";

import "gen/assets.gen.dart";

class DreamPlaceScreen extends StatelessWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          title: const Text("Malaga"),
        ),
        body: Column(children: [
          Image(
            image: AssetImage(Assets.images.malaga.path),
            fit: BoxFit.cover,
          ),
          const DreamPlaceHeader()
        ]));
  }
}

class DreamPlaceHeader extends StatelessWidget {
  const DreamPlaceHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Malaga",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF141414),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "Malaga is a sunny city in southern Spain, known for its beautiful beaches, historic architecture, and Mediterranean climate.")
          ],
        ));
  }
}
