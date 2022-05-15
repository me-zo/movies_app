import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/core/dependency_registrar/cache_dep.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/dependency_registrar/feature_dependencies/actions_dep.dart';
import '../../core/dependency_registrar/feature_dependencies/home_dep.dart';
import '../../data/shared_preferences/settings_notifier.dart';
import '../network/http_client.dart';
import 'repository_dep.dart';

final sl = GetIt.instance;

class Dependencies {
  static Future<void> init() async {
    //#region Common Dependencies

    sl.registerLazySingleton<Connectivity>(() => Connectivity());

    var sharedPreferences = await SharedPreferences.getInstance();

    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton<SettingsNotifier>(() => SettingsNotifier());

    sl.registerFactory<HttpClient>(() => HttpClient());

    //#endregion
    cacheDependencies(sl);
    repositoryDependencies(sl);
    homeDependencies(sl);
    actionDependencies(sl);
  }
}
