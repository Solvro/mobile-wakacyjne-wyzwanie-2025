import "package:flutter/material.dart";
import "package:hive_ce/hive.dart";

import "../gen/assets.gen.dart";
import "dream_place.dart";

Future<void> seedBox(Box<DreamPlace> box) async {
  await box.put(
    "0",
    DreamPlace(
      id: "0",
      placeText: "Wrocław, Polska",
      image: Assets.images.wroclaw.path,
      titleText: "Panorama miasta",
      descriptionText: "A w tle najwyższy budynek we Wrocławiu",
      attractions: [
        Attraction(icon: Icons.wb_sunny.codePoint, text: "Słońce"),
        Attraction(icon: Icons.park.codePoint, text: "Parki"),
        Attraction(icon: Icons.restaurant.codePoint, text: "Restauracje")
      ],
    ),
  );
  await box.put(
    "1",
    DreamPlace(
      id: "1",
      placeText: "Paryż, Francja",
      image: Assets.images.paris.path,
      titleText: "Wieża Eiffla",
      descriptionText: "Symbol miłości i jedno z najczęściej odwiedzanych miejsc w Europie",
      attractions: [
        Attraction(icon: Icons.camera_alt.codePoint, text: "Zabytki"),
        Attraction(icon: Icons.local_cafe.codePoint, text: "Kawiarnie"),
        Attraction(icon: Icons.shopping_bag.codePoint, text: "Zakupy")
      ],
    ),
  );
  await box.put(
    "2",
    DreamPlace(
      id: "2",
      placeText: "Nowy Jork, USA",
      image: Assets.images.manhattan.path,
      titleText: "Manhattan nocą",
      descriptionText: "Miasto, które nigdy nie śpi, pełne świateł i energii",
      attractions: [
        Attraction(icon: Icons.apartment.codePoint, text: "Wieżowce"),
        Attraction(icon: Icons.directions_boat.codePoint, text: "Rejsy"),
        Attraction(icon: Icons.theaters.codePoint, text: "Broadway")
      ],
    ),
  );
  await box.put(
    "3",
    DreamPlace(
      id: "3",
      placeText: "Tokio, Japonia",
      image: Assets.images.tokio.path,
      titleText: "Tokio nocą",
      descriptionText: "Bardzo nowoczesca zabudowa",
      attractions: [
        Attraction(icon: Icons.directions_transit.codePoint, text: "Transport"),
        Attraction(icon: Icons.ramen_dining.codePoint, text: "Kuchnia japońska"),
        Attraction(icon: Icons.videogame_asset.codePoint, text: "Gry i anime")
      ],
    ),
  );
  await box.put(
    "4",
    DreamPlace(
      id: "4",
      placeText: "Sydney, Australia",
      image: Assets.images.sydney.path,
      titleText: "Opera w Sydney",
      descriptionText: "Ikoniczny budynek nad zatoką, symbol Australii",
      attractions: [
        Attraction(icon: Icons.beach_access.codePoint, text: "Plaże"),
        Attraction(icon: Icons.sailing.codePoint, text: "Żeglowanie"),
        Attraction(icon: Icons.music_note.codePoint, text: "Koncerty")
      ],
    ),
  );
}
