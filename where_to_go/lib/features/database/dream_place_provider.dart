import "package:flutter_riverpod/flutter_riverpod.dart";
import "dream_place_repository.dart";

final dreamPlaceRepositoryProvider = FutureProvider<DreamPlaceRepository>((ref) async {
  final repo = DreamPlaceRepository();
  await repo.initDatabase();
  return repo;
});

final dreamPlacesProvider = FutureProvider((ref) async {
  final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
  return repo.getAllDreamPlaces();
});

final toggleDreamPlaceFavouriteProvider = FutureProvider.family<void, int>((ref, id) async {
  print("toggling favourite");
  final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
  final isFavourite = await repo.toggleFavourite(id);
  print("isFavourite: $isFavourite");
  ref.invalidate(dreamPlacesProvider);
});
