import "package:json_annotation/json_annotation.dart";

part "dream_place.g.dart";

@JsonSerializable()
class DreamPlace {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isFavourite;
  final String ownerEmail;

  DreamPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isFavourite,
    required this.ownerEmail,
  });

  factory DreamPlace.fromJson(Map<String, dynamic> json) => _$DreamPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$DreamPlaceToJson(this);
}
