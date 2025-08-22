class PlaceModel {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const PlaceModel({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  PlaceModel copyWith({bool? isFavorite}) {
    return PlaceModel(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}