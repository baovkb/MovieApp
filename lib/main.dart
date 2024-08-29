import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/movie/data/repositories/genre_repository_impl.dart';
import 'package:movie_app/features/movie/domain/usecases/genre_use_case.dart';
import 'package:movie_app/features/movie/domain/usecases/popular_movies_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_state.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_popular_movies_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_popular_movies_state.dart';
import 'package:movie_app/route/route_generator.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'features/movie/data/repositories/movies_repository_impl.dart';
import 'features/movie/data/sources/movie_api_client.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    //hide status bar and nav bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MovieApiClient client = MovieApiClient(http.Client());

    final moviesListRepo = MoviesListRepositoryImpl(client: client);
    final movieGenreRepo = GenreRepositoryImpl(client);

    final fetchPopularMoviesController = FetchPopularMoviesController(PopularMoviesUseCase(moviesListRepo));
    final fetchMovieGenreController = FetchMovieGenreController(GenreUseCase(movieGenreRepo));

    fetchPopularMoviesController.fetchPopularMovies();
    fetchMovieGenreController.fetchMovieGenres();
    
    return 
      MultiProvider(
        providers: [
          StreamProvider<FetchPopularMoviesState>(
              create: (context) => fetchPopularMoviesController.stream,
              initialData: FetchPopularMoviesInitial()
          ),
          StreamProvider<FetchMovieGenreState>(
              create: (context) => fetchMovieGenreController.stream,
              initialData: FetchMovieGenreInitial())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: CustomColor.mainColor
          ),
          initialRoute: RouteName.MAIN_PAGE,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      );
  }
}
