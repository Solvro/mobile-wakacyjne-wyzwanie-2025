import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";

import "../../models/attraction.dart";
import "../../models/place.dart";
import "tables/attraction_db.dart";
import "tables/dream_place_attractions_db.dart";
import "tables/dream_place_db.dart";
import "utils.dart";

part "dream_places_database.g.dart";

@DriftDatabase(tables: [DreamPlaceDb, AttractionDb, DreamPlaceAttractionsDb])
class DreamPlacesDatabase extends _$DreamPlacesDatabase {
  DreamPlacesDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: "bucket_list_db");
  }

  Future<Place> getPlace(String id) async {
    final intId = int.parse(id);
    final query = _getQueryHelper()..where(dreamPlaceDb.id.equals(intId));

    final rows = await query.get();
    final row = rows.first;
    final dreamPlace = row.readTable(dreamPlaceDb);

    final place = _getPlaceHelper(dreamPlace);

    for (final row in rows) {
      final attraction = row.readTable(attractionDb);
      place.attractionList.add(Attraction(attraction.name, iconMapper(attraction.iconName)));
    }

    return place;
  }

  Future<List<Place>> getAllPlaces() async {
    final query = _getQueryHelper();

    final rows = await query.get();
    final Map<int, Place> placeMap = {};

    for (final row in rows) {
      final dreamPlace = row.readTable(dreamPlaceDb);
      final attraction = row.readTable(attractionDb);

      placeMap.putIfAbsent(dreamPlace.id, () => _getPlaceHelper(dreamPlace));

      placeMap[dreamPlace.id]!.attractionList.add(_getAttractionHelper(attraction));
    }

    return placeMap.values.toList();
  }

  Future<void> updateFavorite(String id) async {
    final intId = int.parse(id);
    final row = await (select(dreamPlaceDb)..where((tbl) => tbl.id.equals(intId))).getSingle();

    await (update(dreamPlaceDb)..where((tbl) => tbl.id.equals(row.id)))
        .write(DreamPlaceDbCompanion(isFavorite: Value(!row.isFavorite)));
  }

  Place _getPlaceHelper(DreamPlaceDbData dreamPlace) {
    return Place(
      id: dreamPlace.id.toString(),
      title: dreamPlace.name,
      description: dreamPlace.description,
      path: dreamPlace.imageUrl,
      isFavorite: dreamPlace.isFavorite,
      attractionList: [],
    );
  }

  Attraction _getAttractionHelper(AttractionDbData attraction) {
    return Attraction(attraction.name, iconMapper(attraction.iconName));
  }

  JoinedSelectStatement<HasResultSet, dynamic> _getQueryHelper() {
    return select(dreamPlaceDb).join([
      leftOuterJoin(
        dreamPlaceAttractionsDb,
        dreamPlaceAttractionsDb.dreamPlaceId.equalsExp(dreamPlaceDb.id),
      ),
      leftOuterJoin(
        attractionDb,
        attractionDb.id.equalsExp(dreamPlaceAttractionsDb.attractionId),
      ),
    ]);
  }
}
