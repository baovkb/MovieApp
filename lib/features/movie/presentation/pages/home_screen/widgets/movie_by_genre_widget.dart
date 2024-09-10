import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/movie/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/entities/genre.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/usecases/movies_by_genre_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_state.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_movies_by_genre_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_movies_by_genre_state.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:provider/provider.dart';

class MovieByGenreWidget extends StatelessWidget {
  const MovieByGenreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchMovieGenreState>(
      builder: (context, movieGenreState, child) {
        if (movieGenreState is FetchMovieGenreInitial) {
          return const Center(child:
            Text('Please wait...'));
        } else if (movieGenreState is FetchMovieGenreLoading) {
          return const Center(child: CircularProgressIndicator(),
          );
        } else if (movieGenreState is FetchMovieGenreLoaded) {
          return _BuildMoviesByGenreWidget(genreList: movieGenreState.genreList,);
        } else if (movieGenreState is FetchMovieGenreError) {
          return const Center(child: Text('Something happened'),);
        } else {
          return const Center(child: Text('Unknown error'),);
        }
      },
    );
  }

}

class _BuildMoviesByGenreWidget extends StatefulWidget {
  final List<Genre> genreList;

  const _BuildMoviesByGenreWidget({super.key, required this.genreList});

  @override
  State<_BuildMoviesByGenreWidget> createState() => _BuildMoviesByGenreWidgetState();
}

class _BuildMoviesByGenreWidgetState extends State<_BuildMoviesByGenreWidget> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.genreList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final genreList = widget.genreList;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 380,
      child: Scaffold(
        // backgroundColor: CustomColor.mainColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: AppBar(
            bottom: TabBar(
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(),
                controller: _tabController,
                indicatorColor: colorScheme.onSurface,
                unselectedLabelColor: colorScheme.onSurface.withOpacity(0.55),
                labelColor: colorScheme.onSurface,
                isScrollable: true,
                labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                tabs: genreList.map((genre) => Text(genre.name)).toList()
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          child: TabBarView(
              controller: _tabController,
              children: genreList.map((genre) => _GenreMovie(genre_id: genre.id)).toList(),
          ),
        ),
      ),
    );
  }
}

class _GenreMovie extends StatelessWidget {
  final genre_id;

  const _GenreMovie({super.key, required this.genre_id});

  @override
  Widget build(BuildContext context) {
    final fetchMoviesByGenreController = FetchMoviesByGenreController(
        MoviesByGenreUseCase(
            MoviesListRepositoryImpl(
                client: MovieApiClient(Client()))));

    fetchMoviesByGenreController.fetchMoviesByGenre(genre_id);
    // debugPrint('genre_id: ${genre_id}');

    return StreamBuilder(
        stream: fetchMoviesByGenreController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is FetchMoviesByGenreInitial) {
              return const Center(child:
              Text('Please wait...',),);
            } else if (snapshot.data is FetchMoviesByGenreLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data is FetchMoviesByGenreLoaded) {
              MovieList movieList = (snapshot.data as FetchMoviesByGenreLoaded).movieList;

              return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieList.results.length,
                  itemBuilder: (context, position) => MovieWidget(
                      movie: movieList.results[position],
                      onTap: (id) => {
                        Navigator.pushNamed(context,
                          RouteName.MOVIE_DETAILS,
                          arguments: <String, int> {
                              'movie_id': id
                            })
                      },));
            } else if (snapshot.data is FetchMoviesByGenreError) {
              return const Center(child: Text('Something happened'),);
            } else {
              return const Center(child: Text('Unknown error'),);
            }
          } else {
            return const Center(child: Text('Unknown error'),);
          }
        });
  }
}


