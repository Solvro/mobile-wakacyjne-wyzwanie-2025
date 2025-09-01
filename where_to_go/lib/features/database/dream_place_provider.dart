import "package:riverpod_annotation/riverpod_annotation.dart";
import "dream_place_repository.dart";

@riverpod
final dreamPlaceRepositoryProvider = FutureProvider<DreamPlaceRepository>((ref) {
  final repo = DreamPlaceRepository();

  return repo;
});

@riverpod
final dreamPlacesProvider = FutureProvider((ref) async {
  final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
  final dreamPlaces = await repo.getAllDreamPlaces(ref);
  return dreamPlaces;
});

@riverpod
final toggleDreamPlaceFavouriteProvider = FutureProvider.family<void, int>((ref, id) async {
  final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
  await repo.toggleFavourite(id);
  ref.invalidate(dreamPlacesProvider);
});
