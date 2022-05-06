import 'package:bloc/bloc.dart';
import '../../../../core/dependency_registrar/dependencies.dart';
import '../../../../presentation/home/domain/service/home_service.dart';
import 'package:flutter/material.dart';

import '../../domain/models/movie_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService _homeService = sl.get<HomeService>();

  HomeCubit() : super(HomeInitial());

  void searchMovies({required String value}) async {
    emit(Loading());
    var result = await _homeService.searchMovies(value);
    result.fold(
      (l) => emit(Error(message: l.message)),
      (r) => emit(ShowMovieList(info: r)),
    );
  }
}

