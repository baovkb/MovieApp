import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movie/domain/entities/casts_list.dart';
import 'package:movie_app/features/movie/domain/repositories/casts_list_repository.dart';

class CastByMovieIDUseCase implements UseCase<CastsList, int>{
  CastsListRepository castsListRepository;

  CastByMovieIDUseCase(this.castsListRepository);

  @override
  Future<Either<Failure, CastsList>> call(int params) {
    return castsListRepository.fetchCastByMovieID(params);
  }

}