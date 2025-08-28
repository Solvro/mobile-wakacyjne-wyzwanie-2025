//import "../models/attraction.dart";
import "../models/place.dart";

abstract class DreamPlacesRepository {
  Future<Place?> read(String id);
  Future<List<Place>> readAll();
  Future<void> toggleFavorite(String id);
  /*Future<Place> create(
      {String title, String description, String path, bool isFavorite = false, List<Attraction> attractionList});
  Future<Place> delete(String id);*/
}
