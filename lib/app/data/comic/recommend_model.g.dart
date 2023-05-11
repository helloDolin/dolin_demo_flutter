// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendModel _$RecommendModelFromJson(Map<String, dynamic> json) =>
    RecommendModel()
      ..categoryId = json['categoryId'] as int?
      ..title = json['title'] as String?
      ..sort = json['sort'] as int?;

Map<String, dynamic> _$RecommendModelToJson(RecommendModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'title': instance.title,
      'sort': instance.sort,
    };

RecommendItemModel _$RecommendItemModelFromJson(Map<String, dynamic> json) =>
    RecommendItemModel()
      ..id = json['id'] as int?
      ..cover = json['cover'] as String?
      ..title = json['title'] as String?
      ..subTitle = json['subTitle'] as String?
      ..type = json['type'] as int?
      ..url = json['url'] as String?
      ..objId = json['objId'] as int?
      ..status = json['status'] as String?;

Map<String, dynamic> _$RecommendItemModelToJson(RecommendItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'type': instance.type,
      'url': instance.url,
      'objId': instance.objId,
      'status': instance.status,
    };
