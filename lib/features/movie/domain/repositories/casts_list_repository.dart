import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/domain/entities/casts_list.dart';

abstract class CastsListRepository {
  Future<Either<Failure, CastsList>> fetchCastByMovieID(int id);
}