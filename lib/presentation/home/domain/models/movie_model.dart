class MovieModel {
  final String movieTitle;
  final String moviePoster;
  final String year;
  final String imdbID;

  MovieModel({
    required this.movieTitle,
    required this.moviePoster,
    required this.year,
    required this.imdbID,
  });

  factory MovieModel.empty() => MovieModel(
        movieTitle: "",
        moviePoster: "",
        year: "",
        imdbID: "",
      );
}
