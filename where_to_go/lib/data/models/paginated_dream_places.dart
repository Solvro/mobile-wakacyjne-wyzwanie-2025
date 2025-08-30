import "package:json_annotation/json_annotation.dart";

import "dream_place.dart";

part "paginated_dream_places.g.dart";

@JsonSerializable()
class PaginatedDreamPlaces {
  final int total;
  final int page;
  final int perPage;
  final List<DreamPlace> results;

  PaginatedDreamPlaces({
    required this.total,
    required this.page,
    required this.perPage,
    required this.results,
  });

  factory PaginatedDreamPlaces.fromJson(Map<String, dynamic> json) => _$PaginatedDreamPlacesFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedDreamPlacesToJson(this);
}
