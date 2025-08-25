class Place {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      imagePath: imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
