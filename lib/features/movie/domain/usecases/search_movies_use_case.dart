import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/repositories/movies_list_repository.dart';

class SearchMoviesUseCase implements UseCase<MovieList, String> {
  MoviesListRepository repository;

  SearchMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MovieList>> call(String query) async {
    return repository.searchMovies(query);
  }

}