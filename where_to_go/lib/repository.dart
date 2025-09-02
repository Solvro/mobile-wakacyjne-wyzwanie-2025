import "app_database.dart";

class Repository {
  final AppDatabase _db;
  Repository(this._db);

  // DreamPlaces
  Future<List<DreamPlace>> getAllPlaces() => _db.getAllPlaces();

  Stream<List<DreamPlace>> watchAllPlaces() {
    return _db.select(_db.dreamPlaces).watch();
  }

  Future<List<DreamPlace>> getFavoritePlaces() => _db.getFavoritePlaces();

  Stream<List<DreamPlace>> watchFavoritePlaces() {
    return (_db.select(_db.dreamPlaces)..where((tbl) => tbl.isFavorite.equals(true))).watch();
  }

  Future<DreamPlace?> getPlaceById(int id) async {
    final list = await (_db.select(_db.dreamPlaces)..where((tbl) => tbl.id.equals(id))).get();
    return list.isNotEmpty ? list.first : null;
  }

  Future<void> addPlace(DreamPlacesCompanion place) async {
    await _db.insertPlace(place);
  }

  Future<void> updateFavorite(int id, {required bool isFavorite}) async {
    await _db.updateFavorite(id, isFavorite: isFavorite);
  }

  Future<void> deletePlace(int id) async {
    await _db.deletePlace(id);
  }

  Future<int> deleteAllPlaces() async {
    return _db.delete(_db.dreamPlaces).go();
  }

  // InfoColumns
  Future<List<InfoColumn>> getInfoColumnsByPlaceId(int dreamPlaceId) {
    return _db.getInfoColumnsByPlaceId(dreamPlaceId);
  }

  Stream<List<InfoColumn>> watchInfoColumnsByPlaceId(int dreamPlaceId) {
    return (_db.select(_db.infoColumns)..where((tbl) => tbl.dreamPlaceId.equals(dreamPlaceId))).watch();
  }

  Future<void> addInfoColumn(InfoColumnsCompanion column) async {
    await _db.insertInfoColumn(column);
  }

  Future<void> updateInfoColumn(int id, InfoColumnsCompanion column) async {
    await _db.updateInfoColumn(id, iconName: column.iconName.value, infoText: column.infoText.value);
  }

  Future<void> deleteInfoColumn(int id) async {
    await _db.deleteInfoColumn(id);
  }

  Future<void> deleteInfoColumnsByPlaceId(int dreamPlaceId) async {
    await _db.deleteInfoColumnsByPlaceId(dreamPlaceId);
  }
}
