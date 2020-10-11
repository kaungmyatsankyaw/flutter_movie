// To parse this JSON data, do
//
//     final tvList = tvListFromJson(jsonString);

import 'dart:convert';

List<TvList> tvListFromJson(String str) =>
    List<TvList>.from(json.decode(str).map((x) => TvList.fromJson(x)));

String tvListToJson(List<TvList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TvList {
  TvList({
    this.originalName,
    this.genreIds,
    this.name,
    this.popularity,
    this.originCountry,
    this.voteCount,
    this.firstAirDate,
    this.backdropPath,
    this.originalLanguage,
    this.id,
    this.voteAverage,
    this.overview,
    this.posterPath,
  });

  String originalName;
  List<int> genreIds;
  String name;
  double popularity;
  List<OriginCountry> originCountry;
  int voteCount;
  DateTime firstAirDate;
  String backdropPath;
  OriginalLanguage originalLanguage;
  int id;
  double voteAverage;
  String overview;
  String posterPath;

  factory TvList.fromJson(Map<String, dynamic> json) => TvList(
        originalName: json["original_name"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        name: json["name"],
        popularity: json["popularity"].toDouble(),
        originCountry: List<OriginCountry>.from(
            json["origin_country"].map((x) => originCountryValues.map[x])),
        voteCount: json["vote_count"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        backdropPath: json["backdrop_path"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        id: json["id"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        posterPath: "https://image.tmdb.org/t/p/original" + json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "original_name": originalName,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "name": name,
        "popularity": popularity,
        "origin_country": List<dynamic>.from(
            originCountry.map((x) => originCountryValues.reverse[x])),
        "vote_count": voteCount,
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "backdrop_path": backdropPath,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "id": id,
        "vote_average": voteAverage,
        "overview": overview,
        "poster_path": posterPath,
      };
}

enum OriginCountry { US, ES, MX, CO }

final originCountryValues = EnumValues({
  "CO": OriginCountry.CO,
  "ES": OriginCountry.ES,
  "MX": OriginCountry.MX,
  "US": OriginCountry.US
});

enum OriginalLanguage { EN, ES }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "es": OriginalLanguage.ES});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
