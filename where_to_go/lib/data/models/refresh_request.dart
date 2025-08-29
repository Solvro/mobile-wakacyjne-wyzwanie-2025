import "package:json_annotation/json_annotation.dart";

part "refresh_request.g.dart";

@JsonSerializable()
class RefreshRequest {
  final String refreshToken;

  RefreshRequest({required this.refreshToken});

  factory RefreshRequest.fromJson(Map<String, dynamic> json) => _$RefreshRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshRequestToJson(this);
}
