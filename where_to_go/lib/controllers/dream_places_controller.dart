// lib/controllers/dream_places_controller.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/dream_place.dart';
import '../repositories/dream_place_repository.dart';

final dreamPlacesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  return DreamPlacesRepository();
});

final dreamPlacesControllerProvider =
    StateNotifierProvider<DreamPlacesController, List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return DreamPlacesController(repo);
});

class DreamPlacesController extends StateNotifier<List<DreamPlace>> {
  final DreamPlacesRepository repository;
  Box<DreamPlace>? _box;
  StreamSubscription<BoxEvent>? _subscription;

  DreamPlacesController(this.repository) : super([]) {
    _init();
  }

  Future<void> _init() async {
    _box = await repository._openBox();
    // seed the database if empty
    await repository.seedIfEmpty();

    // initial load
    state = _box!.values.toList();

    // listen to changes in the box and update state accordingly
    _subscription = _box!.watch().listen((event) {
      // whenever something changes, refresh the state
      state = _box!.values.toList();
    });
  }

  Future<void> addPlace(DreamPlace place) async {
    await repository.add(place);
    // repository.add will trigger box.watch -> subscription updates state
  }

  Future<void> deletePlace(int key) async {
    await repository.delete(key);
  }

  Future<void> toggleFavorite(int key) async {
    await repository.toggleFavorite(key);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
