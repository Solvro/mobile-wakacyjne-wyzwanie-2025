import "package:freezed_annotation/freezed_annotation.dart";

part "dream_place.freezed.dart";
part "dream_place.g.dart";

@freezed
abstract class DreamPlace with _$DreamPlace {
  const factory DreamPlace({
    int? id,
    required String name,
    required String description,
    required String imageUrl,
    required bool isFavorite,
  }) = _DreamPlace;

  factory DreamPlace.fromJson(Map<String, dynamic> json) => _$DreamPlaceFromJson(json);
}
