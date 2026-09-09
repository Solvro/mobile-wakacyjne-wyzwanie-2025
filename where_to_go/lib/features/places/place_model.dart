class DreamPlace {
  final int? id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isFavourite;

  DreamPlace({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isFavourite,
  });

  factory DreamPlace.fromJson(Map<String, dynamic> json) {
    return DreamPlace(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      isFavourite: json['isFavourite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'isFavourite': isFavourite,
    };
  }
}
