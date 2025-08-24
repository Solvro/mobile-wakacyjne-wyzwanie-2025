import "package:flutter/material.dart";

import "../../gen/assets.gen.dart";
import "../../models/attraction.dart";
import "place_old.dart";

List<PlaceOld> placesList = [
  PlaceOld("Guangzhou, Chiny", "Furtka państwa środka na świat", Assets.images.guangzhou1.path, [
    Attraction("Ostre jedzenie", Icons.local_fire_department),
    Attraction("Muzea", Icons.museum),
    Attraction("Opera", Icons.music_note)
  ]),
  PlaceOld("Saint-Tropez, Francja", "Śladami Żandarma", Assets.images.saintTropez1.path, [
    Attraction("Plaża", Icons.beach_access),
    Attraction("Słońce", Icons.sunny),
    Attraction("Muzea", Icons.museum),
  ]),
  PlaceOld("Bamberg, Niemcy", "Poznaj historię pochodzenia Bambrów", Assets.images.bamberg1.path, [
    Attraction("Widoki", Icons.landscape),
    Attraction("Historia", Icons.menu_book),
    Attraction("Szlaki", Icons.nordic_walking),
    Attraction("Jedzenie", Icons.food_bank)
  ]),
  PlaceOld("Fuzhou, Chiny", "Wypij najlepszą herbatę na świecie", Assets.images.fuzhou1.path, [
    Attraction("Herbaciarnie", Icons.coffee),
    Attraction("Dostęp do morza", Icons.waves),
    Attraction("Jedzenie", Icons.food_bank)
  ]),
  PlaceOld("Nowy Jork, USA", "Miasto, które nigdy nie śpi", Assets.images.newYork1.path, [
    Attraction("Wieżowce", Icons.vertical_shades_closed),
    Attraction("Muzea", Icons.museum),
    Attraction("Nocne życie", Icons.nightlife)
  ]),
];
