import 'package:movie_app/features/movie/domain/entities/video.dart';

class VideosList {
  int id;
  List<Video> results;

  VideosList({required this.id, required this.results});
}