import 'package:dartz/dartz.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/repositories/movies_list_repository.dart';

import '../../../../core/error/failure.dart';

class MoviesByGenreUseCase implements UseCase<MovieList, int> {
  final MoviesListRepository moviesListRepository;

  MoviesByGenreUseCase(this.moviesListRepository);

  @override
  Future<Either<Failure, MovieList>> call (int genre_id) {
    return moviesListRepository.fetchMoviesByGenre(genre_id);
  }
}