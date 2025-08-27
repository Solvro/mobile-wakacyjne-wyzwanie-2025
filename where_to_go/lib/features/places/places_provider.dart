import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../gen/assets.gen.dart";
import "../../models/dream_place.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  List<DreamPlace> build() => _initialDreamPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final place in state)
        if (place.id == id) place.copyWith(isFavorited: !place.isFavorited) else place
    ];
  }
}

final _initialDreamPlaces = [
  DreamPlace(
    id: "1",
    name: "Malaga",
    imagePath: Assets.images.malaga.path,
    description: "A vibrant city on the Costa del Sol in Spain, known for its beaches and cultural heritage.",
    attractions: [
      const Attraction(icon: Icons.beach_access, label: "Beaches"),
      const Attraction(icon: Icons.museum, label: "Museums"),
      const Attraction(icon: Icons.restaurant, label: "Cuisine"),
    ],
  ),
  DreamPlace(
    id: "2",
    name: "Santorini",
    imagePath: Assets.images.santorini.path,
    description: "A beautiful Greek island known for its stunning sunsets and white-washed houses.",
    attractions: [
      const Attraction(icon: Icons.beach_access, label: "Beaches"),
      const Attraction(icon: Icons.wine_bar, label: "Wineries"),
      const Attraction(icon: Icons.landscape, label: "Scenic Views"),
    ],
  ),
  DreamPlace(
    id: "3",
    name: "Kyoto",
    imagePath: Assets.images.kyoto.path,
    description: "Historic city in Japan famous for its temples, gardens, and cherry blossoms.",
    attractions: [
      const Attraction(icon: Icons.park, label: "Gardens"),
      const Attraction(icon: Icons.temple_buddhist, label: "Temples"),
      const Attraction(icon: Icons.local_florist, label: "Cherry Blossoms"),
    ],
  ),
  DreamPlace(
    id: "4",
    name: "Venice",
    imagePath: Assets.images.venice.path,
    description: "Romantic Italian city built on canals, famous for its architecture, art, and gondola rides.",
    attractions: [
      const Attraction(icon: Icons.directions_boat, label: "Canals"),
      const Attraction(icon: Icons.museum, label: "Museums"),
      const Attraction(icon: Icons.local_pizza, label: "Cuisine"),
    ],
  ),
  DreamPlace(
    id: "5",
    name: "Reykjavik",
    imagePath: Assets.images.reykjavik.path,
    description: "The capital of Iceland, known for its unique landscapes, geothermal spas, and vibrant culture.",
    attractions: [
      const Attraction(icon: Icons.terrain, label: "Landscapes"),
      const Attraction(icon: Icons.hot_tub, label: "Geothermal Spas"),
      const Attraction(icon: Icons.nightlife, label: "Nightlife"),
    ],
  ),
];
