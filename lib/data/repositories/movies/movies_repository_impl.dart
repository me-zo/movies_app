import 'dart:developer';
import 'dart:io';

import 'package:movies_app/data/dtos/movie_details_dto.dart';

import '../../../core/exports.dart';
import '../../../core/network/http_client.dart';
import '../../dtos/movie_dto.dart';
import 'movies_repository.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class MoviesRepositoryImpl implements MoviesRepository {
  final HttpClient _client = sl();

  @override
  Future<List<MovieDto>> searchMovies({required String keyword}) async {
    var path = "&s=$keyword";
    var result = await _client.getData(url: path);
    if (result.statusCode != HttpStatus.ok) {
      throw ErrorHandler.httpResponseException(result);
    } else {
      log(result.body);
      if (MovieListDto.fromRawJson(result.body).response != "True") {
        throw NotFoundException(
            message: MovieListDto.fromRawJson(result.body).error);
      }
      return MovieListDto.fromRawJson(result.body).movies;
    }
  }

  @override
  Future<MovieDetailsDto> getMovieDetails({required String id}) async {
    var path = "&i=$id";
    var result = await _client.getData(url: path);
    if (result.statusCode != HttpStatus.ok) {
      throw ErrorHandler.httpResponseException(result);
    } else {
      log(result.body);
      return MovieDetailsDto.fromRawJson(result.body);
    }
  }
}
