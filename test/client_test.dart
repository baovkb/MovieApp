import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/data/repositories/account_repository_impl.dart';
import 'package:movie_app/features/account/data/sources/local_data/database.dart';
import 'package:movie_app/features/account/data/sources/local_data/session_db.dart';
import 'package:movie_app/features/account/data/sources/remote_data/account_api_client.dart';
import 'package:movie_app/features/account/domain/usecases/get_account_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/account/get_account_bloc.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';

void main() {
  final client = MovieApiClient(http.Client());
  AccountApiClient accountApiClient = AccountApiClient(http.Client());
  
  test('test client class', ()  async {
    final result = await client.fetchPopularMovies();
    print(result?.total_results);
  });

  test('test fetch movie by id', () async {
    final result = await client.fetchMoviesByGenre(28);
    print(result?.total_results);
  });
  
  test('test fetch movie detail', () async {
    final result = await client.fetchMovieDetails(533535);
    print(result?.title);
  });

  test('test fetch cast', () async {
    final result = await client.fetchCastByMovieID(533535);
    print(result?.id);
  });

  test('test similar movies', () async {
    final result = await client.fetchSimilarMovies(533535);
    print(result?.total_results);
  });

  test('test video', () async {
    final result = await client.fetchVideosList(533535);
    print(result?.id);
  });

  test('test get account', () async {
    final result = await accountApiClient.getAccount('9f8f75d376bcdc870edd45f4a950c422c0f04b1f');
    print(result.toString());
  });

  test('test request token', () async {
    // final Tokenresult = await apiClient.createRequestToken();
    // print('token: $Tokenresult');

    SessionDB sessionDB = SessionDB();
    String? session = await sessionDB.getSession();
    debugPrint('session: $session');
    await sessionDB.insertSession('test session');
    session = await sessionDB.getSession();
    debugPrint('session: $session');
    // GetAccountUseCase useCase = GetAccountUseCase(AccountRepositoryImpl(apiClient, sessionDB));
    // final result = await useCase.call(NoParam());
    // if (result.isLeft()) print((result as Left).value.runtimeType);
  });
}