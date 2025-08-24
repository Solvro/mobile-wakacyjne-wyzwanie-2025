import "package:flutter/material.dart";

import "../gen/assets.gen.dart";
import "../models/attraction.dart";
import "../models/place.dart";

List<Place> placesList = [
  Place(
      id: "1",
      title: "Guangzhou, Chiny",
      description: "Furtka państwa środka na świat",
      path: Assets.images.guangzhou1.path,
      attractionList: [
        Attraction("Ostre jedzenie", Icons.local_fire_department),
        Attraction("Muzea", Icons.museum),
        Attraction("Opera", Icons.music_note)
      ]),
  Place(
      id: "2",
      title: "Saint-Tropez, Francja",
      description: "Śladami Żandarma",
      path: Assets.images.saintTropez1.path,
      attractionList: [
        Attraction("Plaża", Icons.beach_access),
        Attraction("Słońce", Icons.sunny),
        Attraction("Muzea", Icons.museum),
      ]),
  Place(
      id: "3",
      title: "Bamberg, Niemcy",
      description: "Poznaj historię pochodzenia Bambrów",
      path: Assets.images.bamberg1.path,
      attractionList: [
        Attraction("Widoki", Icons.landscape),
        Attraction("Historia", Icons.menu_book),
        Attraction("Szlaki", Icons.nordic_walking),
        Attraction("Jedzenie", Icons.food_bank)
      ]),
  Place(
      id: "4",
      title: "Fuzhou, Chiny",
      description: "Wypij najlepszą herbatę na świecie",
      path: Assets.images.fuzhou1.path,
      attractionList: [
        Attraction("Herbaciarnie", Icons.coffee),
        Attraction("Dostęp do morza", Icons.waves),
        Attraction("Jedzenie", Icons.food_bank)
      ]),
  Place(
      id: "5",
      title: "Nowy Jork, USA",
      description: "Miasto, które nigdy nie śpi",
      path: Assets.images.newYork1.path,
      attractionList: [
        Attraction("Wieżowce", Icons.vertical_shades_closed),
        Attraction("Muzea", Icons.museum),
        Attraction("Nocne życie", Icons.nightlife)
      ]),
];
