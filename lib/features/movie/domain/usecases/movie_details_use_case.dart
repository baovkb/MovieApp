import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/entities/movie_details.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_details_repository.dart';

class MovieDetailsUseCase extends UseCase<MovieDetails, int>{
  MovieDetailRepository movieDetailRepository;

  MovieDetailsUseCase(this.movieDetailRepository);

  @override
  Future<Either<Failure, MovieDetails>> call(int params) {
    return movieDetailRepository.fetchMovieDetails(params);
  }
}