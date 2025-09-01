class DreamPlace {
  final int? id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isFavourite;

  const DreamPlace({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isFavourite = false,
  });
}
