import "package:json_annotation/json_annotation.dart";

part "create_place.g.dart";

@JsonSerializable(includeIfNull: false)
class CreatePlace {
  final String? name;
  final String? description;
  final String? imageUrl;
  final bool? isFavourite;

  CreatePlace({
    this.name,
    this.description,
    this.imageUrl,
    this.isFavourite,
  });

  factory CreatePlace.fromJson(Map<String, dynamic> json) => _$CreatePlaceFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePlaceToJson(this);
}
