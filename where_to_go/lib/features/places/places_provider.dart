import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth_provider.dart';
import 'place_model.dart';
import 'places_repository.dart';

final placesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  return DreamPlacesRepository(ref.watch(apiClientProvider));
});

final placesProvider = FutureProvider<List<DreamPlace>>((ref) async {
  final repository = ref.watch(placesRepositoryProvider);
  return repository.getPlaces();
});

class PlacesNotifier {
  final DreamPlacesRepository _repository;
  final Ref _ref;

  PlacesNotifier(this._repository, this._ref);

  Future<void> toggleFavorite(int id, bool currentStatus) async {
    await _repository.toggleFavorite(id, currentStatus);
    _ref.invalidate(placesProvider);
  }
}

final placesNotifierProvider = Provider<PlacesNotifier>((ref) {
  final repository = ref.watch(placesRepositoryProvider);
  return PlacesNotifier(repository, ref);
});
