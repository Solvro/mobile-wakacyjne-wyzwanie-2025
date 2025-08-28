import "package:flutter/material.dart";

import "../../gen/assets.gen.dart";
import "../../models/attraction.dart";
import "place_old.dart";

List<PlaceOld> placesList = [
  PlaceOld(
      title: "Guangzhou, Chiny",
      text: "Furtka państwa środka na świat",
      path: Assets.images.guangzhou1.path,
      attractionList: [
        Attraction("Ostre jedzenie", Icons.local_fire_department),
        Attraction("Muzea", Icons.museum),
        Attraction("Opera", Icons.music_note)
      ]),
  PlaceOld(
      title: "Saint-Tropez, Francja",
      text: "Śladami Żandarma",
      path: Assets.images.saintTropez1.path,
      attractionList: [
        Attraction("Plaża", Icons.beach_access),
        Attraction("Słońce", Icons.sunny),
        Attraction("Muzea", Icons.museum),
      ]),
  PlaceOld(
      title: "Bamberg, Niemcy",
      text: "Poznaj historię pochodzenia Bambrów",
      path: Assets.images.bamberg1.path,
      attractionList: [
        Attraction("Widoki", Icons.landscape),
        Attraction("Historia", Icons.menu_book),
        Attraction("Szlaki", Icons.nordic_walking),
        Attraction("Jedzenie", Icons.food_bank)
      ]),
  PlaceOld(
      title: "Fuzhou, Chiny",
      text: "Wypij najlepszą herbatę na świecie",
      path: Assets.images.fuzhou1.path,
      attractionList: [
        Attraction("Herbaciarnie", Icons.coffee),
        Attraction("Dostęp do morza", Icons.waves),
        Attraction("Jedzenie", Icons.food_bank)
      ]),
  PlaceOld(
      title: "Nowy Jork, USA",
      text: "Miasto, które nigdy nie śpi",
      path: Assets.images.newYork1.path,
      attractionList: [
        Attraction("Wieżowce", Icons.vertical_shades_closed),
        Attraction("Muzea", Icons.museum),
        Attraction("Nocne życie", Icons.nightlife)
      ]),
];
