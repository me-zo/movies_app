import 'dart:io';

import 'package:movies_app/core/cache/cache_manager.dart';
import 'package:movies_app/core/network/http_config.dart';
import 'package:movies_app/models/movie_details_model.dart';
import 'package:movies_app/models/movie_model.dart';

import '../../../core/dependency_registrar/dependencies.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/errors/errors.dart';
import '../../../core/network/http_client.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class MoviesDataSource {
  final HttpClient _client = HttpClient(config: HttpConfig());
  final CacheManager<MovieListModel> _movieListCache = getIt();
  final CacheManager<MovieDetailsModel> _movieDetailsCache = getIt();

  Future<List<MovieModel>> searchMovies({required String keyword}) async {
    if (!_movieListCache.contains(keyword)) {
      var path = "&s=$keyword";
      var result = await _client.get(url: path);
      if (result.statusCode != HttpStatus.ok) {
        throw ErrorHandler.httpResponseException(result);
      } else {
        //the api returns 200 with a false response if there is an error
        if (MovieListModel.fromRawJson(result.body).response != "True") {
          throw NotFoundException(
              message: MovieListModel.fromRawJson(result.body).error);
        }
        _movieListCache.set(keyword, MovieListModel.fromRawJson(result.body));
        return MovieListModel.fromRawJson(result.body).movies;
      }
    } else {
      return (_movieListCache.get(keyword) ?? MovieListModel.empty()).movies;
    }
  }

  Future<MovieDetailsModel> getMovieDetails({required String id}) async {
    if (!_movieDetailsCache.contains(id)) {
      var path = "&i=$id";
      var result = await _client.get(url: path);
      if (result.statusCode != HttpStatus.ok) {
        throw ErrorHandler.httpResponseException(result);
      } else {
        _movieDetailsCache.set(id, MovieDetailsModel.fromRawJson(result.body));
        return MovieDetailsModel.fromRawJson(result.body);
      }
    } else {
      return (_movieDetailsCache.get(id) ?? MovieDetailsModel.empty);
    }
  }
}
