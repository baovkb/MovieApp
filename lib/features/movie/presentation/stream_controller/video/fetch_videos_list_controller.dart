import 'dart:async';

import 'package:movie_app/features/movie/domain/usecases/videos_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/video/fetch_videos_list_state.dart';

class FetchVideosListController {
  StreamController<FetchVideoListState> streamController = StreamController();
  VideosUseCase useCase;

  FetchVideosListController(this.useCase);

  Stream<FetchVideoListState> get stream => streamController.stream;

  void fetchVideosList(int id) async {
    streamController.add(FetchVideosListLoading());

    final result = await useCase.call(id);
    result.fold(
        (failure) => streamController.add(FetchVideosListError(failure.message)),
        (videos) => streamController.add(FetchVideosListLoaded(videos)));
  }

  void dispose() {
    streamController.close();
  }
}