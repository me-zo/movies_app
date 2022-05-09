


import 'package:movies_app/data/dtos/movie_details_dto.dart';

import '../../dtos/movie_dto.dart';

abstract class MoviesRepository {
  Future<List<MovieDto>> searchMovies({required String keyword});
  Future<MovieDetailsDto> getMovieDetails({required String id});
}
