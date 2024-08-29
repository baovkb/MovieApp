import 'dart:async';

import 'package:movie_app/features/movie/domain/usecases/cast_by_movie_id_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/cast/fetch_cast_state.dart';

class FetchCastByMovieIDController {
  StreamController<FetchCastState> streamController = StreamController();
  CastByMovieIDUseCase useCase;

  FetchCastByMovieIDController(this.useCase);

  Stream<FetchCastState> get stream => streamController.stream;

  void fetchCastByMovieID(int movie_id) async {
    streamController.add(FetchCastLoading());

    final result = await useCase.call(movie_id);
    result.fold(
      (failure) => streamController.add(FetchCastError(failure.message)),
      (castList) => streamController.add(FetchCastLoaded(castList)));
  }

  void dispose() {
    streamController.close();
  }
}