import 'package:dartz/dartz.dart';
import 'package:movies_app/core/extensions/list.dart';
import 'package:movies_app/presentation/home/domain/models/movie_details_model.dart';

import '../../../../core/exports.dart';
import '../../../../data/repositories/movies/movies_repository.dart';
import '../models/movie_model.dart';
import 'home_service.dart';

class HomeServiceImpl implements HomeService {
  final MoviesRepository _moviesRepository = sl();

  @override
  Future<Either<Failure, List<MovieModel>>> searchMovies(String value) =>
      ErrorHandler.handleFuture<List<MovieModel>>(
        () async {
          var movies = await _moviesRepository.searchMovies(keyword: value);
          return Right(
            movies
                .map(
                  (e) => MovieModel(
                    movieTitle: e.title,
                    moviePoster: e.poster,
                    year: e.year,
                    imdbID: e.imdbID,
                  ),
                )
                .toList(),
          );
        },
      );

  @override
  Future<Either<Failure, MovieDetailsModel>> movieDetails(String id) =>
      ErrorHandler.handleFuture<MovieDetailsModel>(
        () async {
          var movie = await _moviesRepository.getMovieDetails(id: id);
          return Right(MovieDetailsModel(
            title: movie.title,
            year: movie.year,
            rated: movie.rated,
            released: movie.released,
            runtime: movie.runtime,
            genre: movie.genre,
            director: movie.director,
            writer: movie.writer,
            actors: movie.actors,
            plot: movie.plot,
            language: movie.language,
            country: movie.country,
            awards: movie.awards,
            poster: movie.poster,
            ratings: movie.ratings.mapList(
              (e) => RatingModel(
                source: e.source,
                value: e.value,
              ),
            ),
            metaScore: movie.metascore,
            imdbRating: movie.imdbRating,
            imdbVotes: movie.imdbVotes,
            imdbId: movie.imdbId,
            type: movie.type,
            dvd: movie.dvd,
            boxOffice: movie.boxOffice,
            production: movie.production,
            website: movie.website,
            response: movie.response,
          ));
        },
      );
}
