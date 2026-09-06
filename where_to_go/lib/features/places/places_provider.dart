import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../database/database_provider.dart";
import "../../gen/assets.gen.dart";
import "../../models/place.dart";
import "../../models/place_feature.dart";

part "places_provider.g.dart";

final initalPlaces = [
  Place(
    id: 1,
    title: "🇨🇾 Pafos, Cypr",
    descriptionTitle: "Nadmorskie miasteczko na Cyprze",
    description: "Piękne widoki, malownicze plaże i urokliwe ulice",
    image: Assets.images.pafos,
    features: [
      const PlaceFeature(Icons.wb_sunny, "Słońce"),
      const PlaceFeature(Icons.beach_access, "Plaże"),
      const PlaceFeature(Icons.restaurant, "Jedzenie"),
    ],
  ),
  Place(
    id: 2,
    title: "🇮🇹 Rzym, Włochy",
    descriptionTitle: "Antyczne miasto pełne zabytków",
    description: "Wiele znalezisk archeologicznych, centrum kultury",
    image: Assets.images.rzym,
    features: [
      const PlaceFeature(Icons.local_fire_department, "Gladiatorzy"),
      const PlaceFeature(Icons.dinner_dining, "Wyśmienite dania"),
      const PlaceFeature(Icons.local_see, "Mnóstwo atrakcji"),
    ],
  ),
  Place(
    id: 3,
    title: "🇪🇸 Barcelona, Hiszpania",
    descriptionTitle: "Stolica katalońskiego modernizmu",
    description: "Niezwykła architektura Gaudiego, piaszczyste plaże i tętniąca życiem ulica La Rambla.",
    image: Assets.images.barcelona,
    features: [
      const PlaceFeature(Icons.beach_access, "Plaża"),
      const PlaceFeature(Icons.architecture, "Architektura"),
      const PlaceFeature(Icons.palette, "Sztuka"),
    ],
  ),
  Place(
    id: 4,
    title: "🇲🇩 Kiszyniów, Mołdawia",
    descriptionTitle: "Najbardziej zielona stolica Europy",
    description: "Spokojne miasto z licznymi parkami, brutalistyczną architekturą i słynnymi winiarniami w okolicy.",
    image: Assets.images.kiszyniow,
    features: [
      const PlaceFeature(Icons.park, "Parki"),
      const PlaceFeature(Icons.wine_bar, "Wino"),
      const PlaceFeature(Icons.church, "Zabytki"),
    ],
  ),
  Place(
    id: 5,
    title: "🇫🇷 Nicea, Francja",
    descriptionTitle: "Perła Lazurowego Wybrzeża",
    description: "Elegancka promenada Anglików, błękitne morze i urokliwe stare miasto Vieux Nice.",
    image: Assets.images.nicea,
    features: [
      const PlaceFeature(Icons.sailing, "Morze"),
      const PlaceFeature(Icons.shopping_bag, "Butiki"),
      const PlaceFeature(Icons.wb_sunny, "Pogoda"),
    ],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  Future<List<Place>> build() async {
    final repo = ref.watch(dreamPlacesRepositoryProvider);

    await repo.seedDatabase();

    final dbPlaces = await repo.getAllPlaces();

    return dbPlaces.map((dbPlace) {
      // dla kazdego place w places
      final initalMatch = initalPlaces.firstWhere(
        // znajdz jego features w liscie initialPlaces
        (p) => p.title == dbPlace.title,
        orElse: () => initalPlaces
            .first, // jesli w bazie jest miejsce, ktorego nie ma w initialplaces to uzyj ikon pierwszego miejsca
      );
      return Place(
        // zwroc obiekt Place wraz ze wszystkimi features
        id: dbPlace.id,
        title: dbPlace.title,
        descriptionTitle: dbPlace.descriptionTitle,
        description: dbPlace.description,
        image: AssetGenImage(dbPlace.imageUrl),
        features: initalMatch.features,
        isFavorite: dbPlace.isFavorite,
      );
    }).toList(); // jako lista places
  }

  Future<void> toggleFavorite(int id) async {
    final repo = ref.read(dreamPlacesRepositoryProvider); // polaczenie z baza danych

    final currentPlace = state.value?.firstWhere(
      (p) => p.id == id,
    ); // szukamy miejsca z odpowiednim id, to ktorego chcemy zmienic favorite
    if (currentPlace == null) return; // jak nie znajdziemy to przerywamy dzialanie funkcji

    await repo.toggleFavorite(id, currentStatus: currentPlace.isFavorite); // zcalluj metode w repo ktora toggluje favorite

    ref.invalidateSelf(); // odswiez UI -> uruchom build() jeszcze raz
  }
}
