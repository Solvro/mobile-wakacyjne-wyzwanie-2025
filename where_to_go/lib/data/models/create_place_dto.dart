import "package:json_annotation/json_annotation.dart";

part "create_place_dto.g.dart";

@JsonSerializable(includeIfNull: false)
class CreatePlaceDTO {
  final String? name;
  final String? description;
  final String? imageUrl;
  final bool? isFavourite;

  CreatePlaceDTO({
    this.name,
    this.description,
    this.imageUrl,
    this.isFavourite,
  });

  factory CreatePlaceDTO.fromJson(Map<String, dynamic> json) => _$CreatePlaceDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePlaceDTOToJson(this);
}
