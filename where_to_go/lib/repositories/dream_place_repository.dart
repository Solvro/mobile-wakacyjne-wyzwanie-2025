import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dream_place.dart';

final dreamPlaceRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  return DreamPlaceRepository();
});

class DreamPlaceRepository {
  static const boxName = 'dream_places';

  Future<void> addDreamPlace(DreamPlace place) async {
    final box = await Hive.openBox<DreamPlace>(boxName);
    await box.add(place);
  }

  Future<List<DreamPlace>> getDreamPlaces() async {
    final box = await Hive.openBox<DreamPlace>(boxName);
    return box.values.toList();
  }

  Future<void> deleteDreamPlace(int index) async {
    final box = await Hive.openBox<DreamPlace>(boxName);
    await box.deleteAt(index);
  }
}
