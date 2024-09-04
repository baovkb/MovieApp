import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/repositories/account_repository.dart';

class AddFavoriteMovieUseCase implements UseCase<bool, ({int movie_id, bool favorite})> {
  AccountRepository repository;

  AddFavoriteMovieUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(({int movie_id, bool favorite}) params) async {
    final record = await repository.getRecord();

    if (record.isLeft()) {
      return Left((record as Left).value);
    } else {
      final int? account_id = (record as Right).value['account_id'];
      final String? session = (record as Right).value['session'];

      if (account_id == null || session == null) return Left(NotFoundFailure());
      else {
        return repository.addFavoriteMovie(account_id, session, params.movie_id, favorite: params.favorite);
      }
    }
  }



}