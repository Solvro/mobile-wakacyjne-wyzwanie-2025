import "../models/place.dart";
import "../utils/database/dream_places_database.dart";
import "dream_places_repository.dart";

class DreamPlacesRepositoryImpl implements DreamPlacesRepository {
  final DreamPlacesDatabase _db;

  DreamPlacesRepositoryImpl(this._db);

  @override
  Future<List<Place>> readAll() async => _db.getAllPlaces();

  @override
  Future<void> toggleFavorite(String id) async => _db.updateFavorite(id);

  @override
  Future<Place?> read(String id) async => _db.getPlace(id);
}
