import "package:flutter_riverpod/flutter_riverpod.dart";
import "dream_place_repository.dart";
import "dream_place_table.dart";

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final dreamPlacesRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DreamPlaceRepository(db);
});

final dreamPlacesProvider = StreamProvider<List<DreamPlaceTableData>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.watchAllPlaces();
});
