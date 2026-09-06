import "package:riverpod_annotation/riverpod_annotation.dart";

import "../repositories/dream_places_repository.dart";
import "app_database.dart";

part "database_provider.g.dart";

@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@riverpod
DreamPlacesRepository dreamPlacesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DreamPlacesRepository(db);
}
