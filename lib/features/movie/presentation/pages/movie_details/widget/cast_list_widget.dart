import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/movie/domain/entities/casts_list.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/cast/fetch_cast_state.dart';
import 'package:movie_app/features/movie/data/repositories/casts_list_repository_impl.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/usecases/cast_by_movie_id_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/cast/fetch_cast_by_movie_id_controller.dart';

class CastListWidget extends StatefulWidget {
  int movie_id;
  CastListWidget({super.key, required this.movie_id});

  @override
  State<CastListWidget> createState() => _CastListWidgetState();
}

class _CastListWidgetState extends State<CastListWidget> {
  final _fetchCastByMovieIDController = FetchCastByMovieIDController(
      CastByMovieIDUseCase(
          CastListRepositoryImpl(
              MovieApiClient(Client())))
  );
  
  @override
  void initState() {
    super.initState();
    _fetchCastByMovieIDController.fetchCastByMovieID(widget.movie_id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FetchCastState>(
        stream: _fetchCastByMovieIDController.stream, 
        initialData: FetchCastInitial(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white,),);
          } else if (snapshot.hasData) {
            if (snapshot.data is FetchCastInitial) {
              return const Center(child: CircularProgressIndicator(color: Colors.white,),);
            } else if (snapshot.data is FetchCastLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.white,),);
            } else if (snapshot.data is FetchCastLoaded) {
              return _buildCastList(context, (snapshot.data as FetchCastLoaded).castsList);
            } else if (snapshot.data is FetchCastError) {
              return const Center(
                child: Text('Something happened',
                  style: TextStyle(color: Colors.white),),);
            } else {
              return const Center(
                child: Text('Unknown Error',
                  style: TextStyle(color: Colors.white),),);
            }
          } else {
            return const Center(
              child: Text('Fail to create controller',
                style: TextStyle(color: Colors.white),),);
          }
        });
  }

  @override
  void dispose() {
    _fetchCastByMovieIDController.dispose();
    super.dispose();
  }
  
  Widget _buildCastList(BuildContext context, CastsList castList) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castList.cast.length,
        itemBuilder: (context, position) {
          final cast = castList.cast[position];
          String profile_path = 'https://image.tmdb.org/t/p/w200/${cast.profile_path}';

          return Container(
            margin: EdgeInsets.only(right: 8),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1
                    ),
                    image: DecorationImage(
                        image: NetworkImage(profile_path),
                        fit: BoxFit.cover),
                  ),
                ),
                Text(cast.name)
              ]
            ),
          ); 
        });
  }
}
