import 'dart:async';

import 'package:movie_app/features/movie/domain/usecases/similar_movie_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie_details/fetch_similar_movie_state.dart';

class FetchSimilarMoviesController {
  StreamController<SimilarMovieState> _streamController = StreamController();
  SimilarMovieUseCase useCase;

  FetchSimilarMoviesController(this.useCase);

  Stream<SimilarMovieState> get stream => _streamController.stream;

  void fetchSimilarMovies(int movie_id) async {
    _streamController.add(SimilarMovieLoading());
    final result = await useCase.call(movie_id);
    result.fold(
            (failure) => _streamController.add(SimilarMovieError(failure.message)),
            (movieList) => _streamController.add(SimilarMovieLoaded(movieList))
    );
  }

  void dispose() {
    _streamController.close();
  }
}