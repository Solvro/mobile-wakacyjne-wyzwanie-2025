import "package:riverpod_annotation/riverpod_annotation.dart";
import "place_model.dart";

part "places_provider.g.dart";

const _initialPlaces = [
  PlaceModel(id: "1", title: "Santorini, Grecja", description: "Białe domki nad morzem"),
  PlaceModel(id: "2", title: "Kioto, Japonia", description: "Świątynie i ogrody"),
];

@riverpod
class Places extends _$Places {
  @override
  List<PlaceModel> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}