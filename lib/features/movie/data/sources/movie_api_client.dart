import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movie/data/models/casts_list_model.dart';
import 'package:movie_app/features/movie/data/models/genre_model.dart';
import 'package:movie_app/features/movie/data/models/movie_details_model.dart';
import 'package:movie_app/features/movie/data/models/movie_list_model.dart';
import 'package:movie_app/features/movie/data/models/videos_list_model.dart';
import 'package:movie_app/features/movie/domain/entities/movie_details.dart';

class MovieApiClient {
  late final http.Client client;
  final String BASE_URL = "https://api.themoviedb.org/3/";
  final String apiKey = '82e727c9d7165d9aabe9bce38c40ac89';

  MovieApiClient(this.client);

  Future<MovieListModel> fetchPopularMovies() async{
    final response = await client.get(Uri.parse(BASE_URL).resolve('movie/popular?api_key=$apiKey'));

    return MovieListModel.fromJson(_handleResponse(response));
  }

  Future<MovieListModel> fetchTopRatedMovies() async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('movie/top_rated?api_key=$apiKey'));

    return MovieListModel.fromJson(_handleResponse(response));
  }

  Future<List<GenreModel>> fetchMovieGenres() async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('genre/movie/list?api_key=$apiKey'));
    return (_handleResponse(response)['genres'] as List).map((genre) => GenreModel.fromJson(genre)).toList();
  }

  Future<MovieListModel> fetchMoviesByGenre(int genre_id) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('discover/movie?with_genres=$genre_id&api_key=$apiKey'));
    return MovieListModel.fromJson(_handleResponse(response));
  }

  Future<MovieDetailsModel> fetchMovieDetails(int id) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('movie/$id?api_key=$apiKey'));
    return MovieDetailsModel.fromJson(_handleResponse(response));
  }
  
  Future<CastsListModel> fetchCastByMovieID(int id) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('movie/$id/credits?api_key=$apiKey'));
    return CastsListModel.fromJson(_handleResponse(response));
  }
  
  Future<MovieListModel> fetchSimilarMovies(int id) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('movie/$id/similar?api_key=$apiKey'));
    return MovieListModel.fromJson(_handleResponse(response));
  }

  Future<VideosListModel> fetchVideosList(int id) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('movie/$id/videos?api_key=$apiKey'));
    return VideosListModel.fromJson(_handleResponse(response));
  }

  Future<MovieListModel> searchMovies(String query) async {
    final response = await client.get(Uri.parse(BASE_URL).resolve('search/movie?query=$query&api_key=$apiKey'));
    debugPrint(response.request.toString());
    return MovieListModel.fromJson(_handleResponse(response));
  }

   Map<String, dynamic> _handleResponse(final http.Response response) {
    switch(response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw const ClientError('client error');
      case 500:
        throw const ServerFailure('server error');
      default:
        debugPrint(response.body);
        throw const ClientError('client error');
    }
  }
}