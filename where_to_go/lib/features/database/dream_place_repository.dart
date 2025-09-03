import "dream_place_database.dart";

class DreamPlaceRepository {
  final DreamPlaceDatabase db;

  DreamPlaceRepository(this.db);

  Future<List<DreamPlace>> getAllPlaces() => db.getAllPlaces();

  Future<void> toggleFavourite(DreamPlace place) async {
    final updated = place.copyWith(isFavourite: !place.isFavourite);
    await db.updatePlace(updated);
  }

  Future<void> addPlace(DreamPlacesCompanion entry) => db.insertPlace(entry);

  Future<void> deletePlace(int id) => db.deletePlace(id);

  Future<void> updatePlace(DreamPlace place) => db.updatePlace(place);
}
