import "../drift_database.dart";
import "../tables/attractions.dart";

class DreamPlaceWithAttractions {
  final DreamPlace place;
  final List<AttractionValue> attractions;

  DreamPlaceWithAttractions({
    required this.place,
    required this.attractions,
  });
}
