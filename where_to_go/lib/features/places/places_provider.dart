import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../gen/assets.gen.dart";
import "../../place.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String placeId) {
    state = [
      for (final p in state)
        if (p.id == placeId) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}

var _initialPlaces = [
  Place(
    id: "1",
    title: "Rejkiawik, Islandia",
    image: Assets.images.reykjavikView,
    placeName: "Rejkiawik",
    placeDescription: "Stolica Islandii, znana z pięknych widoków i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.restaurant, text: "Restauracje"),
      InfoColumnData(icon: Icons.terrain, text: "Góry i wulkany"),
      InfoColumnData(icon: Icons.auto_awesome, text: "Zorze polarne"),
    ],
  ),
  Place(
    id: "2",
    title: "Zermatt, Szwajcaria",
    image: Assets.images.zermattView,
    placeName: "Zermatt",
    placeDescription: "Malownicza miejscowość u stóp Matterhorn, raj dla narciarzy i turystów górskich.",
    infoColumns: const [
      InfoColumnData(icon: Icons.downhill_skiing, text: "Narciarstwo"),
      InfoColumnData(icon: Icons.landscape, text: "Alpy i trekking"),
      InfoColumnData(icon: Icons.train, text: "Panoramiczne pociągi"),
    ],
  ),
  Place(
    id: "3",
    title: "Kioto, Japonia",
    image: Assets.images.kyotoView,
    placeName: "Kioto",
    placeDescription: "Dawna stolica Japonii, znana z świątyń, ogrodów i kwitnącej wiśni.",
    infoColumns: const [
      InfoColumnData(icon: Icons.park, text: "Świątynie i ogrody"),
      InfoColumnData(icon: Icons.local_florist, text: "Kwitnąca wiśnia"),
      InfoColumnData(icon: Icons.ramen_dining, text: "Kuchnia japońska"),
    ],
  ),
  Place(
    id: "4",
    title: "Sydney, Australia",
    image: Assets.images.sydneyView,
    placeName: "Sydney",
    placeDescription: "Tętniące życiem miasto znane z Opery, plaż i pięknych widoków nad zatoką.",
    infoColumns: const [
      InfoColumnData(icon: Icons.theaters, text: "Opera w Sydney"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaże"),
      InfoColumnData(icon: Icons.sailing, text: "Rejsy w zatoce"),
    ],
  ),
  Place(
    id: "5",
    title: "Kapsztad, RPA",
    image: Assets.images.capeTownView,
    placeName: "Kapsztad",
    placeDescription: "Malownicze miasto między górami a oceanem, pełne przyrody i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.terrain, text: "Góra Stołowa"),
      InfoColumnData(icon: Icons.water, text: "Ocean Atlantycki"),
      InfoColumnData(icon: Icons.wine_bar, text: "Winnice"),
    ],
  ),
  Place(
    id: "6",
    title: "Paryż, Francja",
    image: Assets.images.parisView,
    placeName: "Paryż",
    placeDescription: "Romantyczna stolica Francji, pełna sztuki, mody i kulinarnych przysmaków.",
    infoColumns: const [
      InfoColumnData(icon: Icons.location_city, text: "Wieża Eiffla"),
      InfoColumnData(icon: Icons.museum, text: "Luwr"),
      InfoColumnData(icon: Icons.coffee, text: "Kawiarnie"),
    ],
  ),
  Place(
    id: "7",
    title: "Rio de Janeiro, Brazylia",
    image: Assets.images.rioView,
    placeName: "Rio de Janeiro",
    placeDescription: "Miasto samby, karnawału i spektakularnych plaż w otoczeniu gór.",
    infoColumns: const [
      InfoColumnData(icon: Icons.landscape, text: "Góra Corcovado"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaża Copacabana"),
      InfoColumnData(icon: Icons.celebration, text: "Karnawał"),
    ],
  ),
];
