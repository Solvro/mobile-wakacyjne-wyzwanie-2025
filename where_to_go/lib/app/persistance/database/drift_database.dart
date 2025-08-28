import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "helpers/dream_place_attraction.dart";
import "tables/attractions.dart";
import "tables/dream_places.dart";

part "drift_database.g.dart";

@DriftDatabase(tables: [DreamPlaces, Attractions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static const appDatabaseName = "app_database";

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: appDatabaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Stream<List<DreamPlaceWithAttractions>> watchDreamPlacesWithAttractions() {
    return select(dreamPlaces).watch().asyncMap((places) async {
      return Future.wait(places.map((place) async {
        final rows = await (select(attractions)..where((a) => a.id.equals(place.id))).get();

        final values = rows.map((a) => a.attractionValue).toList();
        return DreamPlaceWithAttractions(
          place: place,
          attractions: values,
        );
      }));
    });
  }

  Future<List<DreamPlaceWithAttractions>> getDreamPlacesWithAttractions() async {
    final places = await select(dreamPlaces).get();
    return Future.wait(places.map((place) async {
      final rows = await (select(attractions)..where((a) => a.id.equals(place.id))).get();

      final values = rows.map((a) => a.attractionValue).toList();
      return DreamPlaceWithAttractions(
        place: place,
        attractions: values,
      );
    }));
  }

  Future<DreamPlaceWithAttractions> getSingleDreamPlace(int id) async {
    final place = await (select(dreamPlaces)..where((t) => t.id.equals(id))).getSingle();
    final attractionRows = await (select(attractions)..where((a) => a.id.equals(id))).get();

    final attractionValues = attractionRows.map((a) => a.attractionValue).toList();
    return DreamPlaceWithAttractions(
      place: place,
      attractions: attractionValues,
    );
  }

  Future<void> deleteDreamPlace(int id) async {
    await transaction(() async {
      await (delete(attractions)..where((a) => a.id.equals(id))).go();
      await (delete(dreamPlaces)..where((p) => p.id.equals(id))).go();
    });
  }

  Future<DreamPlaceWithAttractions> insertDreamPlaceWithAttractions({
    required DreamPlacesCompanion placeCompanion,
    List<AttractionValue> attractionsList = const [],
  }) async {
    final placeId = await transaction(() async {
      final placeId = await into(dreamPlaces).insert(placeCompanion);

      for (final attraction in attractionsList) {
        await into(attractions).insert(
          AttractionsCompanion.insert(
            id: placeId,
            attractionValue: attraction,
          ),
        );
      }
      return placeId;
    });
    return getSingleDreamPlace(placeId);
  }

  Future<DreamPlaceWithAttractions> updateDreamPlaceWithAttractions(
    int id, {
    required DreamPlacesCompanion placeCompanion,
    List<AttractionValue>? attractionsList,
  }) async {
    await transaction(() async {
      final updatedPlace = placeCompanion.copyWith(
        id: Value(id),
      );

      await update(dreamPlaces).replace(updatedPlace);
      if (attractionsList != null) {
        await (delete(attractions)..where((a) => a.id.equals(id))).go();

        for (final attraction in attractionsList) {
          await into(attractions).insert(
            AttractionsCompanion.insert(
              id: id,
              attractionValue: attraction,
            ),
          );
        }
      }
    });
    return getSingleDreamPlace(id);
  }

  Future<void> setFavourite(int id, {required bool isFavorite}) {
    return (update(dreamPlaces)..where((p) => p.id.equals(id))).write(
      DreamPlacesCompanion(
        isFavorited: Value(isFavorite),
      ),
    );
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => AppDatabase();
