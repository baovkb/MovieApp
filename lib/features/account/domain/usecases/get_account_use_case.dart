import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/entities/account.dart';
import 'package:movie_app/features/account/domain/repositories/account_repository.dart';

class GetAccountUseCase implements UseCase<Account, NoParam> {
  AccountRepository repository;

  GetAccountUseCase(this.repository);

  @override
  Future<Either<Failure, Account>> call(NoParam params) async {
    final getSessionRes = await repository.getSession();

    if (getSessionRes.isLeft()) {
      return Left((getSessionRes as Left).value);
    } else {
      final String? session = (getSessionRes as Right).value;
      if (session == null) {
        return const Left(NotFoundFailure('can not find out session in database'));
      } else {
        final getAccRes = await repository.getAccount(session);
        return getAccRes;
      }
    }
  }

}