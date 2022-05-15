import 'package:get_it/get_it.dart';
import 'package:movies_app/core/cache/cache_manager.dart';
import 'package:movies_app/data/dtos/movie_details_dto.dart';
import 'package:movies_app/data/dtos/movie_dto.dart';

void cacheDependencies(GetIt locator) {
  locator.registerLazySingleton<CacheManager<MovieDetailsDto>>(
      () => CacheManager<MovieDetailsDto>());
  locator.registerLazySingleton<CacheManager<MovieListDto>>(
      () => CacheManager<MovieListDto>());
}
