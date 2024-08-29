import 'package:movie_app/features/movie/domain/entities/genre.dart';

class GenreModel extends Genre {
  GenreModel({required super.id, required super.name});

  GenreModel.fromJson(Map<String, dynamic> json):
        super(
          id: json['id'],
          name: json['name']
        );
}