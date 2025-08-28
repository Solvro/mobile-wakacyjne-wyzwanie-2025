import "package:drift/drift.dart";

import "attraction_db.dart";
import "dream_place_db.dart";

class DreamPlaceAttractionsDb extends Table {
  late final dreamPlaceId = integer().references(DreamPlaceDb, #id)();
  late final attractionId = integer().references(AttractionDb, #id)();
}
