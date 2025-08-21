import "package:flutter/material.dart";

class DreamPlace {
  final int id;
  final String title;
  final String imagePath;
  final String title2;
  final String description;
  final List<ListOfAtt> attractions;
  final bool isFavorite;
  const DreamPlace(
      {required this.id,
      required this.title,
      required this.title2,
      required this.description,
      required this.imagePath,
      required this.attractions,
      this.isFavorite = false});

  DreamPlace copyWith({required bool isFavourite}) {
    return DreamPlace(
      id: id,
      title: title,
      title2: title2,
      description: description,
      imagePath: imagePath,
      attractions: attractions,
      isFavorite: isFavourite,
    );
  }
}

class ListOfAtt {
  final IconData icon;
  final String subtitle;
  const ListOfAtt({required this.icon, required this.subtitle});
}
