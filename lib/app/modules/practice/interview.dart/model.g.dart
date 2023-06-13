// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => ModuleModel()
  ..modules = (json['modules'] as List<dynamic>?)
      ?.map((e) => Module.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ModuleModelToJson(ModuleModel instance) =>
    <String, dynamic>{
      'modules': instance.modules,
    };

Module _$ModuleFromJson(Map<String, dynamic> json) => Module()
  ..name = json['name'] as String?
  ..dependencies = (json['dependencies'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList();

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'name': instance.name,
      'dependencies': instance.dependencies,
    };
