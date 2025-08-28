import "../data/models/attraction.dart";
import "../data/models/dream_place.dart";

abstract class DreamPlaceRepository {
  const DreamPlaceRepository();

  Future<List<DreamPlace>> getAll();

  Future<DreamPlace> get(String id);

  Future<void> delete(String id);

  Future<DreamPlace> save({
    required String name,
    required String description,
    required String location,
    required String imageUrl,
    bool isFavorited = false,
    List<Attraction> attractions = const [],
  });

  Future<DreamPlace> updatePlace(
    String id, {
    String? name,
    String? description,
    String? location,
    String? imageUrl,
    bool? isFavorited,
    List<Attraction>? attractions,
  });

  Future<void> toggleFavorite(String id);
}
