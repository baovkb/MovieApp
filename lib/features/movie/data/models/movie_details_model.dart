import 'package:movie_app/features/movie/domain/entities/movie_details.dart';

import 'genre_model.dart';

class MovieDetailsModel extends MovieDetails {
  MovieDetailsModel({
    required super.adult,
    required super.backdrop_path,
    required super.budget,
    required super.genres,
    required super.homepage,
    required super.id,
    required super.imdb_id,
    required super.origin_country,
    required super.original_language,
    required super.original_title,
    required super.overview,
    required super.popularity,
    required super.poster_path,
    required super.release_date,
    required super.revenue,
    required super.runtime,
    required super.status,
    required super.tagline,
    required super.title,
    required super.video,
    required super.vote_average,
    required super.vote_count});

  MovieDetailsModel.fromJson(Map<String, dynamic> json):
      super(
        adult: json['adult'],
        backdrop_path: json['backdrop_path'],
        budget: json['budget'],
        genres: (json['genres'] as List).map((genre) => GenreModel.fromJson(genre)).toList(),
        homepage: json['homepage'],
        id: json['id'],
        imdb_id: json['imdb_id'],
        origin_country: List<String>.from(json['origin_country']),
        original_language: json['original_language'],
        original_title: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        poster_path: json['poster_path'],
        release_date: json['release_date'],
        revenue: json['revenue'],
        runtime: json['runtime'],
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
        vote_average: json['vote_average'],
        vote_count: json['vote_count']
      );
}