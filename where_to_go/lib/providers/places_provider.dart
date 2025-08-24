import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../data_classes/place.dart";
import "../gen/assets.gen.dart";

part "./places_provider.g.dart";

final List<Place> _initialPlaces = [
  Place(
    id: "0",
    placeText: "Wrocław, Polska",
    image: Assets.images.wroclaw.path,
    titleText: "Panorama miasta",
    descriptionText: "A w tle najwyższy budynek we Wrocławiu",
    attractions: [
      const Attraction(icon: Icons.wb_sunny, text: "Słońce"),
      const Attraction(icon: Icons.park, text: "Parki"),
      const Attraction(icon: Icons.restaurant, text: "Restauracje")
    ],
  ),
  Place(
    id: "1",
    placeText: "Paryż, Francja",
    image: Assets.images.paris.path,
    titleText: "Wieża Eiffla",
    descriptionText: "Symbol miłości i jedno z najczęściej odwiedzanych miejsc w Europie",
    attractions: [
      const Attraction(icon: Icons.camera_alt, text: "Zabytki"),
      const Attraction(icon: Icons.local_cafe, text: "Kawiarnie"),
      const Attraction(icon: Icons.shopping_bag, text: "Zakupy")
    ],
  ),
  Place(
    id: "2",
    placeText: "Nowy Jork, USA",
    image: Assets.images.manhattan.path,
    titleText: "Manhattan nocą",
    descriptionText: "Miasto, które nigdy nie śpi, pełne świateł i energii",
    attractions: [
      const Attraction(icon: Icons.apartment, text: "Wieżowce"),
      const Attraction(icon: Icons.directions_boat, text: "Rejsy"),
      const Attraction(icon: Icons.theaters, text: "Broadway")
    ],
  ),
  Place(
    id: "3",
    placeText: "Tokio, Japonia",
    image: Assets.images.tokio.path,
    titleText: "Tokio nocą",
    descriptionText: "Bardzo nowoczesca zabudowa",
    attractions: [
      const Attraction(icon: Icons.directions_transit, text: "Transport"),
      const Attraction(icon: Icons.ramen_dining, text: "Kuchnia japońska"),
      const Attraction(icon: Icons.videogame_asset, text: "Gry i anime")
    ],
  ),
  Place(
    id: "4",
    placeText: "Sydney, Australia",
    image: Assets.images.sydney.path,
    titleText: "Opera w Sydney",
    descriptionText: "Ikoniczny budynek nad zatoką, symbol Australii",
    attractions: [
      const Attraction(icon: Icons.beach_access, text: "Plaże"),
      const Attraction(icon: Icons.sailing, text: "Żeglowanie"),
      const Attraction(icon: Icons.music_note, text: "Koncerty")
    ],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}
