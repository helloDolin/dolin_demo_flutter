import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserLoginResponseEntity {
  String? accessToken;
  String? displayName;
  List<String>? channels;
  UserLoginResponseEntity();
  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginResponseEntityToJson(this);
}
