import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/domain/entities/genre.dart';

abstract class GenreRepository {
  Future<Either<Failure, List<Genre>>> fetchMovieGenre();
}