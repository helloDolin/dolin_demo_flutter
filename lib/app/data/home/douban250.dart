import 'dart:convert';

List<Douban250> douban250FromList(List list) {
  List<Douban250> res = [];
  if (list.isNotEmpty) {
    for (var element in list) {
      res.add(Douban250.fromJson(element));
    }
  }
  return res;
}

String douban250ToJson(List<Douban250> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Douban250 {
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

  List<Datum>? data;
  int? createdAt;
  int? updatedAt;
  String? id;
  String? originalName;
  int? imdbVotes;
  String? imdbRating;
  String? rottenRating;
  int? rottenVotes;
  String? year;
  String? imdbId;
  String? alias;
  String? doubanId;
  Type? type;
  String? doubanRating;
  int? doubanVotes;
  int? duration;
  DateTime? dateReleased;

  String get shareImage {
    if (data!.isNotEmpty) {
      Datum obj = data![0];
      if (obj.poster != null) {
        return obj.poster!;
      }
      return '';
    }
    return '';
  }

  factory Douban250.fromJson(Map<String, dynamic> json) => Douban250(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        originalName: json["originalName"],
        imdbVotes: json["imdbVotes"],
        imdbRating: json["imdbRating"],
        rottenRating: json["rottenRating"],
        rottenVotes: json["rottenVotes"],
        year: json["year"],
        imdbId: json["imdbId"],
        alias: json["alias"],
        doubanId: json["doubanId"],
        type: typeValues.map[json["type"]] ?? Type.MOVIE,
        doubanRating: json["doubanRating"],
        doubanVotes: json["doubanVotes"],
        duration: json["duration"],
        dateReleased: json["dateReleased"] == null
            ? null
            : DateTime.parse(json["dateReleased"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "originalName": originalName,
        "imdbVotes": imdbVotes,
        "imdbRating": imdbRating,
        "rottenRating": rottenRating,
        "rottenVotes": rottenVotes,
        "year": year,
        "imdbId": imdbId,
        "alias": alias,
        "doubanId": doubanId,
        "type": typeValues.reverse[type],
        "doubanRating": doubanRating,
        "doubanVotes": doubanVotes,
        "duration": duration,
        "dateReleased":
            "${dateReleased!.year.toString().padLeft(4, '0')}-${dateReleased!.month.toString().padLeft(2, '0')}-${dateReleased!.day.toString().padLeft(2, '0')}",
      };
}

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

  int? createdAt;
  int? updatedAt;
  String? id;
  String? poster;
  String? name;
  String? genre;
  String? description;
  String? language;
  String? country;
  Lang? lang;
  String? shareImage;
  String? movie;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        poster: json["poster"],
        name: json["name"],
        genre: json["genre"],
        description: json["description"],
        language: json["language"],
        country: json["country"],
        lang: langValues.map[json["lang"]]!,
        shareImage: json["shareImage"],
        movie: json["movie"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "poster": poster,
        "name": name,
        "genre": genre,
        "description": description,
        "language": language,
        "country": country,
        "lang": langValues.reverse[lang],
        "shareImage": shareImage,
        "movie": movie,
      };
}

enum Lang { CN }

final langValues = EnumValues({"Cn": Lang.CN});

enum Type { MOVIE }

final typeValues = EnumValues({"Movie": Type.MOVIE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
