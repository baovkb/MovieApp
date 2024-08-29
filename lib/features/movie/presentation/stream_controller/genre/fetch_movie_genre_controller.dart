import 'dart:async';

import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/usecases/genre_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_state.dart';

class FetchMovieGenreController {
  final StreamController<FetchMovieGenreState> _movieGenreController = StreamController();
  final GenreUseCase _genreUseCase;

  Stream<FetchMovieGenreState> get stream => _movieGenreController.stream;

  FetchMovieGenreController(this._genreUseCase);

  void fetchMovieGenres() async {
    _movieGenreController.add(FetchMovieGenreInitial());
    final result = await _genreUseCase.call(NoParam());
    _movieGenreController.add(result.fold(
            (failure) => FetchMovieGenreError(failure.message),
            (genreList) => FetchMovieGenreLoaded(genreList)));
  }

  void dispose() {
    _movieGenreController.close();
  }
}