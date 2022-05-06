


import '../../dtos/movie_dto.dart';

abstract class MoviesRepository {
  Future<List<MovieDto>> searchMovies({required String keyword});
}
