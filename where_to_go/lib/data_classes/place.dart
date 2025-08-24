import "package:flutter/material.dart";

class Attraction {
  final IconData icon;
  final String text;

  const Attraction({required this.icon, required this.text});
}

class Place {
  final String id;
  final String placeText;
  final String image;
  final String titleText;
  final String descriptionText;
  final List<Attraction> attractions;
  final bool isFavorite;

  const Place(
      {required this.id,
      required this.placeText,
      required this.image,
      required this.titleText,
      required this.descriptionText,
      this.isFavorite = false,
      required this.attractions});
  
  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      placeText: placeText,
      image: image,
      titleText: titleText,
      descriptionText: descriptionText,
      attractions: attractions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
