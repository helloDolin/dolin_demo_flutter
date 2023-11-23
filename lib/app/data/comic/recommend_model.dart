import 'package:json_annotation/json_annotation.dart';

part 'recommend_model.g.dart';

@JsonSerializable()
class RecommendModel {
  RecommendModel();
  factory RecommendModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendModelFromJson(json);
  @JsonKey(name: 'category_id')
  int? categoryId;
  int? sort;
  String? title;
  List<RecommendItemModel>? data;
  Map<String, dynamic> toJson() => _$RecommendModelToJson(this);
}

@JsonSerializable()
class RecommendItemModel {
  RecommendItemModel();
  factory RecommendItemModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendItemModelFromJson(json);

  int? id;
  String? cover;
  String? title;
  @JsonKey(name: 'sub_title')
  String? subTitle;
  int? type;
  String? url;
  @JsonKey(name: 'obj_id')
  int? objId;
  String? status;
  Map<String, dynamic> toJson() => _$RecommendItemModelToJson(this);
}
