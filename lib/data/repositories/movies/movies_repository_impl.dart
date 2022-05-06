import 'dart:convert';
import 'dart:io';


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
    var path = "?s=$keyword";
    var result = await _client.getData(url: path);
    if (result.statusCode != HttpStatus.ok) {
      throw ErrorHandler.httpResponseException(result);
    } else {
      var decodedObject = json.decode(result.body);
      return MovieListDto.fromJson(decodedObject).movies;
    }
  }
}
