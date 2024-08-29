import 'dart:async';

import 'package:movie_app/features/movie/domain/usecases/movie_details_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie_details/fetch_movie_details_state.dart';

class FetchMovieDetailsController {
  StreamController<FetchMovieDetailsState> movieDetailsController = StreamController();
  MovieDetailsUseCase movieDetailsUseCase;

  FetchMovieDetailsController(this.movieDetailsUseCase);

  Stream<FetchMovieDetailsState> get stream => movieDetailsController.stream;

  void fetchMovieDetails(int id) async {
    movieDetailsController.add(FetchMovieDetailsLoading());

    final result = await movieDetailsUseCase.call(id);
    result.fold(
        (failure) => movieDetailsController.add(FetchMovieDetailsError(failure.message)),
        (movieDetails) => movieDetailsController.add(FetchMovieDetailsLoaded(movieDetails)));
  }

  void dispose() {
    movieDetailsController.close();
  }
}