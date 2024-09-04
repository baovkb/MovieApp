import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/account/domain/entities/account.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

abstract class AccountRepository {
  Future<Either<Failure, String>> requestToken();
  Future<Either<Failure, String>> createSession(String requestToken);
  Future<Either<Failure, Account >> getAccount(String session);
  Future<Either<Failure, bool>> saveSession(String session);
  Future<Either<Failure, bool>> saveAccountID(int account_id);
  Future<Either<Failure, Map<String, Object?>>> getRecord();
  Future<Either<Failure, MovieList>> getFavoriteMovies(int account_id, String session);
  Future<Either<Failure, bool>> addFavoriteMovie(int account_id, String session, int movie_id, {bool favorite = true});
}