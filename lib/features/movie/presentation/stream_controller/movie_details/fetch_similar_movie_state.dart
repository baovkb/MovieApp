import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

abstract class SimilarMovieState {}

class SimilarMovieInitial extends SimilarMovieState {}

class SimilarMovieLoading extends SimilarMovieState {}

class SimilarMovieLoaded extends SimilarMovieState {
  final MovieList movieList;

  SimilarMovieLoaded(this.movieList);
}

class SimilarMovieError extends SimilarMovieState {
  final dynamic message;

  SimilarMovieError(this.message);
}