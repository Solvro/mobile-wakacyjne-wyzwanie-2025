import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";

import "dreamplace.dart";
import "dreamplacerep.dart";

final dreamPlacesBoxProvider = Provider<Box<DreamPlace>>((ref) {
  return Hive.box<DreamPlace>(DreamPlacesRepositoryHive.boxName);
});

final dreamPlacesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  final box = ref.read(dreamPlacesBoxProvider);
  return DreamPlacesRepositoryHive(box);
});

final dreamPlacesStreamProvider = StreamProvider<List<DreamPlace>>((ref) {
  final repo = ref.read(dreamPlacesRepositoryProvider);
  return repo.watchAll();
});

final dreamPlacesActionsProvider = Provider<DreamPlacesRepository>((ref) {
  return ref.read(dreamPlacesRepositoryProvider);
});
