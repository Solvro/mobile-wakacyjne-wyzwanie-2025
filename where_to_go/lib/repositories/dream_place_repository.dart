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
    // place.key is now assigned after saving; you can also do place.save()
    return key;
  }

  /// UPDATE
  Future<void> update(DreamPlace place) async {
    // place.key musi być ustawione (czyli obiekt był wcześniej zapisany)
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
        name: 'Paryż',
        description: 'Miasto świateł',
        imageUrl:
            'https://images.unsplash.com/photo-1543340713-8d1a8aa71f06?w=1200',
        isFavorite: true,
      ),
      DreamPlace(
        name: 'Tokio',
        description: 'Futurystyczna metropolia',
        imageUrl:
            'https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?w=1200',
      ),
      DreamPlace(
        name: 'Nowy Jork',
        description: 'Miasto, które nigdy nie śpi',
        imageUrl:
            'https://images.unsplash.com/photo-1529624463034-8b35f53f1e6b?w=1200',
        isFavorite: true,
      ),
      DreamPlace(
        name: 'Rzym',
        description: 'Historia na każdym kroku',
        imageUrl:
            'https://images.unsplash.com/photo-1543352634-87367e72b32d?w=1200',
      ),
      DreamPlace(
        name: 'Sydney',
        description: 'Opera House i plaże',
        imageUrl:
            'https://images.unsplash.com/photo-1506976785307-8732e854ad75?w=1200',
        isFavorite: true,
      ),
    ];

    for (final p in sample) {
      await box.add(p);
    }
  }
}
