import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/app/configuration.dart';
import 'package:movies_app/models/movie_details_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:movies_app/core/cache/cache_manager.dart';

import '../../presentation/settings_view_model.dart';

final getIt = GetIt.instance;

Future<void> initDependencies(Build build) async {
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  var sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getIt.registerLazySingleton<SettingsNotifier>(() => SettingsNotifier());

  cacheDependencies(getIt);

  switch (build) {
    case Build.DEVELOP:
      getIt.registerSingleton<Configuration>(
        Configuration(
          domain: "www.omdbapi.com",
          variant: build,
          defaultErrorMessage: "core.fixtures.unknownError",
        ),
      );
      break;
    case Build.RELEASE:
      getIt.registerSingleton<Configuration>(
        Configuration(
          domain: "www.omdbapi.com",
          variant: build,
          defaultErrorMessage: "core.fixtures.unknownError",
        ),
      );
      break;
  }
}

void cacheDependencies(GetIt locator) {
  locator.registerLazySingleton<CacheManager<MovieDetailsModel>>(
      () => CacheManager<MovieDetailsModel>());
  locator.registerLazySingleton<CacheManager<MovieListModel>>(
      () => CacheManager<MovieListModel>());
}
