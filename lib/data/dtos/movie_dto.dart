import 'dart:convert';

class MovieListDto {
  MovieListDto({
    required this.movies,
  });

  final List<MovieDto> movies;

  factory MovieListDto.fromRawJson(String str) =>
      MovieListDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieListDto.fromJson(Map<String, dynamic> json) => MovieListDto(
        movies: List<MovieDto>.from(
            json["Search"].map((x) => MovieDto.fromJson(x))),
      );

  List<dynamic> toJson() => movies;
}

class MovieDto {
  final String title;
  final String poster;
  final String year;

  MovieDto({required this.title, required this.poster, required this.year});

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      title: json["Title"] ?? "",
      poster: json["Poster"] ?? "",
      year: json["Year"] ?? "",
    );
  }
}
