import 'package:get_it/get_it.dart';

import '../../data/repositories/movies/movies_repository.dart';
import '../../data/repositories/movies/movies_repository_impl.dart';

void repositoryDependencies(GetIt locator) {
  locator.registerFactory<MoviesRepository>(() => MoviesRepositoryImpl());

}
