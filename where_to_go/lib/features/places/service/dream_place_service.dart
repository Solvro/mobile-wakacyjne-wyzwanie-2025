import "dart:io";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../app/remote/repository/dream_place_repository_impl.dart";
import "../../../app/remote/repository/photo_repository_impl.dart";
import "../../../data/models/create_place_dto.dart";
import "../../../data/models/dream_place.dart";

part "dream_place_service.g.dart";

@riverpod
class DreamPlaceService extends _$DreamPlaceService {
  @override
  Future<List<DreamPlace>> build() async {
    final repo = await ref.read(dreamPlaceRepositoryProvider.future);
    return repo.getAll();
  }

  Future<void> toggleFavorite(int id) async {
    final currentState = await future;
    final place = currentState.firstWhere((p) => p.id == id);
    final repo = await ref.read(dreamPlaceRepositoryProvider.future);
    final updated = await repo.toggleFavorite(id, newValue: !place.isFavourite);
    final newList = currentState.map((place) => (place.id == updated.id) ? updated : place).toList();
    state = AsyncValue.data(newList);
  }

  Future<DreamPlace> createDreamPlaceWithPhoto(CreatePlaceDTO place, File file) async {
    final placeRepo = await ref.read(dreamPlaceRepositoryProvider.future);
    final photoRepo = await ref.read(photoRepositoryProvider.future);
    final path = await photoRepo.uploadImage(file);
    final newPlace = await placeRepo.save(
        name: place.name!, description: place.description!, imageUrl: path, isFavourite: place.isFavourite!);

    state = AsyncData(await placeRepo.getAll());
    return newPlace;
  }
}

@riverpod
DreamPlace? placeById(Ref ref, int id) {
  final placesAsync = ref.watch(dreamPlaceServiceProvider);
  return placesAsync.whenData((places) => places.firstWhere((p) => p.id == id)).value;
}
