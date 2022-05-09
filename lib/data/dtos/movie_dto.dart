import 'dart:convert';

class MovieListDto {
  MovieListDto({
    required this.movies,
    required this.response,
    required this.error,
  });

  final List<MovieDto> movies;
  final String response;
  final String error;

  factory MovieListDto.fromRawJson(String str) =>
      MovieListDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieListDto.fromJson(Map<String, dynamic> json) => MovieListDto(
        response: json["Response"] ?? "",
        error: json["Error"] ?? "",
        movies: List<MovieDto>.from(
            (json["Search"] ?? []).map((x) => MovieDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    return {
      "movies": movies,
      "response": response,
      "error": error,
    };
  }
}

class MovieDto {
  final String title;
  final String poster;
  final String year;
  final String imdbID;

  MovieDto(
      {required this.title,
      required this.poster,
      required this.year,
      required this.imdbID});

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      title: json["Title"] ?? "",
      poster: json["Poster"] ?? "",
      year: json["Year"] ?? "",
      imdbID: json["imdbID"] ?? "",
    );
  }
}
