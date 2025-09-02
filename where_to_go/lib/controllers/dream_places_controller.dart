import "dart:async";
import "package:flutter_riverpod/flutter_riverpod.dart";
// import "package:drift/drift.dart";
import "../database/app_database.dart";
import "../repositories/dream_place_repository.dart";

final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final dreamPlacesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DreamPlacesRepository(db);
});

final dreamPlacesControllerProvider = StateNotifierProvider<DreamPlacesController, List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return DreamPlacesController(repo);
});

class DreamPlacesController extends StateNotifier<List<DreamPlace>> {
  final DreamPlacesRepository repository;

  DreamPlacesController(this.repository) : super([]) {
    unawaited(_init());
  }

  Future<void> _init() async {
    await repository.seedIfEmpty();
    state = await repository.getAll();
  }

  Future<void> addPlace(DreamPlacesCompanion entry) async {
    await repository.add(entry);
    state = await repository.getAll();
  }

  Future<void> deletePlace(int id) async {
    await repository.delete(id);
    state = await repository.getAll();
  }

  Future<void> toggleFavorite(DreamPlace place) async {
    await repository.toggleFavorite(place);
    state = await repository.getAll();
  }
}
