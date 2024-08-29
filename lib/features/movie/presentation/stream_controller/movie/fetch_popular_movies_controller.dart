import 'dart:async';

import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/usecases/popular_movies_use_case.dart';
import 'package:http/http.dart' show Client;
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_popular_movies_state.dart';

class FetchPopularMoviesController {
  final StreamController<FetchPopularMoviesState> _popularMoviesController = StreamController();

  final PopularMoviesUseCase _popularMoviesUseCase;

  Stream<FetchPopularMoviesState> get stream => _popularMoviesController.stream;

  FetchPopularMoviesController(this._popularMoviesUseCase);

  void fetchPopularMovies() async {
    _popularMoviesController.add(FetchPopularMoviesLoading());
    final result = await _popularMoviesUseCase.call(NoParam());

    result.fold((failure) {
      _popularMoviesController.add(FetchPopularMoviesError(failure.message));
    }, (moviesPopular) {
      _popularMoviesController.add(FetchPopularMoviesLoaded(moviesPopular));
    });
  }

  void dispose() {
    _popularMoviesController.close();
  }
}