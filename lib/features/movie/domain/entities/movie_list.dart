import 'package:movie_app/features/movie/domain/entities/movie.dart';

class MovieList {
  int page;
  List<Movie> results;
  int total_results;
  int total_pages;

  MovieList({required this.page, required this.results, required this.total_results, required this.total_pages});
}