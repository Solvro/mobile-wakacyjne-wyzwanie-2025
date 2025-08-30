import "../data/models/dream_place.dart";

abstract class DreamPlaceRepository {
  const DreamPlaceRepository();

  Future<List<DreamPlace>> getAll();

  Future<DreamPlace> get(int id);

  Future<void> delete(int id);

  Future<DreamPlace> save({
    required String name,
    required String description,
    required String imageUrl,
    required String ownerEmail,
    bool isFavourite = false,
  });

  Future<DreamPlace> updatePlace(
    int id, {
    String? name,
    String? description,
    String? imageUrl,
    String? ownerEmail,
    bool? isFavourite,
  });

  Future<DreamPlace> toggleFavorite(int id, {required bool newValue});
}
