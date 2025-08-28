import "package:flutter/material.dart";

import "gen/assets.gen.dart";

class Place {
  final String id;
  final String title;
  final AssetGenImage image;
  final String placeName;
  final String placeDescription;
  final List<InfoColumnData> infoColumns;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.image,
    required this.placeName,
    required this.placeDescription,
    required this.infoColumns,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      image: image,
      placeName: placeName,
      placeDescription: placeDescription,
      infoColumns: infoColumns,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class InfoColumnData {
  const InfoColumnData({required this.icon, required this.text});

  final IconData icon;
  final String text;
}
