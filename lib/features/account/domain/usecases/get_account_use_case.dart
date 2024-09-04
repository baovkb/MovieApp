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
    final getSessionRes = await repository.getRecord();

    if (getSessionRes.isLeft()) {
      return Left((getSessionRes as Left).value);
    } else {
      Map<String, Object?> record = (getSessionRes as Right).value;
      final String? session = record['session'] as String?;
      final int? account_id = record['account_id'] as int?;

      debugPrint(record.toString());

      if (session == null) {
        return const Left(NotFoundFailure('can not find out session in database'));
      } else {
        final getAccRes = await repository.getAccount(session);
        if (getAccRes.isRight()) {
          Account account = (getAccRes as Right).value as Account;

          if (account_id == null || account_id != account.id) {
            final saveAccRes = await repository.saveAccountID(account.id);

            if (saveAccRes.isRight()) {
              return Right((getAccRes as Right).value);
            } else return Left((saveAccRes as Left).value);
          } else return Right((getAccRes as Right).value);
        } else {
          return (getAccRes as Left).value;
        }
      }
    }
  }

}