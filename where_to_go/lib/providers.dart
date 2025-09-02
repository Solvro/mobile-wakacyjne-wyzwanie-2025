import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "app_database.dart";
import "repository.dart";

part "providers.g.dart";

@riverpod
AppDatabase database(Ref ref) {
  return AppDatabase();
}

// DreamPlaces
@riverpod
Repository repository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return Repository(db);
}

@riverpod
Stream<List<DreamPlace>> favoritePlaces(Ref ref) {
  final repo = ref.watch(repositoryProvider);
  return repo.watchFavoritePlaces();
}

@riverpod
Future<DreamPlace> placeDetails(Ref ref, int id) async {
  final repo = ref.watch(repositoryProvider);
  final place = await repo.getPlaceById(id);
  if (place == null) {
    throw Exception("Place not found");
  }
  return place;
}

@riverpod
Stream<List<DreamPlace>> allPlaces(Ref ref) {
  final repo = ref.watch(repositoryProvider);
  return repo.watchAllPlaces();
}

// InfoColumns
@riverpod
Stream<List<InfoColumn>> infoColumnsStream(Ref ref, int dreamPlaceId) {
  final repo = ref.watch(repositoryProvider);
  return repo.watchInfoColumnsByPlaceId(dreamPlaceId);
}

@riverpod
Future<List<InfoColumn>> infoColumns(Ref ref, int dreamPlaceId) async {
  final repo = ref.watch(repositoryProvider);
  return repo.getInfoColumnsByPlaceId(dreamPlaceId);
}
