import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../data/places.dart";
import "../../../data/models/dream_place.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  List<DreamPlace> build() => dreamPlacesList;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorited: !p.isFavorited) else p
    ];
  }
}
