import 'package:movie_app/features/movie/domain/entities/video.dart';

class VideoModel extends Video {
  VideoModel({
    required super.name,
    required super.key,
    required super.site,
    required super.type,
    required super.official,
    required super.published_at,
    required super.id});

  VideoModel.fromJson(Map<String, dynamic> json):
      super(
        name: json['name'],
        key: json['key'],
        site: json['site'],
        type: json['type'],
        official: json['official'],
        published_at: json['published_at'],
        id: json['id']
      );
}