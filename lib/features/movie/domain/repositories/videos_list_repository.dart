import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/data/models/videos_list_model.dart';

abstract class VideosListRepository {
  Future<Either<Failure, VideosListModel>> fetchVideosList(int id);
}