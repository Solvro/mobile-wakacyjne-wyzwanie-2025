import "../../gen/assets.gen.dart";

class Place {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final AssetGenImage image;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      subtitle: subtitle,
      description: description,
      image: image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
