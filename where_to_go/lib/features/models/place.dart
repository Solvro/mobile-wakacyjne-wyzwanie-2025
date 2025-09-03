import "attraction.dart";

class Place {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String placeName;
  final List<Attraction> attractions;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.placeName,
    required this.attractions,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      imagePath: imagePath,
      placeName: placeName,
      attractions: attractions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
