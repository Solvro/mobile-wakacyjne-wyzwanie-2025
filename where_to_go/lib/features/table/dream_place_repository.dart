import "package:drift/drift.dart";

import "dream_place_table.dart";

class DreamPlaceRepository {
  final AppDatabase db;

  DreamPlaceRepository(this.db);

  Future<int> addPlace(DreamPlaceTableCompanion place){
    return db.into(db.dreamPlaceTable).insert(place);
  }

  Future<List<DreamPlaceTableData>> getAllPlaces(){
    return db.select(db.dreamPlaceTable).get();
  }

  Future<DreamPlaceTableData> getPlace(int id){
    return (db.select(db.dreamPlaceTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Stream<List<DreamPlaceTableData>> watchAllPlaces() {
    return db.select(db.dreamPlaceTable).watch();
  }

  Future<bool> updatePlace(DreamPlaceTableCompanion place) {
    return db.update(db.dreamPlaceTable).replace(place);
  }

  Future<int> updateIsFavorite(int id, {required bool isFavorite}) {
    return (db.update(db.dreamPlaceTable)..where((tbl) => tbl.id.equals(id))).write(DreamPlaceTableCompanion(isFavorite: Value(isFavorite)));
  }

  Future<int> deletePlace(int id){
    return (db.delete(db.dreamPlaceTable)..where((tbl) => tbl.id.equals(id))).go();
  }

   Future<void> seedDatabase() async {
    final existing = await getAllPlaces();
    if (existing.isNotEmpty) return;

    final samplePlaces = [
      DreamPlaceTableCompanion.insert(
        name: "Paryż",
        description: "Miasto miłości",
        imageUrl: "https://example.com/paris.jpg",
        isFavorite: const Value(true),
      ),
      DreamPlaceTableCompanion.insert(
        name: "Tokio",
        description: "Nowoczesna metropolia",
        imageUrl: "https://example.com/tokyo.jpg",
      ),
      DreamPlaceTableCompanion.insert(
        name: "Nowy Jork",
        isFavorite: const Value(true),
        imageUrl: "https://example.com/nyc.jpg",
        description: "Jork New"
      ),
      DreamPlaceTableCompanion.insert(
        name: "Rzym",
        isFavorite: const Value(false),
        imageUrl: "https://example.com/rome.jpg",
        description: "Papyrus got better pasta"
      ),
    ];

    await db.batch((batch) {
      batch.insertAll(db.dreamPlaceTable, samplePlaces);
    });
  }
}
