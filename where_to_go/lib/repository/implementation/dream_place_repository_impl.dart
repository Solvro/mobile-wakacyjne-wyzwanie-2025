import "package:drift/drift.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../app/persistance/database/drift_database.dart" hide Attraction, DreamPlace;
import "../../app/persistance/database/helpers/dream_place_attraction.dart";
import "../../data/models/attraction.dart";
import "../../data/models/dream_place.dart";
import "../dream_place_repository.dart";
import "attraction_converter_helper.dart";

part "dream_place_repository_impl.g.dart";

@riverpod
class DreamPlaceRepositoryImpl extends _$DreamPlaceRepositoryImpl implements DreamPlaceRepository {
  late final AppDatabase _db = ref.read(appDatabaseProvider);

  DreamPlace _fromDbModel(DreamPlaceWithAttractions dbModel) {
    final place = dbModel.place;
    final attractions = dbModel.attractions.map(attractionFromValue).toList();

    return DreamPlace(
      id: place.id.toString(),
      title: place.name,
      description: place.description,
      location: place.location,
      imagePath: place.imageUrl,
      attractions: attractions,
      isFavorited: place.isFavorited,
    );
  }

  @override
  Stream<List<DreamPlace>> build() {
    return _db.watchDreamPlacesWithAttractions().map(
          (dbList) => dbList.map(_fromDbModel).toList(),
        );
  }

  @override
  Future<List<DreamPlace>> getAll() async {
    final dbList = await _db.getDreamPlacesWithAttractions();
    return dbList.map(_fromDbModel).toList();
  }

  @override
  Future<DreamPlace> get(String id) async {
    final intId = int.parse(id);
    final dbPlace = await _db.getSingleDreamPlace(intId);
    return _fromDbModel(dbPlace);
  }

  @override
  Future<void> delete(String id) async {
    final intId = int.parse(id);
    await _db.deleteDreamPlace(intId);
  }

  @override
  Future<DreamPlace> save({
    required String name,
    required String description,
    required String location,
    required String imageUrl,
    bool isFavorited = false,
    List<Attraction> attractions = const [],
  }) async {
    final attractionValues = attractions.map(valueFromAttraction).toList();
    final companion = DreamPlacesCompanion(
      name: Value(name),
      description: Value(description),
      location: Value(location),
      imageUrl: Value(imageUrl),
      isFavorited: Value(isFavorited),
    );

    final inserted = await _db.insertDreamPlaceWithAttractions(
      placeCompanion: companion,
      attractionsList: attractionValues,
    );
    return _fromDbModel(inserted);
  }

  @override
  Future<DreamPlace> updatePlace(
    String id, {
    String? name,
    String? description,
    String? location,
    String? imageUrl,
    bool? isFavorited,
    List<Attraction>? attractions,
  }) async {
    final intId = int.parse(id);
    final attractionValues = attractions?.map(valueFromAttraction).toList();
    final companion = DreamPlacesCompanion(
      name: name != null ? Value(name) : const Value.absent(),
      description: description != null ? Value(description) : const Value.absent(),
      location: location != null ? Value(location) : const Value.absent(),
      imageUrl: imageUrl != null ? Value(imageUrl) : const Value.absent(),
      isFavorited: isFavorited != null ? Value(isFavorited) : const Value.absent(),
    );
    final updated = await _db.updateDreamPlaceWithAttractions(
      intId,
      placeCompanion: companion,
      attractionsList: attractionValues,
    );
    return _fromDbModel(updated);
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final intId = int.parse(id);
    await _db.setFavourite(intId, isFavorite: !(await get(id)).isFavorited);
  }
}
