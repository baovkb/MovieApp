import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/data/models/movie_list_model.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/usecases/popular_movies_use_case.dart';
import 'package:movie_app/features/movie/presentation/bloc/movie_event.dart';
import 'package:movie_app/features/movie/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<FetchPopularMovieEvent, MovieState> {
  PopularMoviesUseCase popularMoviesUseCase;

  @override
  MovieBloc(this.popularMoviesUseCase) : super(FetchPopularMoviesInitial()) {
    on<FetchPopularMovieEvent>(_onFetchPopularMovie);
  }

  Future<void> _onFetchPopularMovie(FetchPopularMovieEvent event, Emitter<MovieState> emit) async {
    emit(FetchPopularMoviesLoading());
    final Either<Failure, MovieList> result = await popularMoviesUseCase.call(NoParam());

    emit(result.fold(
            (failure) => FetchPopularMoviesError(failure.message),
            (data) => FetchPopularMoviesLoaded(data)));
  }
}