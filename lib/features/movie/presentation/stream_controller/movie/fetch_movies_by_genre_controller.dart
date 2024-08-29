import 'dart:async';

import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/usecases/movies_by_genre_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_movies_by_genre_state.dart';

class FetchMoviesByGenreController {
  final StreamController<FetchMoviesByGenreState> _moviesByGenreController = StreamController();
  final MoviesByGenreUseCase _moviesByGenreUseCase;

  FetchMoviesByGenreController(this._moviesByGenreUseCase);

  Stream<FetchMoviesByGenreState> get stream => _moviesByGenreController.stream;

  void fetchMoviesByGenre(int genre_id) async {
    _moviesByGenreController.add(FetchMoviesByGenreLoading());

    final result = await _moviesByGenreUseCase.call(genre_id);
    result.fold(
        (failure) => _moviesByGenreController.add(FetchMoviesByGenreError(failure.message)),
        (moviesList) => _moviesByGenreController.add(FetchMoviesByGenreLoaded(moviesList)));
  }

  void dispose() {
    _moviesByGenreController.close();
  }
}