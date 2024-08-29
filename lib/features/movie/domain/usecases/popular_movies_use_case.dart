import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/repositories/movies_list_repository.dart';

class PopularMoviesUseCase implements UseCase<MovieList, NoParam> {
  final MoviesListRepository repository;

  PopularMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MovieList>> call(NoParam params) {
    return repository.fetchPopularMovies();
  }

}