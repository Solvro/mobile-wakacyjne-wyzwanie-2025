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
      const Attraction("Góry", Icons.landscape),
      const Attraction("Słońce", Icons.wb_sunny),
      const Attraction("Spacery", Icons.nordic_walking),
    ],
  ),
  DreamPlace(
    id: "2",
    title: "Santorini",
    description: "Malownicza wyspa w Grecji",
    location: "Santorini, Grecja",
    imagePath: Assets.images.santorini.path,
    attractions: [
      const Attraction("Zachody słońca", Icons.wb_sunny),
      const Attraction("Plaże", Icons.beach_access),
    ],
  ),
  DreamPlace(
    id: "3",
    title: "Machu Picchu",
    description: "Starożytne miasto Inków",
    location: "Machu Picchu, Peru",
    imagePath: Assets.images.machuPiccu.path,
    attractions: [
      const Attraction("Historia", Icons.history),
      const Attraction("Góry", Icons.landscape),
    ],
  ),
  DreamPlace(
    id: "4",
    title: "Wielki Kanion",
    description: "Imponujący kanion w USA",
    location: "Arizona, USA",
    imagePath: Assets.images.canyon.path,
    attractions: [
      const Attraction("Widoki", Icons.visibility),
      const Attraction("Szlaki turystyczne", Icons.directions_walk),
    ],
  ),
  DreamPlace(
    id: "5",
    title: "Wielka Rafa Koralowa",
    description: "Największa rafa koralowa na świecie",
    location: "Australia",
    imagePath: Assets.images.reef.path,
    attractions: [
      const Attraction("Woda", Icons.water),
      const Attraction("Różnorodność biologiczna", Icons.eco),
    ],
  ),
];
