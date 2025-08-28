import "package:hive/hive.dart";
import "dreamplace.dart";

abstract class DreamPlacesRepository {
  Stream<List<DreamPlace>> watchAll();
  Future<List<DreamPlace>> getAll();

  Future<void> add(DreamPlace place);
  Future<void> update(DreamPlace place);
  Future<void> delete(String id);
  Future<void> toggleFavourite(String id);

  Future<void> seedIfEmpty();
}

class DreamPlacesRepositoryHive implements DreamPlacesRepository {
  static const boxName = "dream_places";

  final Box<DreamPlace> box;
  DreamPlacesRepositoryHive(this.box);

  @override
  Stream<List<DreamPlace>> watchAll() {
    return box.watch().map((_) => box.values.toList()).startWith(box.values.toList());
  }

  @override
  Future<List<DreamPlace>> getAll() async => box.values.toList();

  @override
  Future<void> add(DreamPlace place) => box.put(place.id, place);

  @override
  Future<void> update(DreamPlace place) => box.put(place.id, place);

  @override
  Future<void> delete(String id) => box.delete(id);

  @override
  Future<void> toggleFavourite(String id) async {
    final current = box.get(id);
    if (current == null) return;
    await box.put(id, current.copyWith(isFavourite: !current.isFavourite));
  }

  @override
  Future<void> seedIfEmpty() async {
    if (box.isNotEmpty) return;

    final sample = <DreamPlace>[
      const DreamPlace(
        id: "1",
        name: "Manchester, Anglia",
        description: "Miasto futbolu",
        assetPath: "assets/images/manchester.jpg",
        isFavourite: true,
      ),
      const DreamPlace(
        id: "2",
        name: "Santorini, Grecja",
        description: "Grecja",
        assetPath: "assets/images/santorini.jpg",
      ),
      const DreamPlace(
        id: "3",
        name: "Barcelona, Hiszpania",
        description: "Katalonia",
        assetPath: "assets/images/barcelona.jpg",
        isFavourite: true,
      ),
      const DreamPlace(
        id: "4",
        name: "Rzym, Włochy",
        description: "Makaron",
        assetPath: "assets/images/rome.jpg",
      ),
      const DreamPlace(
        id: "5",
        name: "Paryż, Francja",
        description: "Wieża",
        assetPath: "assets/images/paris.jpg",
      ),
    ];

    for (final p in sample) {
      await box.put(p.id, p);
    }
  }
}

extension _StartWith<T> on Stream<T> {
  Stream<T> startWith(T first) async* {
    yield first;
    yield* this;
  }
}
