import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "dream_place_repository.dart";

@riverpod
final dreamPlaceRepositoryProvider = FutureProvider<DreamPlaceRepository>((ref) {
  final repo = DreamPlaceRepository();
  // repo.dio.interceptors.add(LogInterceptor(
  //   requestBody: true,
  //   responseBody: true,
  //   responseHeader: false,
  // ));

  return repo;
});

@riverpod
final dreamPlacesProvider = FutureProvider((ref) async {
  final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
  print("dreamPlacesProvider is called");
  final dreamPlaces = await repo.getAllDreamPlaces(ref);
  print("dreamPlaces: $dreamPlaces");
  return dreamPlaces;
});

@riverpod
final toggleDreamPlaceFavouriteProvider = FutureProvider.family<void, int>((ref, id) async {
  final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
  await repo.toggleFavourite(id);
  ref.invalidate(dreamPlacesProvider);
});
