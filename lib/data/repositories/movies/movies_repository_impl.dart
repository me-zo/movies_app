import 'dart:io';

import 'package:movies_app/core/cache/cache_manager.dart';
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
  final CacheManager<MovieListDto> _movieListCache = sl();
  final CacheManager<MovieDetailsDto> _movieDetailsCache = sl();

  @override
  Future<List<MovieDto>> searchMovies({required String keyword}) async {
    if (!_movieListCache.contains(keyword)) {
      var path = "&s=$keyword";
      var result = await _client.getData(url: path);
      if (result.statusCode != HttpStatus.ok) {
        throw ErrorHandler.httpResponseException(result);
      } else {
        //the api returns 200 with a false response if there is an error
        if (MovieListDto.fromRawJson(result.body).response != "True") {
          throw NotFoundException(
              message: MovieListDto.fromRawJson(result.body).error);
        }
        _movieListCache.set(keyword, MovieListDto.fromRawJson(result.body));
        return MovieListDto.fromRawJson(result.body).movies;
      }
    } else {
      return (_movieListCache.get(keyword) ?? MovieListDto.empty()).movies;
    }
  }

  @override
  Future<MovieDetailsDto> getMovieDetails({required String id}) async {
    if (!_movieDetailsCache.contains(id)) {
      var path = "&i=$id";
      var result = await _client.getData(url: path);
      if (result.statusCode != HttpStatus.ok) {
        throw ErrorHandler.httpResponseException(result);
      } else {
        _movieDetailsCache.set(id, MovieDetailsDto.fromRawJson(result.body));
        return MovieDetailsDto.fromRawJson(result.body);
      }
    } else {
      return (_movieDetailsCache.get(id) ?? MovieDetailsDto.empty());
    }
  }
}
