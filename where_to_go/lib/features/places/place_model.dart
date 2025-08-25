import "place_feature.dart";

class PlaceModel {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;
  final List<PlaceFeature> features;

  const PlaceModel({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
    required this.features,
  });

  PlaceModel copyWith({bool? isFavorite}) {
    return PlaceModel(
      id: id,
      title: title,
      description: description,
      features: features,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
