import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/domain/entities/movie_details.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, MovieDetails>> fetchMovieDetails(int id);
}