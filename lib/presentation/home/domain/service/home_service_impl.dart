import 'package:dartz/dartz.dart';

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
                  ),
                )
                .toList(),
          );
        },
      );
}
