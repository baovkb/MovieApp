import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/account/domain/entities/account.dart';

abstract class AccountRepository {
  Future<Either<Failure, String>> requestToken();
  Future<Either<Failure, String>> createSession(String requestToken);
  Future<Either<Failure, Account >> getAccount(String session);
  Future<Either<Failure, bool>> saveSession(String session);
  Future<Either<Failure, String?>> getSession();
}