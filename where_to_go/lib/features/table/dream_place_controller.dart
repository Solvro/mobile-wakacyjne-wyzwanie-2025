import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "dream_place_providers.dart";
import "dream_place_table.dart";

class DreamPlaceController extends StateNotifier<AsyncValue<void>> {
  DreamPlaceController(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> toggleFavorite(DreamPlaceTableData place) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(dreamPlacesRepositoryProvider);
      await repo.updateIsFavorite(place.id, isFavorite: !place.isFavorite);
      state = const AsyncValue.data(null);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final dreamPlaceControllerProvider =
    StateNotifierProvider<DreamPlaceController, AsyncValue<void>>(
      DreamPlaceController.new,
    );
