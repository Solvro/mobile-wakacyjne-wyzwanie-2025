import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../models/place.dart";
import "../../utils/place_list.dart";

part "places_provider.g.dart";

final _initialPlaces = placesList;

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
