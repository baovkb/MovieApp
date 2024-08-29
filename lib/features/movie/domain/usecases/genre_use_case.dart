import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';

import '../entities/genre.dart';
import '../repositories/genre_repository.dart';

class GenreUseCase implements UseCase<List<Genre>, NoParam> {
  final GenreRepository genreRepository;

  GenreUseCase(this.genreRepository);

  @override
  Future<Either<Failure, List<Genre>>> call(NoParam params) {
    return genreRepository.fetchMovieGenre();
  }
}