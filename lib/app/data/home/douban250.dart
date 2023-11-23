// To parse this JSON data, do
//
//     final douban250 = douban250FromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'douban250.g.dart';

@JsonSerializable()

/// 豆瓣 250 模型
class Douban250 {
  /// 构造函数
  Douban250({
    this.data,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.originalName,
    this.imdbVotes,
    this.imdbRating,
    this.rottenRating,
    this.rottenVotes,
    this.year,
    this.imdbId,
    this.alias,
    this.doubanId,
    this.type,
    this.doubanRating,
    this.doubanVotes,
    this.duration,
    this.dateReleased,
  });

  /// fromJson 构造
  factory Douban250.fromJson(Map<String, dynamic> json) =>
      _$Douban250FromJson(json);

  String get shareImage {
    return data?.first.poster ?? '';
  }

  @JsonKey(name: 'data')
  List<Datum>? data;
  @JsonKey(name: 'createdAt')
  int? createdAt;
  @JsonKey(name: 'updatedAt')
  int? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'originalName')
  String? originalName;
  @JsonKey(name: 'imdbVotes')
  int? imdbVotes;
  @JsonKey(name: 'imdbRating')
  String? imdbRating;
  @JsonKey(name: 'rottenRating')
  String? rottenRating;
  @JsonKey(name: 'rottenVotes')
  int? rottenVotes;
  @JsonKey(name: 'year')
  String? year;
  @JsonKey(name: 'imdbId')
  String? imdbId;
  @JsonKey(name: 'alias')
  String? alias;
  @JsonKey(name: 'doubanId')
  String? doubanId;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'doubanRating')
  String? doubanRating;
  @JsonKey(name: 'doubanVotes')
  int? doubanVotes;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'dateReleased')
  DateTime? dateReleased;

  Map<String, dynamic> toJson() => _$Douban250ToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.poster,
    this.name,
    this.genre,
    this.description,
    this.language,
    this.country,
    this.lang,
    this.shareImage,
    this.movie,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
  @JsonKey(name: 'createdAt')
  int? createdAt;
  @JsonKey(name: 'updatedAt')
  int? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'poster')
  String? poster;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'genre')
  String? genre;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'language')
  String? language;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'lang')
  String? lang;
  @JsonKey(name: 'shareImage')
  String? shareImage;
  @JsonKey(name: 'movie')
  String? movie;

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
