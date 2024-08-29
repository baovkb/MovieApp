import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/entities/casts_list.dart';
import 'package:movie_app/features/movie/domain/repositories/casts_list_repository.dart';

class CastListRepositoryImpl extends CastsListRepository {
  MovieApiClient client;

  CastListRepositoryImpl(this.client);

  @override
  Future<Either<Failure, CastsList>> fetchCastByMovieID(int id) async {
    try {
      final result = await client.fetchCastByMovieID(id);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : const Left(UnknownError());
    }
  }

}