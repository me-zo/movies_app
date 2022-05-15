import 'package:get_it/get_it.dart';
import 'package:movies_app/presentation/home/presentation/manager/home_bloc.dart';

import '../../../../presentation/home/domain/service/home_service.dart';
import '../../../../presentation/home/domain/service/home_service_impl.dart';

void homeDependencies(GetIt locator) {
  locator.registerFactory<HomeService>(() => HomeServiceImpl());

  locator.registerSingleton<HomeBloc>(HomeBloc());
}
