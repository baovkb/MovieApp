import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/usecases/add_favorite_movie_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/get_favorite_movies_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_event.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_state.dart';

class GetFavoriteMoviesBloc extends Bloc<GetFavoriteMoviesEvent, GetFavoriteMoviesState> {
  GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;

  GetFavoriteMoviesBloc(this.getFavoriteMoviesUseCase):
        super(GetFavoriteMoviesInitial()) {
    on<GetFavoriteMoviesEvent>(_onGetFavoriteMovies);
  }

  Future<void> _onGetFavoriteMovies(GetFavoriteMoviesEvent event, Emitter<GetFavoriteMoviesState> emitter) async {
    emitter(GetFavoriteMoviesLoading());
    final result = await getFavoriteMoviesUseCase.call(NoParam());
    result.fold(
        (failure) => emitter(GetFavoriteMoviesError(failure.message)),
        (movieList) => emitter(GetFavoriteMoviesLoaded(movieList)));
  }

}