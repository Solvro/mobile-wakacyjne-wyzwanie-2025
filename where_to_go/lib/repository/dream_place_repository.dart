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
    required String imageUrl,
    bool isFavorited = false,
    List<Attraction> attractions = const [],
  });

  Future<DreamPlace> update(
    String id, {
    String? name,
    String? description,
    String? imageUrl,
    bool? isFavorited,
    List<Attraction>? attractions,
  });

  Future<void> toggleFavorite(String id);
}
