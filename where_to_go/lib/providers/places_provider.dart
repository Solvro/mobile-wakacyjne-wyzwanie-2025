import "package:riverpod_annotation/riverpod_annotation.dart";
import "../hive/boxes.dart";
import "../hive/dream_place.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  List<DreamPlace> build() {
    return boxDreamPlaces.values.cast<DreamPlace>().toList();
  }

  void setPlaces(List<DreamPlace> places) {
    state = places;
  }

  Future<void> toggleFavorite(String id) async {
    final index = state.indexWhere((place) => place.id == id);
    if (index == -1) return;

    final place = state[index];
    final updatedPlace = place.copyWith(isFavorite: !place.isFavorite);

    await boxDreamPlaces.putAt(index, updatedPlace);

    final newList = [...state];
    newList[index] = updatedPlace;
    state = newList;
  }
}
