import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "gen/assets.gen.dart";
import "models.dart";

part "places_provider.g.dart";

final listofplaces = [
  DreamPlace(
    id: 0,
    title: "Mostar, Bośnia i Hercegowina",
    title2: "Stary Most w Mostarze",
    description: "Przy odrobinie szczęścia można spotkać osoby wykonujące ekstremalne skoki z mostu do rzeki.",
    imagePath: Assets.images.mostar.path,
    attractions: [
      const ListOfAtt(icon: Icons.water, subtitle: "Rzeka\nNeretwa"),
      const ListOfAtt(icon: Icons.landscape, subtitle: "Widoczki"),
      const ListOfAtt(icon: Icons.storefront, subtitle: "Tradycyjne\nbudownictwo"),
      const ListOfAtt(icon: Icons.mosque, subtitle: "Meczety")
    ],
  ),
  DreamPlace(
    id: 1,
    title: "Wilno, Litwa",
    title2: "Kościół św. Anny w Wilnie",
    description:
        "Jeden z najbardziej rozpoznawalnych symboli Wilna. Jeden w wielu pięknych kościołów do zobaczenia w tym mieście. ",
    imagePath: Assets.images.wilno.path,
    attractions: [
      const ListOfAtt(icon: Icons.park, subtitle: "Parki"),
      const ListOfAtt(icon: Icons.church, subtitle: "Budownictwo\nsakralne"),
      const ListOfAtt(icon: Icons.bakery_dining_rounded, subtitle: "Kibiny")
    ],
  ),
  DreamPlace(
    id: 2,
    title: "Berlin, Niemcy",
    title2: "Brama Brandenburska",
    description: "Najbardziej rozpoznawalny zabytek Berlina, obowiązkowy punkt każdej wizyty.",
    imagePath: Assets.images.berlin.path,
    attractions: [
      const ListOfAtt(icon: Icons.account_balance_rounded, subtitle: "Brama\nBrandenburska"),
      const ListOfAtt(icon: Icons.sports_bar_rounded, subtitle: "Piwo"),
      const ListOfAtt(icon: Icons.flutter_dash_rounded, subtitle: "Fluttercon\n2025")
    ],
  ),
  DreamPlace(
    id: 3,
    title: "Szklarska Poręba, Polska",
    title2: "Wodospad Kamieńczyka",
    description: "Najwyższy wodospoad w polskich Sudetach.",
    imagePath: Assets.images.szklarska.path,
    attractions: [
      const ListOfAtt(icon: Icons.hiking_rounded, subtitle: "Piesze\nwycieczki"),
      const ListOfAtt(icon: Icons.landscape, subtitle: "Góry"),
      const ListOfAtt(icon: Icons.forest, subtitle: "Natura"),
      const ListOfAtt(icon: Icons.waves_rounded, subtitle: "Wodospady")
    ],
  ),
  DreamPlace(
    id: 4,
    title: "Bukareszt, Rumunia",
    title2: "Pałac Parlamentu w Bukareszcie",
    description: "Jeden z największych budynków na świecie, a zarazem symbol słusznie minionego komunizmu w Rumunii.",
    imagePath: Assets.images.bukareszt.path,
    attractions: [
      const ListOfAtt(icon: Icons.museum, subtitle: "Muzea"),
      const ListOfAtt(icon: Icons.location_city, subtitle: "Zróżnicowana\narchitektura"),
      const ListOfAtt(icon: Icons.park, subtitle: "Parki")
    ],
  )
];

@riverpod
class DreamPlaces extends _$DreamPlaces {
  @override
  List<DreamPlace> build() => listofplaces;

  void toggleFavorite(int id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavourite: !p.isFavorite) else p
    ];
  }
}

@riverpod
DreamPlace singleDreamPlace(Ref ref, int id) {
  final list = ref.watch(dreamPlacesProvider);
  return list.singleWhere((e) => e.id == id);
}
