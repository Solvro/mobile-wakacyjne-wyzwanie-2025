import "package:riverpod_annotation/riverpod_annotation.dart";
import "place.dart";

part "places_provider.g.dart";

const _initialPlaces = [
  Place(
    id: "1",
    title: "Sycylia, Włochy",
    description: "Wulkan Etna i piękne plaże",
    imagePath: "assets/images/sycylia.png",
  ),
  Place(
    id: "2",
    title: "Santorini, Grecja",
    description: "Białe domki nad morzem",
    imagePath: "assets/images/santorini.png",
  ),
  Place(
    id: "3",
    title: "Bali, Indonezja",
    description: "Świątynie i tropikalne plaże",
    imagePath: "assets/images/bali.jpg",
  ),
  Place(
    id: "4",
    title: "Nowy Jork, USA",
    description: "Central Park i wieżowce",
    imagePath: "assets/images/nowyJork.jpg",
  ),
  Place(
    id: "5",
    title: "Tokio, Japonia",
    description: "Technologia i kultura",
    imagePath: "assets/images/tokio.png",
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}
