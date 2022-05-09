import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/home/domain/models/movie_details_model.dart';

import '../../../../core/dependency_registrar/dependencies.dart';
import '../../../../presentation/home/domain/service/home_service.dart';
import '../../domain/models/movie_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService _homeService = sl.get<HomeService>();

  HomeCubit() : super(HomeInitial());
  List<MovieModel> movies = [];
  MovieDetailsModel movieDetails = MovieDetailsModel.empty();

  void searchMovies({required String value}) async {
    emit(Loading());
    var result = await _homeService.searchMovies(value);
    result.fold(
      (l) => emit(Error(message: l.message)),
      (r) {
        movies = r;
        emit(ShowMovieList(info: r));
      },
    );
  }

  void getMovieDetails({required String id}) async {
    emit(Loading());
    if (movieDetails.imdbId != id) {
      var result = await _homeService.movieDetails(id);
      result.fold(
        (l) => emit(Error(message: l.message)),
        (r) {
          movieDetails = r;
          emit(ShowMovieDetails(movie: r));
        },
      );
    } else {
      emit(ShowMovieDetails(movie: movieDetails));
    }

    emit(ShowMovieList(info: movies));
  }
}
