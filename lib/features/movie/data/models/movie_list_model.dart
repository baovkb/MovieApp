import 'package:movie_app/features/movie/domain/entities/movie_list.dart';

import 'movie_model.dart';

class MovieListModel extends MovieList {
  MovieListModel({required super.page, required super.results, required super.total_results, required super.total_pages});

  MovieListModel.fromJson(Map<String, dynamic> json):
      super(
        page: json['page'],
        results: (json['results'] as List).map((movie) => MovieModel.fromJson(movie)).toList(),
        total_pages: json['total_pages'],
        total_results: json['total_results']
      );
}