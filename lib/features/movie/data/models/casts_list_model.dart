import 'package:movie_app/features/movie/data/models/cast_model.dart';
import 'package:movie_app/features/movie/domain/entities/casts_list.dart';

class CastsListModel extends CastsList {
  CastsListModel({
    required super.id,
    required super.cast
  });

  CastsListModel.fromJson(Map<String, dynamic> json) :
      super(
        id: json['id'],
        cast: (json['cast'] as List).map((cast) => CastModel.fromJson(cast)).toList()
      );
}