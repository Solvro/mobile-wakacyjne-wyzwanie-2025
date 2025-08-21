import "attraction.dart";

class Place {
  final String id;
  final String title;
  final String description;
  final String path;
  final bool isFavorite;
  final List<Attraction> attractionList;

  const Place(
      {required this.id,
      required this.title,
      required this.description,
      required this.path,
      this.isFavorite = false,
      required this.attractionList});

  Place copyWith({bool? isFavorite}) {
    return Place(
        id: id,
        title: title,
        description: description,
        path: path,
        isFavorite: isFavorite ?? this.isFavorite,
        attractionList: attractionList);
  }
}
