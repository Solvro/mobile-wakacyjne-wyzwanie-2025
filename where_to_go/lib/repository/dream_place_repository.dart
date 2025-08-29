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
    required String ownerEmail,
    bool isFavorited = false,
  });

  Future<DreamPlace> updatePlace(
    String id, {
    String? name,
    String? description,
    String? imageUrl,
    String? ownerEmail,
    bool? isFavorited,
  });

  Future<void> toggleFavorite(String id);
}
