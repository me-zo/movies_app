part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class Error extends HomeState {
  Error({required this.message});

  final String message;
}

class Loading extends HomeState {}

class ShowMovieList extends HomeState {
  final List<MovieModel> info;

  ShowMovieList({required this.info});
}
class ShowMovieDetails extends HomeState {
  final MovieDetailsModel movie;

  ShowMovieDetails({required this.movie});
}

