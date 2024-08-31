import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/data/models/videos_list_model.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/repositories/videos_list_repository.dart';

class VideosListRepositoryImpl extends VideosListRepository {
  MovieApiClient client;

  VideosListRepositoryImpl(this.client);

  @override
  Future<Either<Failure, VideosListModel>> fetchVideosList(int id) async {
    try {
      final result = await client.fetchVideosList(id);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }

}