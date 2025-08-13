import "package:flutter/material.dart";

import "../app/assets/assets.gen.dart";
import "../models/attraction.dart";
import "../models/dream_place.dart";

List<DreamPlace> dreamPlacesList = [
  DreamPlace("Teide", "Piękna wyspa w środku oceanu", "Teneryfa, Hiszpania", Assets.images.teide.path, [
    const Attraction("Góry", Icons.landscape),
    const Attraction("Słońce", Icons.wb_sunny),
    const Attraction("Spacery", Icons.nordic_walking),
  ]),
  DreamPlace("Santorini", "Malownicza wyspa w Grecji", "Santorini, Grecja", Assets.images.santorini.path, [
    const Attraction("Zachody słońca", Icons.wb_sunny),
    const Attraction("Plaże", Icons.beach_access),
  ]),
  DreamPlace("Machu Picchu", "Starożytne miasto Inków", "Machu Picchu, Peru", Assets.images.machuPiccu.path, [
    const Attraction("Historia", Icons.history),
    const Attraction("Góry", Icons.landscape),
  ]),
  DreamPlace("Wielki Kanion", "Imponujący kanion w USA", "Arizona, USA", Assets.images.canyon.path, [
    const Attraction("Widoki", Icons.visibility),
    const Attraction("Szlaki turystyczne", Icons.directions_walk),
  ]),
  DreamPlace("Wielka Rafa Koralowa", "Największa rafa koralowa na świecie", "Australia", Assets.images.reef.path, [
    const Attraction("Woda", Icons.water),
    const Attraction("Różnorodność biologiczna", Icons.eco),
  ]),
];
