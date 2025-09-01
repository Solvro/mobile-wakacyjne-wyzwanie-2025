import "package:json_annotation/json_annotation.dart";

part "refresh_response.g.dart";

@JsonSerializable()
class RefreshResponse {
  final String accessToken;

  RefreshResponse({required this.accessToken});

  factory RefreshResponse.fromJson(Map<String, dynamic> json) => _$RefreshResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshResponseToJson(this);
}
