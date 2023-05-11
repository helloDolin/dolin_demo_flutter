// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponseEntity _$UserLoginResponseEntityFromJson(
        Map<String, dynamic> json) =>
    UserLoginResponseEntity()
      ..accessToken = json['accessToken'] as String?
      ..displayName = json['displayName'] as String?
      ..channels = (json['channels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$UserLoginResponseEntityToJson(
        UserLoginResponseEntity instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'displayName': instance.displayName,
      'channels': instance.channels,
    };
