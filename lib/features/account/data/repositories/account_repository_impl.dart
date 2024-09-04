import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/account/data/models/account_model.dart';
import 'package:movie_app/features/account/data/sources/local_data/account_db.dart';
import 'package:movie_app/features/account/data/sources/remote_data/account_api_client.dart';
import 'package:movie_app/features/account/domain/repositories/account_repository.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountApiClient client;
  AccountDB db;

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
  Future<Either<Failure, Map<String, Object?>>> getRecord() async {
    try {
      final result = await db.getRecord();
      return result != null ? Right(result) : Left(NotFoundFailure());
    } catch (e) {
      return const Left(NotFoundFailure());
    }

  }

  @override
  Future<Either<Failure, bool>> saveSession(String session) async {
    try {
      await db.insert(session: session);
      return Right(true);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, MovieList>> getFavoriteMovies(int account_id, String session) async {
    try {
      final result = await client.getFavoriteMovies(account_id, session);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, bool>> saveAccountID(int account_id) async {
    try {
      final result = await db.update({
        'account_id': account_id
      });
      return result == 1 ? Right(true) : Left(CacheFailure());
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }

  @override
  Future<Either<Failure, bool>> addFavoriteMovie(int account_id, String session, int movie_id, {bool favorite = true}) async {
    try {
      final result = await client.addFavoriteMovie(account_id, session, movie_id, favorite: favorite);
      return Right(result);
    } catch (e) {
      return e is Failure ? Left(e) : Left(UnknownError());
    }
  }

}