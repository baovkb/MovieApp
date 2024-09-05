import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final MovieList movieList;

  SearchMoviesLoaded(this.movieList);
}

class SearchMoviesError extends SearchMoviesState {
  final dynamic message;

  SearchMoviesError(this.message);
}