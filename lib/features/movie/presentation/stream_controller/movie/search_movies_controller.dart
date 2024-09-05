import 'dart:async';

import 'package:movie_app/features/movie/domain/usecases/search_movies_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/search_movies_state.dart';

class SearchMoviesController {
  SearchMoviesUseCase useCase;
  StreamController<SearchMoviesState> _controller = StreamController();

  SearchMoviesController(this.useCase);

  Stream<SearchMoviesState> get stream => _controller.stream;

  void call(String query) async {
    _controller.add(SearchMoviesLoading());
    final result = await useCase.call(query);
    result.fold(
            (failure) => _controller.add(SearchMoviesError(failure.message)),
            (movies) => _controller.add(SearchMoviesLoaded(movies)));
  }

  void dispose() {
    _controller.close();
  }
}