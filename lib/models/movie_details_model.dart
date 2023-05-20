import 'dart:convert';

class MovieDetailsModel {
  MovieDetailsModel({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website,
    required this.response,
  });

  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final List<RatingModel> ratings;
  final String imdbRating;
  final String imdbVotes;
  final String imdbId;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;
  final String response;

  factory MovieDetailsModel.fromRawJson(String str) =>
      MovieDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailsModel(
        title: json["Title"] ?? "",
        year: json["Year"] ?? "",
        rated: json["Rated"] ?? "",
        released: json["Released"] ?? "",
        runtime: json["Runtime"] ?? "",
        genre: json["Genre"] ?? "",
        director: json["Director"] ?? "",
        writer: json["Writer"] ?? "",
        actors: json["Actors"] ?? "",
        plot: json["Plot"] ?? "",
        language: json["Language"] ?? "",
        country: json["Country"] ?? "",
        awards: json["Awards"] ?? "",
        poster: json["Poster"] ?? "",
        ratings: List<RatingModel>.from(
            json["Ratings"].map((x) => RatingModel.fromJson(x)) ?? []),
        imdbRating: json["imdbRating"] ?? "",
        imdbVotes: json["imdbVotes"] ?? "",
        imdbId: json["imdbID"] ?? "",
        type: json["Type"] ?? "",
        dvd: json["DVD"] ?? "",
        boxOffice: json["BoxOffice"] ?? "",
        production: json["Production"] ?? "",
        website: json["Website"] ?? "",
        response: json["Response"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "Rated": rated,
        "Released": released,
        "Runtime": runtime,
        "Genre": genre,
        "Director": director,
        "Writer": writer,
        "Actors": actors,
        "Plot": plot,
        "Language": language,
        "Country": country,
        "Awards": awards,
        "Poster": poster,
        "Ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "imdbRating": imdbRating,
        "imdbVotes": imdbVotes,
        "imdbID": imdbId,
        "Type": type,
        "DVD": dvd,
        "BoxOffice": boxOffice,
        "Production": production,
        "Website": website,
        "Response": response,
      };

  MovieDetailsModel copyWith({
    String? title,
    String? year,
    String? rated,
    String? released,
    String? runtime,
    String? genre,
    String? director,
    String? writer,
    String? actors,
    String? plot,
    String? language,
    String? country,
    String? awards,
    String? poster,
    List<RatingModel>? ratings,
    String? metascore,
    String? imdbRating,
    String? imdbVotes,
    String? imdbId,
    String? type,
    String? dvd,
    String? boxOffice,
    String? production,
    String? website,
    String? response,
  }) =>
      MovieDetailsModel(
        title: title ?? this.title,
        year: year ?? this.year,
        rated: rated ?? this.rated,
        released: released ?? this.released,
        runtime: runtime ?? this.runtime,
        genre: genre ?? this.genre,
        director: director ?? this.director,
        writer: writer ?? this.writer,
        actors: actors ?? this.actors,
        plot: plot ?? this.plot,
        language: language ?? this.language,
        country: country ?? this.country,
        awards: awards ?? this.awards,
        poster: poster ?? this.poster,
        ratings: ratings ?? this.ratings,
        imdbRating: imdbRating ?? this.imdbRating,
        imdbVotes: imdbVotes ?? this.imdbVotes,
        imdbId: imdbId ?? this.imdbId,
        type: type ?? this.type,
        dvd: dvd ?? this.dvd,
        boxOffice: boxOffice ?? this.boxOffice,
        production: production ?? this.production,
        website: website ?? this.website,
        response: response ?? this.response,
      );

  static MovieDetailsModel get empty => MovieDetailsModel(
        title: "",
        year: "",
        rated: "",
        released: "",
        runtime: "",
        genre: "",
        director: "",
        writer: "",
        actors: "",
        plot: "",
        language: "",
        country: "",
        awards: "",
        poster: "",
        ratings: [],
        imdbRating: "",
        imdbVotes: "",
        imdbId: "",
        type: "",
        dvd: "",
        boxOffice: "",
        production: "",
        website: "",
        response: "",
      );
}

class RatingModel {
  RatingModel({
    required this.source,
    required this.value,
  });

  final String source;
  final String value;

  factory RatingModel.fromRawJson(String str) =>
      RatingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        source: json["Source"] ?? "",
        value: json["Value"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Source": source,
        "Value": value,
      };
}
