class DreamPlace {
  final String id;
  final String name;
  final String description;
  final String assetPath;
  final bool isFavourite;

  const DreamPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.assetPath,
    this.isFavourite = false,
  });

  DreamPlace copyWith({
    String? id,
    String? name,
    String? description,
    String? assetPath,
    bool? isFavourite,
  }) {
    return DreamPlace(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      assetPath: assetPath ?? this.assetPath,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
