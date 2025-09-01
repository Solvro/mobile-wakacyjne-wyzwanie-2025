import "package:json_annotation/json_annotation.dart";

part "image_dto.g.dart";

@JsonSerializable()
class ImageDTO {
  final String id;
  final String filename;
  final String originalName;
  final String mimeType;
  final int size;
  final String path;
  final DateTime createdAt;

  ImageDTO({
    required this.id,
    required this.filename,
    required this.originalName,
    required this.mimeType,
    required this.size,
    required this.path,
    required this.createdAt,
  });

  factory ImageDTO.fromJson(Map<String, dynamic> json) => _$ImageDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDTOToJson(this);
}
