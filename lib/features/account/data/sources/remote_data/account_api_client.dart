import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/features/account/data/models/account_model.dart';

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

  Map<String, dynamic> _handleResponse(final Response response) {
    switch(response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw const ClientError('client error');
      case 500:
        throw const ServerFailure('server error');
      default:
        throw const ClientError('client error');
    }
  }
}