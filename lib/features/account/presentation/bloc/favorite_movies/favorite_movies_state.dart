import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

abstract class GetFavoriteMoviesState {}

class GetFavoriteMoviesInitial extends GetFavoriteMoviesState {}

class GetFavoriteMoviesLoading extends GetFavoriteMoviesState {}

class GetFavoriteMoviesLoaded extends GetFavoriteMoviesState {
  final MovieList movieList;

  GetFavoriteMoviesLoaded(this.movieList);

}

class GetFavoriteMoviesError extends GetFavoriteMoviesState {
  final dynamic message;

  GetFavoriteMoviesError(this.message);
}

abstract class AddFavoriteMovieState {}

class AddFavoriteMovieInitial extends AddFavoriteMovieState {}

class AddFavoriteMovieLoading extends AddFavoriteMovieState {}

class AddFavoriteMovieLoaded extends AddFavoriteMovieState {
  final bool success;
  AddFavoriteMovieLoaded(this.success);
}

class AddFavoriteMovieError extends AddFavoriteMovieState {
  final dynamic message;

  AddFavoriteMovieError(this.message);
}