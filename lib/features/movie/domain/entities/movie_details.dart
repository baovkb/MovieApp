import 'package:movie_app/features/movie/domain/entities/genre.dart';

class MovieDetails {
  bool adult;
  String backdrop_path;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdb_id;
  List<String> origin_country;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  String release_date;
  int revenue;
  int runtime;
  String status;
  String tagline;
  String title;
  bool video;
  double vote_average;
  int vote_count;

  MovieDetails({
    required this.adult,
    required this.backdrop_path,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdb_id,
    required this.origin_country,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.release_date,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.vote_average,
    required this.vote_count
  });
}


