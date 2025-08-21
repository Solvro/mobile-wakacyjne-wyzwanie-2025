import "attraction.dart";

class DreamPlace {
  DreamPlace(this.title, this.description, this.location, this.imagePath, this.attractions);

  final String title;
  final String description;
  final String location;
  final String imagePath;
  final List<Attraction> attractions;
  bool isFavorited = false;
}
