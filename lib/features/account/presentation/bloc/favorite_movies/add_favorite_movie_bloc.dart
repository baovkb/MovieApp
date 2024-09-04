import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/account/domain/usecases/add_favorite_movie_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_event.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_state.dart';

class AddFavoriteMovieBloc extends Bloc<AddFavoriteMovieEvent, AddFavoriteMovieState> {
  AddFavoriteMovieUseCase addFavoriteMovieUseCase;

  AddFavoriteMovieBloc(this.addFavoriteMovieUseCase): super(AddFavoriteMovieInitial()) {
    on<AddFavoriteMovieEvent>(_onAddFavoriteMovie);
  }

  Future<void> _onAddFavoriteMovie(AddFavoriteMovieEvent event, Emitter<AddFavoriteMovieState> emitter) async {
    emitter(AddFavoriteMovieLoading());
    final result = await addFavoriteMovieUseCase.call((movie_id: event.movie_id, favorite: event.favorite));
    result.fold(
            (failure) => emitter(AddFavoriteMovieError(failure.message)),
            (success) => emitter(AddFavoriteMovieLoaded(success)));
  }
}