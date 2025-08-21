import "package:flutter/material.dart";

class Place {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;
  final String subtitle;
  final String imagePath;
  final Color backgroundColor;
  const Place({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.subtitle,
    required this.imagePath,
    required this.backgroundColor,
  });
  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
      subtitle: subtitle,
      imagePath: imagePath,
      backgroundColor: backgroundColor,
    );
  }
}
