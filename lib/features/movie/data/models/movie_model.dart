import 'package:movie_app/features/movie/domain/entities/movie.dart';

class MovieModel extends Movie {

  MovieModel(
      bool adult,
      String backdrop_path,
      List<int> genre_ids,
      int id,
      String original_language,
      String original_title,
      String overview,
      double popularity,
      String poster_path,
      String release_date,
      String title,
      bool video,
      double vote_average,
      int vote_count) :
        super(
          adult: adult,
          backdrop_path: backdrop_path,
          genre_ids: genre_ids,
          id: id,
          original_language: original_language,
          original_title: original_title,
          overview: overview,
          popularity: popularity,
          poster_path: poster_path,
          release_date: release_date,
          title: title,
          video: video,
          vote_average: vote_average,
          vote_count: vote_count
      );

  MovieModel.fromJson(Map<String, dynamic> json):
    super(
        adult: json['adult'],
        backdrop_path: json['backdrop_path'],
        genre_ids: (json['genre_ids'] as List).map((genre) => genre as int).toList(),
        id: json['id'],
        original_language: json['original_language'],
        original_title: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        poster_path: json['poster_path'],
        release_date: json['release_date'],
        title: json['title'],
        video: json['video'],
        vote_average: json['vote_average'],
        vote_count: json['vote_count']
    );


}