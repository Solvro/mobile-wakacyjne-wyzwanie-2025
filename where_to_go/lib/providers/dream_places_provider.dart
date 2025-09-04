import "package:flutter_riverpod/flutter_riverpod.dart";
import "../models/dream_place.dart";
import "../repositories/dream_place_repository.dart";
import "http_client_provider.dart"; // tu masz authenticationRepositoryProvider -> Dio

/// Provider repozytorium DreamPlace
final dreamPlaceRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  final dio = ref.watch(authenticationRepositoryProvider);
  return DreamPlaceRepository(apiUrl: "${dio.options.baseUrl}dream-places");
});

/// Provider do listy miejsc marzeń
final dreamPlacesProvider = FutureProvider<List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlaceRepositoryProvider);
  return repo.fetchDreamPlaces();
});
