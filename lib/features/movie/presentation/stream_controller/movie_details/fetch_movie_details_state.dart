import 'package:movie_app/features/movie/domain/entities/movie_details.dart';

abstract class FetchMovieDetailsState {}

class FetchMovieDetailsInitial extends FetchMovieDetailsState {}

class FetchMovieDetailsLoading extends FetchMovieDetailsState {}

class FetchMovieDetailsLoaded extends FetchMovieDetailsState {
  MovieDetails movieDetails;

  FetchMovieDetailsLoaded(this.movieDetails);
}

class FetchMovieDetailsError extends FetchMovieDetailsState {
  final dynamic message;

  FetchMovieDetailsError(this.message);
}