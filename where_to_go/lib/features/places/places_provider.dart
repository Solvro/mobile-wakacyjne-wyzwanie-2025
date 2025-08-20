import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../../gen/assets.gen.dart";
import "../../place.dart";

part "places_provider.g.dart";

var _initialPlaces = [
  Place(
    id: "1",
    name: "Auckland, New Zealand",
    description: "Gdzie nowoczesne miasto spotyka się z zapierającymi dech w piersiach krajobrazami.",
    image: Assets.images.auckland,
    attractions: {
      "Sky Tower": Icons.location_city,
      "Waiheke Island": Icons.beach_access,
      "Hobbiton": Icons.movie,
    },
  ),
  Place(
    id: "2",
    name: "Kyoto, Japan",
    description: "Starożytna stolica pełna świątyń, tradycyjnych ogrodów i malowniczych uliczek.",
    image: Assets.images.kyoto,
    attractions: {
      "Kinkaku-ji": Icons.location_city,
      "Arashiyama Bamboo Grove": Icons.nature,
    },
  ),
  Place(
    id: "3",
    name: "Santorini, Greece",
    description: "Bajkowa wyspa z białymi domami i błękitnymi kopułami nad lazurowym morzem.",
    image: Assets.images.santorini,
    attractions: {
      "Oia": Icons.location_city,
      "Fira": Icons.beach_access,
      "Akrotiri": Icons.history,
    },
  ),
  Place(
    id: "4",
    name: "Machu Picchu, Peru",
    description: "Tajemnicze ruiny inkaskiego miasta ukryte wysoko w Andach.",
    image: Assets.images.macchuPicchu,
    attractions: {
      "Inti Punku": Icons.location_city,
      "Sacsayhuamán": Icons.history,
    },
  ),
  Place(
    id: "5",
    name: "Reykjavik, Iceland",
    description: "Kraina zorzy polarnej, gejzerów i zapierających dech krajobrazów wulkanicznych.",
    image: Assets.images.reykjavik,
    attractions: {
      "Hallgrímskirkja": Icons.church,
      "Geysir": Icons.thermostat,
      "Blue Lagoon": Icons.pool,
    },
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  Future<void> toggleFavorite(String id) async {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = state.where((p) => p.isFavorite).map((p) => p.id).toList();
    await prefs.setStringList("favorite_places", favoriteIds);
  }
}
