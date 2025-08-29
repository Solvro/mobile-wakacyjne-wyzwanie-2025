import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/models/dream_place.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  List<DreamPlace> build() {
    // return ref.watch(dreamPlaceRepositoryImplProvider).value ?? [];
    return [];
  }

  // Future<void> toggleFavorite(String id) {
  //   // return ref.read(dreamPlaceRepositoryImplProvider.notifier).toggleFavorite(id);
  // }
}
