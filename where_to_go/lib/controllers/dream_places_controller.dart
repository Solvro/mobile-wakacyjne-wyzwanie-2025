import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";

import "../models/dream_place.dart";
import "../repositories/dream_place_repository.dart";

final dreamPlacesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  return DreamPlacesRepository();
});

final dreamPlacesControllerProvider = StateNotifierProvider<DreamPlacesController, List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return DreamPlacesController(repo);
});

class DreamPlacesController extends StateNotifier<List<DreamPlace>> {
  final DreamPlacesRepository repository;
  Box<DreamPlace>? _box;
  StreamSubscription<BoxEvent>? _subscription;

  DreamPlacesController(this.repository) : super([]) {
    unawaited(_init());
  }

  Future<void> _init() async {
    _box = await repository.openBox();
    await repository.seedIfEmpty();

    final places = await repository.getAll();
    state = places;

    _subscription = _box!.watch().listen((event) {
      state = _box!.values.toList();
    });
  }

  Future<void> addPlace(DreamPlace place) async {
    await repository.add(place);
  }

  Future<void> deletePlace(int key) async {
    await repository.delete(key);
  }

  Future<void> toggleFavorite(int key) async {
    await repository.toggleFavorite(key);
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    // ignore: unawaited_futures
    _box?.close();
    super.dispose();
  }
}
