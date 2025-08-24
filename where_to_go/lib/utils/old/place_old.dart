import "../../models/attraction.dart";

class PlaceOld {
  final String title;
  final String text;
  final String path;
  final List<Attraction> attractionList;

  bool isFavorite = false;

  PlaceOld(this.title, this.text, this.path, this.attractionList);
}
