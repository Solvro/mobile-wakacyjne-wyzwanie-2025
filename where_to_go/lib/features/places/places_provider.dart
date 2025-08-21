import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../models/attraction.dart";
import "../models/place.dart";

part "places_provider.g.dart";

const _initialPlaces = [
  Place(
    id: "1",
    title: "Tokio, Japonia",
    imagePath: "assets/images/tokio.jpg",
    placeName: "Wieża Tokio Tower",
    description:
        "Wysoka wieża widokowa, futurystyczne wieżowce z cyfrowymi bilbordami reklamowymi, czyste niebo i zadbana zieleń.",
    attractions: [
      Attraction(icon: Icons.wb_sunny, label: "Słońce"),
      Attraction(icon: Icons.cell_tower, label: "Tokio Tower"),
      Attraction(icon: Icons.computer, label: "Technologia"),
      Attraction(icon: Icons.train, label: "Shinkansen"),
    ],
  ),
  Place(
    id: "2",
    title: "Paryż, Francja",
    imagePath: "assets/images/paryz.jpg",
    placeName: "Wieża Eiffla",
    description:
        "Romantyczna atmosfera, pyszne croissanty i bagietki, zachwycające dzieła sztuki i zjawiskowa architektura.",
    attractions: [
      Attraction(icon: Icons.location_city, label: "Miasto"),
      Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
      Attraction(icon: Icons.museum, label: "Muzea"),
      Attraction(icon: Icons.brush, label: "Sztuka"),
    ],
  ),
  Place(
    id: "3",
    title: "Rzym, Włochy",
    imagePath: "assets/images/rzym.jpg",
    placeName: "Koloseum",
    description:
        "Historyczne ruiny osiągnięć przodków, starożytna architektura, wyjątkowa kuchnia oraz klimat śródziemnomorski.",
    attractions: [
      Attraction(icon: Icons.history, label: "Historia"),
      Attraction(icon: Icons.local_pizza, label: "Pizza"),
      Attraction(icon: Icons.church, label: "Bazyliki"),
      Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
    ],
  ),
  Place(
    id: "4",
    title: "Nowy Jork, USA",
    imagePath: "assets/images/nowy_jork.jpg",
    placeName: "Statua Wolności",
    description:
        "Ikoniczne miasto, które nigdy nie śpi, z niekończącą się energią, kulturą i rozrywką oraz kolosalnymi wieżowcami.",
    attractions: [
      Attraction(icon: Icons.location_city, label: "Miasto"),
      Attraction(icon: Icons.shopping_bag, label: "Zakupy"),
      Attraction(icon: Icons.music_note, label: "Muzyka"),
      Attraction(icon: Icons.park, label: "Central Park"),
    ],
  ),
  Place(
    id: "5",
    title: "Kair, Egipt",
    imagePath: "assets/images/kair.jpg",
    placeName: "Wielkie Piramidy w Gizie",
    description:
        "Starożytne cuda świata, pustynny krajobraz z wielbłądami oraz bogata historia starożytnej cywilizacji.",
    attractions: [
      Attraction(icon: Icons.beach_access, label: "Pustynia"),
      Attraction(icon: Icons.sailing, label: "Nil"),
      Attraction(icon: Icons.museum, label: "Muzea"),
      Attraction(icon: Icons.landscape, label: "Piramidy"),
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
