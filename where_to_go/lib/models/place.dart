import "attraction.dart";

class Place {
  final String title;
  final String text;
  final String path;
  final List<Attraction> attractionList;

  bool isFavorite = false;

  Place(this.title, this.text, this.path, this.attractionList);
}
