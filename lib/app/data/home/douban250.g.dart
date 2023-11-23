// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'douban250.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Douban250 _$Douban250FromJson(Map<String, dynamic> json) => Douban250(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      id: json['id'] as String?,
      originalName: json['originalName'] as String?,
      imdbVotes: json['imdbVotes'] as int?,
      imdbRating: json['imdbRating'] as String?,
      rottenRating: json['rottenRating'] as String?,
      rottenVotes: json['rottenVotes'] as int?,
      year: json['year'] as String?,
      imdbId: json['imdbId'] as String?,
      alias: json['alias'] as String?,
      doubanId: json['doubanId'] as String?,
      type: json['type'] as String?,
      doubanRating: json['doubanRating'] as String?,
      doubanVotes: json['doubanVotes'] as int?,
      duration: json['duration'] as int?,
      dateReleased: json['dateReleased'] == null
          ? null
          : DateTime.parse(json['dateReleased'] as String),
    );

Map<String, dynamic> _$Douban250ToJson(Douban250 instance) => <String, dynamic>{
      'data': instance.data,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'originalName': instance.originalName,
      'imdbVotes': instance.imdbVotes,
      'imdbRating': instance.imdbRating,
      'rottenRating': instance.rottenRating,
      'rottenVotes': instance.rottenVotes,
      'year': instance.year,
      'imdbId': instance.imdbId,
      'alias': instance.alias,
      'doubanId': instance.doubanId,
      'type': instance.type,
      'doubanRating': instance.doubanRating,
      'doubanVotes': instance.doubanVotes,
      'duration': instance.duration,
      'dateReleased': instance.dateReleased?.toIso8601String(),
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      id: json['id'] as String?,
      poster: json['poster'] as String?,
      name: json['name'] as String?,
      genre: json['genre'] as String?,
      description: json['description'] as String?,
      language: json['language'] as String?,
      country: json['country'] as String?,
      lang: json['lang'] as String?,
      shareImage: json['shareImage'] as String?,
      movie: json['movie'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'poster': instance.poster,
      'name': instance.name,
      'genre': instance.genre,
      'description': instance.description,
      'language': instance.language,
      'country': instance.country,
      'lang': instance.lang,
      'shareImage': instance.shareImage,
      'movie': instance.movie,
    };
