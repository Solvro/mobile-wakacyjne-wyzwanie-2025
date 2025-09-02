import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";
import "package:path_provider/path_provider.dart";

import "tables/dream_places_table.dart";
import "tables/info_columns_table.dart";

part "app_database.g.dart";

@DriftDatabase(tables: [DreamPlaces, InfoColumns])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
        name: "app_db",
        native: const DriftNativeOptions(
          databaseDirectory: getApplicationDocumentsDirectory,
        ));
  }

  // DreamPlace
  Future<List<DreamPlace>> getAllPlaces() => select(dreamPlaces).get();

  Future<List<DreamPlace>> getFavoritePlaces() =>
      (select(dreamPlaces)..where((tbl) => tbl.isFavorite.equals(true))).get();

  Future<DreamPlace?> getPlaceById(int id) =>
      (select(dreamPlaces)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<int> insertPlace(DreamPlacesCompanion place) => into(dreamPlaces).insert(place);

  Future<int> updateFavorite(int id, {required bool isFavorite}) =>
      (update(dreamPlaces)..where((tbl) => tbl.id.equals(id)))
          .write(DreamPlacesCompanion(isFavorite: Value(isFavorite)));

  Future<int> deletePlace(int id) => (delete(dreamPlaces)..where((tbl) => tbl.id.equals(id))).go();

  // InfoColumns
  Future<List<InfoColumn>> getInfoColumnsByPlaceId(int dreamPlaceId) =>
      (select(infoColumns)..where((tbl) => tbl.dreamPlaceId.equals(dreamPlaceId))).get();

  Future<int> insertInfoColumn(InfoColumnsCompanion column) => into(infoColumns).insert(column);

  Future<int> updateInfoColumn(int id, {String? iconName, String? infoText}) =>
      (update(infoColumns)..where((tbl) => tbl.id.equals(id))).write(InfoColumnsCompanion(
        iconName: iconName != null ? Value(iconName) : const Value.absent(),
        infoText: infoText != null ? Value(infoText) : const Value.absent(),
      ));

  Future<int> deleteInfoColumn(int id) => (delete(infoColumns)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> deleteInfoColumnsByPlaceId(int dreamPlaceId) =>
      (delete(infoColumns)..where((tbl) => tbl.dreamPlaceId.equals(dreamPlaceId))).go();
}
