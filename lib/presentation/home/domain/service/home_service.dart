import 'package:dartz/dartz.dart';
import 'package:movies_app/presentation/home/domain/models/movie_details_model.dart';

import '../../../../core/exports.dart';
import '../models/movie_model.dart';

abstract class HomeService {
  Future<Either<Failure, List<MovieModel>>> searchMovies(String value);
  Future<Either<Failure, MovieDetailsModel>> movieDetails(String id);
}
