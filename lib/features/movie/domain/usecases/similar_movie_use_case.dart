import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/repositories/movies_list_repository.dart';

class SimilarMovieUseCase implements UseCase<MovieList, int> {
  final MoviesListRepository repository;

  SimilarMovieUseCase(this.repository);

  @override
  Future<Either<Failure, MovieList>> call(int params) {
    return repository.fetchSimilarMovies(params);
  }

}