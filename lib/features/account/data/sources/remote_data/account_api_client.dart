import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:movie_app/features/account/data/models/account_model.dart';
import 'package:movie_app/features/movie/data/models/movie_list_model.dart';

import '../../../../../core/error/failure.dart';

class AccountApiClient {
  late final Client client;
  final String BASE_URL = 'https://api.themoviedb.org/3/';
  final apiKey = '82e727c9d7165d9aabe9bce38c40ac89';

  AccountApiClient(this.client);

  Future<String> createRequestToken() async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('authentication/token/new?api_key=$apiKey'));
    return _handleResponse(response)['request_token'];
  }

  Future<String> createSession(String requestToken) async {
    final response = await client.post(
      Uri.parse(BASE_URL).resolve('authentication/session/new?api_key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'request_token': requestToken})
    );
    return _handleResponse(response)['session_id'];
  }
  
  Future<AccountModel> getAccount(String session) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('account?api_key=$apiKey&session_id=$session'));
    return AccountModel.fromJson(_handleResponse(response));
  }

  Future<MovieListModel> getFavoriteMovies(int account_id, String session) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('account/$account_id/favorite/movies?api_key=$apiKey&session_id=$session'));
    return MovieListModel.fromJson(_handleResponse(response));
  }

  Future<bool> addFavoriteMovie(int account_id, String session, int movie_id, {bool favorite = true}) async {
    final response = await client.post(
      Uri.parse(BASE_URL).resolve('account/$account_id/favorite?api_key=$apiKey&session_id=$session'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'media_type': 'movie',
          'media_id': movie_id,
          'favorite': favorite,
        }),
    );
    return _handleResponse(response)['success'];
  }

  Map<String, dynamic> _handleResponse(final Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw const ClientError('client error');
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      throw const ServerFailure('server error');
    } else {
      throw const ClientError('client error');
    }
  }
}