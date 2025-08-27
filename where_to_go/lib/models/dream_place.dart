import "package:flutter/material.dart";

class Attraction {
  final IconData icon;
  final String label;

  const Attraction({required this.icon, required this.label});
}

class DreamPlace {
  final String id;
  final String name;
  final String imagePath;
  final String description;
  final bool isFavorited;
  final List<Attraction> attractions;

  const DreamPlace({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.attractions,
    this.isFavorited = false,
  });

  DreamPlace copyWith({bool? isFavorited}) {
    return DreamPlace(
      id: id,
      name: name,
      imagePath: imagePath,
      description: description,
      attractions: attractions,
      isFavorited: isFavorited ?? this.isFavorited,
    );
  }
}
