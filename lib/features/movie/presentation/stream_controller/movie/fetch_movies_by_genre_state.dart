import '../../../domain/entities/movie_list.dart';

abstract class FetchMoviesByGenreState {}

class FetchMoviesByGenreInitial extends FetchMoviesByGenreState {}

class FetchMoviesByGenreLoading extends FetchMoviesByGenreState {}

class FetchMoviesByGenreLoaded extends FetchMoviesByGenreState {
  final MovieList movieList;

  FetchMoviesByGenreLoaded(this.movieList);
}

class FetchMoviesByGenreError extends FetchMoviesByGenreState {
  final dynamic message;

  FetchMoviesByGenreError(this.message);
}