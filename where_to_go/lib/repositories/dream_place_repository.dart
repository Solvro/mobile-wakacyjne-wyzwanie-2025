import "package:drift/drift.dart";
import "../database/app_database.dart";

class DreamPlacesRepository {
  final AppDatabase db;

  DreamPlacesRepository(this.db);

  Future<List<DreamPlace>> getAll() => db.select(db.dreamPlaces).get();

  Future<DreamPlace?> getById(int id) {
    return (db.select(db.dreamPlaces)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> add(DreamPlacesCompanion entry) => db.into(db.dreamPlaces).insert(entry);

  Future<void> updatePlace(DreamPlace place) => db.update(db.dreamPlaces).replace(place);

  Future<void> delete(int id) => (db.delete(db.dreamPlaces)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> toggleFavorite(DreamPlace place) async {
    await updatePlace(place.copyWith(isFavorite: !place.isFavorite));
  }

  Future<void> seedIfEmpty() async {
    final count = await db.select(db.dreamPlaces).get();
    if (count.isNotEmpty) return;

    final examples = [
      DreamPlacesCompanion.insert(
        name: "Sycylia, Włochy",
        description: const Value("Wulkan Etna i piękne plaże"),
        imageUrl: const Value("assets/images/sycylia.png"),
        isFavorite: const Value(true),
      ),
      DreamPlacesCompanion.insert(
        name: "Santorini, Grecja",
        description: const Value("Białe domki nad morzem"),
        imageUrl: const Value("assets/images/santorini.png"),
      ),
      DreamPlacesCompanion.insert(
        name: "Bali, Indonezja",
        description: const Value("Świątynie i tropikalne plaże"),
        imageUrl: const Value("assets/images/bali.jpg"),
        isFavorite: const Value(true),
      ),
    ];

    for (final e in examples) {
      await add(e);
    }
  }
}
