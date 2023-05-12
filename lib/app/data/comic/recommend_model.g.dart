// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendModel _$RecommendModelFromJson(Map<String, dynamic> json) =>
    RecommendModel()
      ..categoryId = json['category_id'] as int?
      ..sort = json['sort'] as int?
      ..title = json['title'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => RecommendItemModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RecommendModelToJson(RecommendModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'sort': instance.sort,
      'title': instance.title,
      'data': instance.data,
    };

RecommendItemModel _$RecommendItemModelFromJson(Map<String, dynamic> json) =>
    RecommendItemModel()
      ..id = json['id'] as int?
      ..cover = json['cover'] as String?
      ..title = json['title'] as String?
      ..subTitle = json['sub_title'] as String?
      ..type = json['type'] as int?
      ..url = json['url'] as String?
      ..objId = json['obj_id'] as int?
      ..status = json['status'] as String?;

Map<String, dynamic> _$RecommendItemModelToJson(RecommendItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'title': instance.title,
      'sub_title': instance.subTitle,
      'type': instance.type,
      'url': instance.url,
      'obj_id': instance.objId,
      'status': instance.status,
    };
