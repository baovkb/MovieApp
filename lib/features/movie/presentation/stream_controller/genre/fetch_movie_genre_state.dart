import 'package:movie_app/features/movie/domain/entities/genre.dart';

abstract class FetchMovieGenreState{}

class FetchMovieGenreInitial extends FetchMovieGenreState {}

class FetchMovieGenreLoading extends FetchMovieGenreState{}

class FetchMovieGenreLoaded extends FetchMovieGenreState {
  final List<Genre> genreList;

  FetchMovieGenreLoaded(this.genreList);
}

class FetchMovieGenreError extends FetchMovieGenreState {
  final dynamic message;

  FetchMovieGenreError(this.message);
}