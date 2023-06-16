// flutter pub run build_runner build --delete-conflicting-outputs
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class ModuleModel {
  ModuleModel();
  List<Module>? modules;
  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleModelToJson(this);
}

@JsonSerializable()
class Module {
  Module();
  String? name;
  List<String>? dependencies;
  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @override
  String toString() => '$name + $dependencies';
}
