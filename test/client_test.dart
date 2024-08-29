import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';

void main() {
  final client = MovieApiClient(http.Client());
  
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
}