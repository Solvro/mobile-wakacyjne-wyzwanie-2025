import "package:flutter/material.dart";

import "gen/assets.gen.dart";

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen({super.key});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  void _toggleFavorited() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          title: const Text("Malaga"),
          actions: [
            IconButton(
                onPressed: _toggleFavorited,
                icon: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                ),
                color: _isFavorited ? Colors.red : const Color(0xFF141414))
          ],
        ),
        body: Column(children: [
          Image(
            image: AssetImage(Assets.images.malaga.path),
            fit: BoxFit.cover,
          ),
          const DreamPlaceHeader(),
          const DreamPlaceAttractions()
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
              "Malaga is a sunny city in southern Spain, known for its beautiful beaches, historic architecture, and Mediterranean climate.",
              style: TextStyle(fontSize: 16),
            )
          ],
        ));
  }
}

class DreamPlaceAttractions extends StatelessWidget {
  const DreamPlaceAttractions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Attractions",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DreamPlaceTile(icon: Icons.wb_sunny, label: "Sunny"),
            DreamPlaceTile(icon: Icons.beach_access, label: "Beaches"),
            DreamPlaceTile(icon: Icons.restaurant, label: "Food"),
          ],
        )
      ],
    );
  }
}

class DreamPlaceTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const DreamPlaceTile({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(icon), Text(label)],
    );
  }
}
