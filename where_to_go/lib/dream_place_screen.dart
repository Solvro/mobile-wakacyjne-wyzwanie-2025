import "package:flutter/material.dart";

import "feature_icon.dart";
import "place.dart";

class DreamPlaceScreen extends StatefulWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  var _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          widget.place.image.image(
            fit: BoxFit.cover,
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.place.subtitle, style: textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(widget.place.description, style: textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FeatureIcon(
                icon: Icons.wb_sunny,
                color: Colors.orange,
                label: "Słońce",
              ),
              FeatureIcon(
                icon: Icons.beach_access,
                color: Colors.blueAccent,
                label: "Plaże",
              ),
              FeatureIcon(
                icon: Icons.restaurant,
                color: Colors.red,
                label: "Jedzenie",
              ),
              FeatureIcon(
                icon: Icons.landscape,
                color: Colors.green,
                label: "Widoki",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
