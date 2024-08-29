import 'package:dartz/dartz.dart';

import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/data/models/genre_model.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';

import 'package:movie_app/features/movie/domain/entities/genre.dart';

import '../../domain/repositories/genre_repository.dart';

class GenreRepositoryImpl extends GenreRepository {
  final MovieApiClient _client;

  GenreRepositoryImpl(this._client);

  @override
  Future<Either<Failure, List<GenreModel>>> fetchMovieGenre() async {
    try {
      final result = await _client.fetchMovieGenres();
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : const Left(UnknownError());
    }
  }

}