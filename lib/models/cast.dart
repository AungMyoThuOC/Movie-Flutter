import 'dart:convert';

class Cast {
  Cast({
    required this.avatarUrl,
    required this.cast,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.bannerUrl,
    required this.posterUrl,
    required this.title,
    required this.rating,
    required this.starRating,
    required this.categories,
    required this.storyline,
    required this.photoUrls,
    required this.actors,
  });

  final String? avatarUrl;
  final List cast;
  final String? bannerUrl;
  final String? posterUrl;
  final String? title;
  final double? rating;
  final int? starRating;
  final List<String>? categories;
  final String? storyline;
  final List<String>? photoUrls;
  final List<Cast>? actors;
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
      cast: json['cast'],
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"].toDouble(),
      profilePath: json["profile_path"],
      castId: json["cast_id"],
      character: json["character"],
      creditId: json["credit_id"],
      order: json["order"],
      avatarUrl: json["avatarUrl"],
      bannerUrl: json["bannerUrl"],
      posterUrl: json["posterUrl"],
      title: json["title"],
      rating: json["rating"],
      starRating: json["starRating"],
      categories: json["categories"],
      storyline: json["storyline"],
      photoUrls: json["photoUrls"],
      actors: json["actors"]);

  Map<String, dynamic> toJson() => {
        "cast": cast,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "avatarUrl": avatarUrl,
        "bannerUrl": bannerUrl,
        "posterUrl": posterUrl,
        "title": title,
        "rating": rating,
        "starRating": starRating,
        "categories": categories,
        "storyline": storyline,
        "photoUrls": photoUrls,
        "actors": actors,
      };
}
