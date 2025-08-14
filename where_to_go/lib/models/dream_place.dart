import "package:flutter/material.dart";
import "../gen/assets.gen.dart";

class Attraction {
  final IconData icon;
  final String label;

  const Attraction({required this.icon, required this.label});
}

class DreamPlace {
  final String name;
  final String imagePath;
  final String description;
  final List<Attraction> attractions;

  const DreamPlace({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.attractions,
  });
}

// I should probably move them to a separate file but i'm too lazy
List<DreamPlace> exampleDreamPlaces = [
  DreamPlace(
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
