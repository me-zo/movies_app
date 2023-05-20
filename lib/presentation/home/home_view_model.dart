import 'dart:core';
import 'package:movies_app/models/failure_model.dart';
import 'package:movies_app/models/movie_details_model.dart';
import 'package:movies_app/presentation/home/home_repo.dart';
import '../../models/movie_model.dart';
import '../base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final HomeRepo _homeRepo = HomeRepo();
  String searchedKeyWord = "";
  List<bool> isProfileLoaded = [];
  List<MovieModel> movies = [];
  FailureModel failure = FailureModel.empty;
  MovieDetailsModel movieDetails = MovieDetailsModel.empty;

  void searchMovies({required String keyword}) async {
    if (keyword.isNotEmpty) searchedKeyWord = keyword;
    setBusy();
    var result = await _homeRepo.searchMovies(searchedKeyWord);
    result.fold(
      (l) => failure = FailureModel.get(l),
      (r) {
        movies = r;
        isProfileLoaded = List.generate(r.length, (index) => true);
      },
    );
    setIdle();
  }

  Future<void> getMovieDetails({required String id}) async {
    setBusy();
    var result = await _homeRepo.movieDetails(id);
    result.fold(
      (l) => failure = FailureModel.get(l),
      (r) {
        movieDetails = r;
      },
    );
    setIdle();
  }
}
