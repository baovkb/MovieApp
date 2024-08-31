import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/account/data/models/account_model.dart';
import 'package:movie_app/features/account/data/sources/local_data/session_db.dart';
import 'package:movie_app/features/account/data/sources/remote_data/account_api_client.dart';
import 'package:movie_app/features/account/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountApiClient client;
  SessionDB db;

  AccountRepositoryImpl(this.client, this.db);

  @override
  Future<Either<Failure, String>> createSession(String requestToken) async {
    try {
      final result = await client.createSession(requestToken);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, AccountModel>> getAccount(String session) async {
    try {
      final result = await client.getAccount(session);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, String>> requestToken() async {
    try {
      final result = await client.createRequestToken();
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, String?>> getSession() async {
    try {
      final result = await db.getSession();
      return Right(result);
    } catch (e) {
      return const Left(NotFoundFailure());
    }

  }

  @override
  Future<Either<Failure, bool>> saveSession(String session) async {
    try {
      await db.insertSession(session);
      return Right(true);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

}