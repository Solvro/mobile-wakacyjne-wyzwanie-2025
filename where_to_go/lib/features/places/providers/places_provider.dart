import "dart:async";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/models/dream_place.dart";
import "../../../repository/implementation/dream_place_repository_impl.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  List<DreamPlace> build() {
    return ref.watch(dreamPlaceRepositoryImplProvider).value ?? [];
  }

  Future<void> toggleFavorite(String id) {
    return ref.read(dreamPlaceRepositoryImplProvider.notifier).toggleFavorite(id);
  }
}
