import "package:flutter/material.dart";

import "../models/place.dart";

class DreamPlaceScreen extends StatefulWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 253, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 216, 246, 252),
          title: Text(widget.place.title),
          actions: [
            IconButton(
                onPressed: _toggleFavorite,
                icon: widget.place.isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_border))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.place.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.place.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(widget.place.text)
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            for (final attraction in widget.place.attractionList)
              Column(children: [Icon(attraction.icon), Text(attraction.title)])
          ])
        ])));
  }

  void _toggleFavorite() {
    setState(() {
      widget.place.isFavorite = !widget.place.isFavorite;
    });
  }
}
