import "package:hive_ce/hive.dart";

part "dream_place.g.dart";

@HiveType(typeId: 1)
class DreamPlace {
  DreamPlace({
    required this.id,
    required this.placeText,
    required this.image,
    required this.titleText,
    required this.descriptionText,
    required this.attractions,
    this.isFavorite = false,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String placeText;

  @HiveField(2)
  String image;

  @HiveField(3)
  String titleText;

  @HiveField(4)
  String descriptionText;

  @HiveField(5)
  List<Attraction> attractions;

  @HiveField(6)
  bool isFavorite;

  DreamPlace copyWith({
    String? id,
    String? placeText,
    String? image,
    String? titleText,
    String? descriptionText,
    bool? isFavorite,
    List<Attraction>? attractions,
  }) {
    return DreamPlace(
      id: id ?? this.id,
      placeText: placeText ?? this.placeText,
      image: image ?? this.image,
      titleText: titleText ?? this.titleText,
      descriptionText: descriptionText ?? this.descriptionText,
      isFavorite: isFavorite ?? this.isFavorite,
      attractions: attractions ?? this.attractions,
    );
  }
}

@HiveType(typeId: 2)
class Attraction {
  @HiveField(0)
  int icon;

  @HiveField(1)
  String text;

  Attraction({
    required this.icon,
    required this.text,
  });
}
