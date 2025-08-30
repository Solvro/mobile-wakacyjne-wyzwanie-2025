import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/models/dream_place.dart";
import "../../../repository/implementation/dream_place_repository_impl.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  Future<List<DreamPlace>> build() async {
    final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
    return repo.getAll();
  }

  Future<void> toggleFavorite(int id) async {
    final currentState = await future;
    final place = currentState.firstWhere((p) => p.id == id);
    final repo = await ref.read(dreamPlaceRepositoryProvider.future);
    final updated = await repo.toggleFavorite(id, newValue: !place.isFavourite);
    final newList = currentState.map((place) => (place.id == updated.id) ? updated : place).toList();
    state = AsyncValue.data(newList);
  }
}

@riverpod
DreamPlace? placeById(Ref ref, int id) {
  final placesAsync = ref.watch(placesProvider);
  return placesAsync.whenData((places) => places.firstWhere((p) => p.id == id)).value;
}
