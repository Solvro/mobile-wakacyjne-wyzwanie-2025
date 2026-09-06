import "package:drift/drift.dart";

import "../database/app_database.dart";
import "../features/places/places_provider.dart";

class DreamPlacesRepository {
  final AppDatabase _db;

  DreamPlacesRepository(this._db);

  // READ - pobieranie wszystkich miejsc z bazy danych
  Future<List<DreamPlace>> getAllPlaces() {
    return _db.select(_db.dreamPlaces).get();
  }

  // UPDATE - zmiana isFavorite
  Future<void> toggleFavorite(int id, bool currentStatus) async {
    await (_db.update(
      _db.dreamPlaces,
    )..where((tbl) => tbl.id.equals(id))).write(DreamPlacesCompanion(isFavorite: Value(!currentStatus)));
  }

  // SEED - zapelnianie bazy danych poczatkowymi danymi

  Future<void> seedDatabase() async {
    final existingPlaces = await _db.select(_db.dreamPlaces).get();
    if (existingPlaces.isNotEmpty) return; // jak baza nie jest pusta to nie seeduj jej

    final samplePlaces = initalPlaces
        .map(
          (p) => DreamPlacesCompanion.insert(
            title: p.title,
            descriptionTitle: p.descriptionTitle,
            description: p.description,
            imageUrl: p.image.path,
            isFavorite: Value(p.isFavorite),
          ),
        )
        .toList();

    await _db.batch((batch) {
      batch.insertAll(_db.dreamPlaces, samplePlaces);
    });
  }
}
