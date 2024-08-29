import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

abstract class MovieState extends Equatable {
  @override List<Object> get props => [];
}

class FetchPopularMoviesInitial extends MovieState {}

class FetchPopularMoviesLoading extends MovieState {}

class FetchPopularMoviesLoaded extends MovieState {
  final MovieList movieList;

  FetchPopularMoviesLoaded(this.movieList);

  @override List<Object> get props => [movieList];

}

class FetchPopularMoviesError extends MovieState {
  final dynamic error;

  FetchPopularMoviesError(this.error);

  @override List<Object> get props => [error];
}