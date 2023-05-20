import 'dart:convert';

class MovieListModel {
  MovieListModel({
    required this.movies,
    required this.response,
    required this.error,
  });

  final List<MovieModel> movies;
  final String response;
  final String error;

  factory MovieListModel.fromRawJson(String str) =>
      MovieListModel.fromJson(json.decode(str));

  factory MovieListModel.empty() =>
      MovieListModel(error: "", movies: [], response: "");

  String toRawJson() => json.encode(toJson());

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        response: json["Response"] ?? "",
        error: json["Error"] ?? "",
        movies: List<MovieModel>.from(
            (json["Search"] ?? []).map((x) => MovieModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    return {
      "movies": movies,
      "response": response,
      "error": error,
    };
  }
}

class MovieModel {
  final String title;
  final String poster;
  final String year;
  final String imdbID;

  MovieModel(
      {required this.title,
      required this.poster,
      required this.year,
      required this.imdbID});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json["Title"] ?? "",
      poster: json["Poster"] ?? "",
      year: json["Year"] ?? "",
      imdbID: json["imdbID"] ?? "",
    );
  }
}
