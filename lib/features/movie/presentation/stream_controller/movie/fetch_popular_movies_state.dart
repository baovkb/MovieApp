import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

abstract class FetchPopularMoviesState {}

class FetchPopularMoviesInitial extends FetchPopularMoviesState {}

class FetchPopularMoviesLoading extends FetchPopularMoviesState {}

class FetchPopularMoviesLoaded extends FetchPopularMoviesState {
  MovieList movieList;

  FetchPopularMoviesLoaded(this.movieList);
}

class FetchPopularMoviesError extends FetchPopularMoviesState {
  final dynamic message;

  FetchPopularMoviesError(this.message);
}

