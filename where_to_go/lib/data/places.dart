import "package:flutter/material.dart";

import "../app/assets/assets.gen.dart";
import "models/attraction.dart";
import "models/dream_place.dart";

List<DreamPlace> dreamPlacesList = [
  DreamPlace(
    id: "1",
    title: "Teide",
    description: "Piękna wyspa w środku oceanu",
    location: "Teneryfa, Hiszpania",
    imagePath: Assets.images.teide.path,
    attractions: [
      const Attraction("mountains", Icons.landscape),
      const Attraction("sunsets", Icons.wb_sunny),
      const Attraction("walks", Icons.nordic_walking),
    ],
  ),
  DreamPlace(
    id: "2",
    title: "Santorini",
    description: "Malownicza wyspa w Grecji",
    location: "Santorini, Grecja",
    imagePath: Assets.images.santorini.path,
    attractions: [
      const Attraction("sunsets", Icons.wb_sunny),
      const Attraction("beach", Icons.beach_access),
    ],
  ),
  DreamPlace(
    id: "3",
    title: "Machu Picchu",
    description: "Starożytne miasto Inków",
    location: "Machu Picchu, Peru",
    imagePath: Assets.images.machuPiccu.path,
    attractions: [
      const Attraction("history", Icons.history),
      const Attraction("mountains", Icons.landscape),
    ],
  ),
  DreamPlace(
    id: "4",
    title: "Wielki Kanion",
    description: "Imponujący kanion w USA",
    location: "Arizona, USA",
    imagePath: Assets.images.canyon.path,
    attractions: [
      const Attraction("views", Icons.visibility),
      const Attraction("landscapes", Icons.directions_walk),
    ],
  ),
  DreamPlace(
    id: "5",
    title: "Wielka Rafa Koralowa",
    description: "Największa rafa koralowa na świecie",
    location: "Australia",
    imagePath: Assets.images.reef.path,
    attractions: [
      const Attraction("water", Icons.water),
      const Attraction("culture", Icons.eco),
      const Attraction("food", Icons.eco),
    ],
  ),
];
