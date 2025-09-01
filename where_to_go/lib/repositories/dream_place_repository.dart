import 'package:hive/hive.dart';
import '../models/dream_place.dart';

class DreamPlacesRepository {
  static const String boxName = 'dream_places_box';

  /// Open the Hive box (if not already open)
  Future<Box<DreamPlace>> _openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<DreamPlace>(boxName);
    }
    return await Hive.openBox<DreamPlace>(boxName);
  }

  /// READ all
  Future<List<DreamPlace>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// READ by key (id)
  Future<DreamPlace?> getByKey(int key) async {
    final box = await _openBox();
    return box.get(key);
  }

  /// CREATE
  Future<int> add(DreamPlace place) async {
    final box = await _openBox();
    final key = await box.add(place);
    return key;
  }

  /// UPDATE
  Future<void> update(DreamPlace place) async {
    if (place.key == null) {
      throw Exception('Object has no key. Use add() for new items.');
    }
    await place.save();
  }

  /// DELETE by key
  Future<void> delete(int key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  /// Toggle favorite
  Future<void> toggleFavorite(int key) async {
    final box = await _openBox();
    final place = box.get(key);
    if (place != null) {
      place.isFavorite = !place.isFavorite;
      await place.save();
    }
  }

  /// Seed sample data if box is empty
  Future<void> seedIfEmpty() async {
    final box = await _openBox();
    if (box.isNotEmpty) return;

    final sample = [
      DreamPlace(
        name: "Sycylia, Włochy",
        description: "Wulkan Etna i piękne plaże",
        imageUrl: "assets/images/sycylia.png",
        isFavorite: true,
      ),
      DreamPlace(
        name: "Santorini, Grecja",
        description: "Białe domki nad morzem",
        imageUrl: "assets/images/santorini.png",
        isFavorite: false,
      ),
      DreamPlace(
        name: "Bali, Indonezja",
        description: "Świątynie i tropikalne plaże",
        imageUrl: "assets/images/bali.jpg",
        isFavorite: true,
      ),
      DreamPlace(
        name: "Nowy Jork, USA",
        description: "Central Park i wieżowce",
        imageUrl: "assets/images/nowyJork.jpg",
        isFavorite: false,
      ),
      DreamPlace(
        name: "Tokio, Japonia",
        description: "Technologia i kultura",
        imageUrl: "assets/images/tokio.png",
        isFavorite: true,
      ),
    ];

    for (final p in sample) {
      await box.add(p);
    }
  }

  /// Clear all data
  Future<void> clearAll() async {
    final box = await _openBox();
    await box.clear();
  }

  /// Public method for controller
  Future<Box<DreamPlace>> openBox() async {
    return await _openBox();
  }
}
