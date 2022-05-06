import 'package:dartz/dartz.dart';

import '../../../../core/exports.dart';
import '../models/movie_model.dart';

abstract class HomeService {
  Future<Either<Failure, List<MovieModel>>> searchMovies(String value);
}
