import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/repositories/account_repository.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

class GetFavoriteMoviesUseCase implements UseCase<MovieList, NoParam> {
  AccountRepository repository;

  GetFavoriteMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MovieList>> call(NoParam params) async {
    final record = await repository.getRecord();

    if (record.isLeft()) {
      return Left((record as Left).value);
    } else {
      final int? account_id = (record as Right).value['account_id'];
      final String? session = (record as Right).value['session'];

      if (account_id == null || session == null) return Left(NotFoundFailure());
      else {
        return repository.getFavoriteMovies(account_id, session);
      }
    }
  }

}