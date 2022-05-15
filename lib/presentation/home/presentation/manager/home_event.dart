part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SearchMoviesEvent extends HomeEvent {
  final String keyword;

  SearchMoviesEvent({this.keyword = ""});
}

class MovieDetailsEvent extends HomeEvent {
  final String id;

  MovieDetailsEvent({required this.id});
}
