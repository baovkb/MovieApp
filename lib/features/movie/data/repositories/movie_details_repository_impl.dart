import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/data/models/movie_details_model.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailRepository {
  final MovieApiClient client;

  MovieDetailsRepositoryImpl(this.client);

  @override
  Future<Either<Failure, MovieDetailsModel>> fetchMovieDetails(int id) async {
    try {
      final result = await client.fetchMovieDetails(id);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }
}