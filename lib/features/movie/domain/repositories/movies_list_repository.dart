import 'package:dartz/dartz.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

import '../../../../core/error/failure.dart';

abstract class MoviesListRepository {
  Future<Either<Failure, MovieList>> fetchPopularMovies();

  Future<Either<Failure, MovieList>> fetchMoviesByGenre(int genre_id);

  Future<Either<Failure, MovieList>> fetchSimilarMovies(int movie_id);

  Future<Either<Failure, MovieList>> searchMovies(String query);
}