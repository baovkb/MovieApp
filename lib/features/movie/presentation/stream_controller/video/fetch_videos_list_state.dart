import 'package:movie_app/features/movie/domain/entities/videos_list.dart';

abstract class FetchVideoListState {}

class FetchVideosListInitial extends FetchVideoListState {}

class FetchVideosListLoading extends FetchVideoListState {}

class FetchVideosListLoaded extends FetchVideoListState {
  final VideosList videosList;

  FetchVideosListLoaded(this.videosList);
}

class FetchVideosListError extends FetchVideoListState {
  final dynamic message;

  FetchVideosListError(this.message);
}