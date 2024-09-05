import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/data/models/movie_list_model.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

import '../../domain/repositories/movies_list_repository.dart';

class MoviesListRepositoryImpl implements MoviesListRepository {
  final MovieApiClient client;

  MoviesListRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, MovieListModel>> fetchPopularMovies() async {
    try {
      final result = await client.fetchPopularMovies();
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : const Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, MovieListModel>> fetchMoviesByGenre(int genre_id) async {
    try {
      final result = await client.fetchMoviesByGenre(genre_id);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : const Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, MovieListModel>> fetchSimilarMovies(int movie_id) async {
    try {
      final result = await client.fetchSimilarMovies(movie_id);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : const Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, MovieListModel>> searchMovies(String query) async {
    try {
      final result = await client.searchMovies(query);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }
}