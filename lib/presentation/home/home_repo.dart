import 'package:dartz/dartz.dart';

import '../../../core/errors/error_handler.dart';
import '../../../core/errors/errors.dart';
import '../../data/data_sources/movies_data_source.dart';
import '../../models/movie_details_model.dart';
import '../../models/movie_model.dart';

class HomeRepo {
  final MoviesDataSource _moviesDataSource = MoviesDataSource();

  Future<Either<Failure, List<MovieModel>>> searchMovies(String value) =>
      ErrorHandler.handleFuture<List<MovieModel>>(
        () async {
          var movies = await _moviesDataSource.searchMovies(keyword: value);
          return Right(movies);
        },
      );

  Future<Either<Failure, MovieDetailsModel>> movieDetails(String id) =>
      ErrorHandler.handleFuture<MovieDetailsModel>(
        () async {
          var movie = await _moviesDataSource.getMovieDetails(id: id);
          return Right(movie);
        },
      );
}
