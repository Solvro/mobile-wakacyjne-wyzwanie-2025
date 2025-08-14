import "package:flutter/material.dart";

import "../models/dream_place.dart";

class DreamPlaceListScreen extends StatelessWidget {
  final List<DreamPlace> places;

  const DreamPlaceListScreen({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Where2Go"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9,
          children: places.map((place) => DreamPlaceListTile(place: place)).toList(),
        ),
      ),
    );
  }
}

class DreamPlaceListTile extends StatelessWidget {
  final DreamPlace place;

  const DreamPlaceListTile({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(place.imagePath, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(place.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
