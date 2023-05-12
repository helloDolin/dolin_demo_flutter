import 'package:json_annotation/json_annotation.dart';

part 'recommend_model.g.dart';

@JsonSerializable()
class RecommendModel {
  @JsonKey(name: 'category_id')
  int? categoryId;
  int? sort;
  String? title;
  List<RecommendItemModel>? data;
  RecommendModel();
  factory RecommendModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendModelToJson(this);
}

@JsonSerializable()
class RecommendItemModel {
  RecommendItemModel();

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
  factory RecommendItemModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendItemModelToJson(this);
}
