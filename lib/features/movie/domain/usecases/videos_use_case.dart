import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/entities/videos_list.dart';
import 'package:movie_app/features/movie/domain/repositories/videos_list_repository.dart';

class VideosUseCase implements UseCase<VideosList, int> {
  VideosListRepository repository;

  VideosUseCase(this.repository);

  @override
  Future<Either<Failure, VideosList>> call(int params) {
    return repository.fetchVideosList(params);
  }
}