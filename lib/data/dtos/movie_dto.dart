import 'dart:convert';

class MovieListDto {
  MovieListDto({
    required this.movies,
  });

  final List<MovieDto> movies;

  factory MovieListDto.fromRawJson(String str) =>
      MovieListDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieListDto.fromJson(List<dynamic> json) => MovieListDto(
        movies: List<MovieDto>.from(json.map((x) => MovieDto.fromJson(x))),
      );

  List<dynamic> toJson() => movies;
}

class MovieDto {
  final String title;
  final String poster;

  MovieDto({required this.title, required this.poster});

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(title: json["Title"], poster: json["Poster"]);
  }
}
