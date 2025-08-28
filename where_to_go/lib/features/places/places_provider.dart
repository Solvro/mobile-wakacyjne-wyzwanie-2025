import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../models/place.dart";
import "../../utils/database/providers/database_provider.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  Future<List<Place>> build() async {
    final db = await ref.watch(databaseProvider.future);
    return db.getAllPlaces();
  }

  Future<void> toggleFavorite(String id) async {
    final db = await ref.watch(databaseProvider.future);
    await db.updateFavorite(id);

    ref.invalidateSelf();
    ref.invalidate(placeProvider(id));
  }
}

@riverpod
Future<Place> place(Ref ref, String id) async {
  final db = await ref.watch(databaseProvider.future);
  return db.getPlace(id);
}
