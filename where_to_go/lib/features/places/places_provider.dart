import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "place_feature.dart";
import "place_model.dart";

part "places_provider.g.dart";

const _initialPlaces = [
  PlaceModel(
    id: "1",
    title: "Snowdin",
    description: "Here lives THE GREAT PAPYRUS",
    features: [
      PlaceFeature(icon: Icons.wb_sunny, label: "No sun"),
      PlaceFeature(icon: Icons.beach_access, label: "No beach"),
      PlaceFeature(icon: Icons.restaurant, label: "Tasty pasta"),
    ],
  ),
  PlaceModel(
    id: "2",
    title: "Zakopane",
    description: "Big snowy mountains",
    features: [
      PlaceFeature(icon: Icons.snowboarding, label: "Snow sports!"),
      PlaceFeature(icon: Icons.hiking, label: "Hiking!"),
      PlaceFeature(icon: Icons.water, label: "Oko morskie!"),
    ],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<PlaceModel> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}
