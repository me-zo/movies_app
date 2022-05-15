import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/dependency_registrar/dependencies.dart';
import 'package:movies_app/presentation/home/domain/models/movie_details_model.dart';
import 'package:movies_app/presentation/home/domain/models/movie_model.dart';
import 'package:movies_app/presentation/home/domain/service/home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService _homeService = sl.get<HomeService>();
  String searchedKeyWord = "";
  List<bool> isProfileLoaded = [];

  HomeBloc() : super(HomeInitial()) {
    on<SearchMoviesEvent>(
      (event, emit) => _searchMovies(emit, value: event.keyword),
    );
    on<MovieDetailsEvent>(
      (event, emit) => _getMovieDetails(emit, id: event.id),
    );
  }

  void _searchMovies(Emitter emit, {required String value}) async {
    if (value.isNotEmpty) searchedKeyWord = value;
    emit(Loading());
    var result = await _homeService.searchMovies(searchedKeyWord);
    result.fold(
      (l) => emit(Error(message: l.message)),
      (r) {
        isProfileLoaded = List.generate(r.length, (index) => true);
        emit(ShowMovieList(info: r));
      },
    );
  }

  void _getMovieDetails(Emitter emit, {required String id}) async {
    emit(Loading());
    var result = await _homeService.movieDetails(id);
    result.fold(
      (l) => emit(Error(message: l.message)),
      (r) {
        emit(ShowMovieDetails(movie: r));
      },
    );
  }
}
