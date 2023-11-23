// flutter pub run build_runner build --delete-conflicting-outputs
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class ModuleModel {
  ModuleModel();
  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);
  List<Module>? modules;
  Map<String, dynamic> toJson() => _$ModuleModelToJson(this);
}

@JsonSerializable()
class Module {
  Module();
  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);
  String? name;
  List<String>? dependencies;
  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @override
  String toString() => '$name + $dependencies';
}
