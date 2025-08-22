import "package:flutter/material.dart";
import "gen/assets.gen.dart";

class Place {
  final String id;
  final String name;
  final String description;
  final AssetGenImage image;
  final Map<String, IconData> attractions;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.attractions,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      name: name,
      description: description,
      image: image,
      attractions: attractions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
