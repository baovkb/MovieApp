import 'package:movie_app/features/movie/data/models/video_model.dart';
import 'package:movie_app/features/movie/domain/entities/videos_list.dart';

class VideosListModel extends VideosList {
  VideosListModel({required super.id, required super.results});

  VideosListModel.fromJson(Map<String, dynamic> json):
      super(
        id: json['id'],
        results: (json['results'] as List).map((video) => VideoModel.fromJson(video)).toList()
      );
}