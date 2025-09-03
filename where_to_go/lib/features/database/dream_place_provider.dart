import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "dream_place_database.dart";
import "dream_place_repository.dart";

part "dream_place_provider.g.dart";

@riverpod
DreamPlaceDatabase dreamPlaceDatabase(Ref ref) {
  return DreamPlaceDatabase();
}

@riverpod
DreamPlaceRepository dreamPlaceRepository(Ref ref) {
  final db = ref.watch(dreamPlaceDatabaseProvider);
  return DreamPlaceRepository(db);
}

@riverpod
Future<List<DreamPlace>> dreamPlaces(Ref ref) async {
  final repo = ref.watch(dreamPlaceRepositoryProvider);
  return repo.getAllPlaces();
}
