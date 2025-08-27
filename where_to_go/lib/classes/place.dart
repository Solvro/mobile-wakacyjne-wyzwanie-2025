class Place {
  final String id;
  final String title;
  final String description;
  final String image;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      image: image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
