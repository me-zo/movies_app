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
    required this.metaScore,
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
  final String metaScore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbId;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;
  final String response;

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
        metaScore: metascore ?? this.metaScore,
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
  factory MovieDetailsModel.empty() =>
      MovieDetailsModel(
        title:"",
        year:"",
        rated:"",
        released:"",
        runtime:"",
        genre:"",
        director:"",
        writer:"",
        actors:"",
        plot:"",
        language:"",
        country:"",
        awards:"",
        poster:"",
        ratings:[],
        metaScore:"",
        imdbRating:"",
        imdbVotes:"",
        imdbId:"",
        type:"",
        dvd:"",
        boxOffice:"",
        production:"",
        website:"",
        response:"",
      );
}

class RatingModel {
  RatingModel({
    required this.source,
    required this.value,
  });

  final String source;
  final String value;

  RatingModel copyWith({
    String? source,
    String? value,
  }) =>
      RatingModel(
        source: source ?? this.source,
        value: value ?? this.value,
      );
}