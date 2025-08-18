import "attraction.dart";

class DreamPlace {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imagePath;
  final List<Attraction> attractions;
  final bool isFavorited;

  const DreamPlace(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.imagePath,
      required this.attractions,
      this.isFavorited = false});

  DreamPlace copyWith({bool? isFavorited}) {
    return DreamPlace(
      id: id,
      title: title,
      description: description,
      location: location,
      imagePath: imagePath,
      attractions: attractions,
      isFavorited: isFavorited ?? this.isFavorited,
    );
  }
}
