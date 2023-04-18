import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

// class UserLoginResponseEntity {
//   String? accessToken;
//   String? displayName;
//   List<String>? channels;

//   UserLoginResponseEntity({
//     this.accessToken,
//     this.displayName,
//     this.channels,
//   });

//   factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
//       UserLoginResponseEntity(
//         accessToken: json["access_token"],
//         displayName: json["display_name"],
//         channels: List<String>.from(json["channels"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "access_token": accessToken,
//         "display_name": displayName,
//         "channels":
//             channels == null ? [] : List<dynamic>.from(channels!.map((x) => x)),
//       };
// }

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
