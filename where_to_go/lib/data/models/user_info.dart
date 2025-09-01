import "package:json_annotation/json_annotation.dart";

part "user_info.g.dart";

@JsonSerializable()
class UserInfo {
  final String email;
  final int iat;
  final int exp;

  UserInfo({
    required this.email,
    required this.iat,
    required this.exp,
  });
  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
