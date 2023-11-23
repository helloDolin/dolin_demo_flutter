import 'package:json_annotation/json_annotation.dart';

part 'comic_tag_model.g.dart';

@JsonSerializable()
class ComicTagMoel {
  ComicTagMoel();
  factory ComicTagMoel.fromJson(Map<String, dynamic> json) =>
      _$ComicTagMoelFromJson(json);
  @JsonKey(name: 'tag_id')
  int? tagId;

  @JsonKey(name: 'tag_name')
  String? tagName;
  Map<String, dynamic> toJson() => _$ComicTagMoelToJson(this);
}
