import "../../models/attraction.dart";

class PlaceOld {
  final String title;
  final String text;
  final String path;
  final List<Attraction> attractionList;

  bool isFavorite = false;

  PlaceOld({required this.title, required this.text, required this.path, required this.attractionList});
}
