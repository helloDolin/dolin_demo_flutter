// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserLoginResponseEntity {
  UserLoginResponseEntity();
  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseEntityFromJson(json);
  String? accessToken;
  String? displayName;
  List<String>? channels;
  Map<String, dynamic> toJson() => _$UserLoginResponseEntityToJson(this);
}
