import 'package:movie_app/features/movie/domain/entities/cast.dart';

class CastModel extends Cast {
  CastModel({
    required super.adult,
    required super.gender,
    required super.id,
    required super.known_for_department,
    required super.name,
    required super.original_name,
    required super.popularity,
    required super.profile_path,
    required super.cast_id,
    required super.character,
    required super.credit_id,
    required super.order
  });

  CastModel.fromJson(Map<String, dynamic> json):
      super(
        adult: json['adult'],
        gender: json['gender'],
        id: json['id'],
        known_for_department: json['known_for_department'],
        name: json['name'],
        original_name: json['original_name'],
        popularity: json['popularity'],
        profile_path: json['profile_path'],
        cast_id: json['cast_id'],
        character: json['character'],
        credit_id: json['credit_id'],
        order: json['order']
      );
}